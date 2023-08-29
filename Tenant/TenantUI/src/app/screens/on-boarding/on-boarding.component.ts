import { Component, Inject, inject, OnInit } from '@angular/core';
import { FormGroup, UntypedFormBuilder, UntypedFormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-on-boarding',
  templateUrl: './on-boarding.component.html',
  styleUrls: ['./on-boarding.component.css'],
  providers: [
  ],
})
export class OnBoardingComponent implements OnInit {
  loginValidate!: UntypedFormGroup;
  registerValidate!: UntypedFormGroup;
  gridStyle = {
    width: '50%',
    textAlign: 'center'
  };

  readonly screenInfo = window.localStorage.getItem("boardingScreen");
  registerScreenInfo = window.localStorage.getItem("registerScreen");
  constructor(private fb: UntypedFormBuilder) {}

  ngOnInit(): void {
    this.loginValidate = this.fb.group({
      emailid: [null, [Validators.required, Validators.email]],
      password: [null, [Validators.required]]});
    
    this.registerValidate = this.fb.group({
      emailid: [null, [Validators.required]],
      password: [null, [Validators.required, Validators.pattern('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&].{8,}')]],
      displayName: [null, [Validators.required]],
      phoneNumber: [null, [Validators.required]],
      aadharNumber: [null],
      upiId: [null]
    }, {validators: this.customValidationFunction });
  }

  customValidationFunction(formGroup: FormGroup): any {
    if (formGroup) {
      if(formGroup.controls['aadharNumber'].value || formGroup.controls['upiId'].value) {
        return null;
      }
    }
    return {'error': true};
 }

  setRegisterScreen(screen: any){
    window.localStorage.setItem("registerScreen", screen);
    this.registerScreenInfo = screen;
  }

  backToScreen(){
    window.localStorage.setItem("registerScreen", 'select');
    this.registerScreenInfo = 'select';
  }
}
