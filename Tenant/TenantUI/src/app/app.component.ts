import { Component } from '@angular/core';
import { Router } from '@angular/router';

import { NzModalService } from 'ng-zorro-antd/modal';
import { NzMessageService } from 'ng-zorro-antd/message';

import { OnBoardingComponent } from './screens/on-boarding/on-boarding.component';
import { UserService } from './services/user.service';
import { Login } from './models/request/login';
import { Register } from './models/request/register';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { AuthService } from './services/auth.service';
import { ScreenInfo } from './models/screen-info';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Tenant App';
  isUserLoggedIn = false;
  displayName = "";
  
  constructor(private modalService: NzModalService, private userService: UserService,
    private message: NzMessageService, private router: Router,
    private notification: NzNotificationService, private authService: AuthService) {
      this.isUserLoggedIn = this.authService.isLoggedIn;
      if(this.isUserLoggedIn && window.localStorage.getItem("user") !== 'null'){
        this.displayName = this.authService.displayName;
        if(JSON.parse(window.localStorage.getItem("userData")!).roles.isTenant){
          this.router.navigate(["home"]);
        }
        else if(JSON.parse(window.localStorage.getItem("userData")!).roles.isOwner){
          this.router.navigate(["dashboard"]);
        }
      }
      else if(window.localStorage.getItem("user") !== 'null'){
        this.authService.refreshToken()
          .then((val) => { 
            this.authService.saveReSession(val!); 
            if(JSON.parse(window.localStorage.getItem("userData")!).roles.isTenant){
              this.router.navigate(["home"]);
            }
            else if(JSON.parse(window.localStorage.getItem("userData")!).roles.isOwner){
              this.router.navigate(["dashboard"]);
            }
            this.isUserLoggedIn = this.authService.isLoggedIn;
          })
      }
      else{
        this.authService.SignOut();
      }
  }

  loginModal(): void {
    window.localStorage.setItem("boardingScreen", "signIn");
    var signInModal = this.modalService.create({
      nzTitle: 'Sign In',
      nzContent: OnBoardingComponent,
      nzStyle: {top:'20px'},
      nzFooter: [
        {
          label: 'Cancel',
          danger: true,
          loading: false,
          onClick: componentInstance => {
            signInModal.destroy();
          }
        },
        {
          label: 'SignIn',
          loading: false,
          onClick: componentInstance => {
            if(componentInstance != null){
              if (componentInstance.loginValidate.valid) {
                let loginVal: Login = {
                  emailId: componentInstance.loginValidate.value.emailid,
                  password: componentInstance.loginValidate.value.password
                }

                this.authService.SignIn(componentInstance.loginValidate.value.emailid,
                  componentInstance.loginValidate.value.password)
                  .then((result) => {
                    this.message.success("Logged In");

                    localStorage.setItem('user', JSON.stringify(result.user));
                    this.authService.saveSession(result.user);
                    result.user?.getIdToken().then((token) => {
                      this.authService.saveReSession(token);
                      this.isUserLoggedIn = this.authService.isLoggedIn;
                      this.displayName = this.authService.displayName;
                      this.router.navigate(["home"]);
                      signInModal.destroy();
                    });
                }).catch((err) => this.notification.error("Error", err));
              } 
              else {
                Object.values(componentInstance.loginValidate.controls).forEach(control => {
                  if (control.invalid) {
                    control.markAsDirty();
                    control.updateValueAndValidity({ onlySelf: true });
                  }
                });
              }
            }
          }
        }
      ]
    });
  }

  registerModal(): void {
    window.localStorage.setItem("boardingScreen", "signUp");
    window.localStorage.setItem("registerScreen", "select");
    var signUpModal = this.modalService.create({
      nzTitle: 'Register',
      nzContent: OnBoardingComponent,
      nzStyle: {top:'20px'},
      nzFooter: [
        {
          label: 'Cancel',
          danger: true,
          loading: false,
          onClick: componentInstance => {
            signUpModal.destroy();
          }
        },
        {
          label: 'Register',
          loading: false,
          onClick: componentInstance => {
            if(componentInstance != null){
              if (componentInstance.registerValidate.valid) {
                let registerVal: Register = {
                  emailId: componentInstance.loginValidate.value.emailid,
                  password: componentInstance.loginValidate.value.password,
                  displayName: componentInstance.loginValidate.value.displayName,
                  aadharNumber: componentInstance.loginValidate.value.aadharNumber,
                  phoneNumber: componentInstance.loginValidate.value.phoneNumber,
                  upiId: componentInstance.loginValidate.value.upiId
                }
                this.authService.SignUp(registerVal).then(result => {
                  result.user?.updateProfile({
                      displayName: registerVal.displayName,
                      photoURL: null
                    });
                    this.message.success("Logged In");
                    var role = window.localStorage.getItem("registerScreenInfo");
                    this.authService.addUserInDatabase(result.user?.uid!, role!)
                      .then((val) => {
                        localStorage.setItem('user', JSON.stringify(result.user));
                        this.authService.saveSession(result.user);
                        result.user?.getIdToken().then((token) => {
                          this.authService.saveReSession(token);
                          this.isUserLoggedIn = this.authService.isLoggedIn;
                          this.displayName = this.authService.displayName;
                          // this.authService.SendVerificationMail();
                          this.router.navigate(["dashboard"]);
                          signUpModal.destroy();
                        });
                      });
                  });

              } else {
                Object.values(componentInstance.registerValidate.controls).forEach(control => {
                  if (control.invalid) {
                    control.markAsDirty();
                    control.updateValueAndValidity({ onlySelf: true });
                  }
                });
              }
            }
          }
        }
      ]
    });
  }

  Logout(): void{
    this.isUserLoggedIn = false;
    this.authService.SignOut();
  }

  Home(){
    if(JSON.parse(window.localStorage.getItem("userData")!).roles.isTenant){
      this.router.navigate(["home"]);
    }
    else if(JSON.parse(window.localStorage.getItem("userData")!).roles.isOwner){
      this.router.navigate(["dashboard"]);
    }
  }
}
