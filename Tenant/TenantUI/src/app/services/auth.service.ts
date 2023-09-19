import { Injectable, NgZone } from '@angular/core';

import {
  AngularFirestore,
  AngularFirestoreDocument,
} from '@angular/fire/compat/firestore';
import { getAuth, PhoneAuthProvider, User, UserInfo } from 'firebase/auth';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import { Router } from '@angular/router';
import { isObservable, Observable } from 'rxjs';
import { Register } from '../models/request/register';


@Injectable({
  providedIn: 'root',
})
export class AuthService {
  userData: any; // Save logged in user data

  constructor(
    private afAuth: AngularFireAuth, // Inject Firebase auth service
    private router: Router,
    private ngZone: NgZone, // NgZone service to remove outside scope warning
    private fbs: AngularFirestore
  ) {
    /* Saving user data in localstorage when 
    logged in and setting up null when logged out */
    this.afAuth.onAuthStateChanged((user) => {
      if (user) {
        this.userData = user;
        this.saveSession(this.userData);
        localStorage.setItem('user', JSON.stringify(user));
        this.getUserRoles();
      } else {
        this.SignOut();
      }
    });
  }

  // Sign in with email/password
  SignIn(email: string, password: string) {
    return this.afAuth
      .signInWithEmailAndPassword(email, password);
  }

  SignUp(register: Register){
    return this.afAuth
      .createUserWithEmailAndPassword(register.emailId, register.password);
  }

  addUserInDatabase(uid: string, role: string){
    return this.fbs.collection("users")
      .doc(uid)
      .set({
        "userTypeId": role == "tenant" ? 1 : 2,
      });
  }

  // Send email verfificaiton when new user sign up
  SendVerificationMail() {
    return this.afAuth.currentUser
      .then((u: any) => u.sendEmailVerification());
  }

  // Reset Forggot password
  ForgotPassword(passwordResetEmail: string) {
    return this.afAuth
      .sendPasswordResetEmail(passwordResetEmail)
      .then(() => {
        window.alert('Password reset email sent, check your inbox.');
      })
      .catch((error) => {
        window.alert(error);
      });
  }

  // Returns true when user is looged in and email is verified
  get isLoggedIn(): boolean {
    let session = this.getSession();
    if (!session) {
      return false;
    }

    // check if token is expired - '30-03-2023 17:58:48'
    const jwtToken = JSON.parse(atob(session.accessToken.split('.')[1]));
    var dateTime = new Date(jwtToken.exp * 1000);
    const tokenExpired = new Date() > dateTime;

    return !tokenExpired;
  }

  get displayName(): string{
    return JSON.parse(window.localStorage.getItem("user")!).displayName;
  }

  // Sign out
  SignOut() {
    this.afAuth.signOut().then(() => {
      localStorage.removeItem('user');
      localStorage.removeItem('ID');
      localStorage.removeItem('RT');
      localStorage.removeItem('AT');
      localStorage.removeItem('boardingScreen');
      localStorage.removeItem('userData');
      this.router.navigate(['']);
    });
  }

  saveSession(user: any): void{
    window.localStorage.setItem('RT', user.refreshToken);
    window.localStorage.setItem('ID', user.uid.toString());
    user.getIdToken().then((token: string) => this.saveReSession(token));
  }

  saveReSession(token: string): void{
    window.localStorage.setItem('AT', token);
  }

  getSession(): any | null {
    if (window.localStorage.getItem('AT') !== 'undefined' &&
         window.localStorage.getItem('AT') !== undefined &&
         window.localStorage.getItem('AT') !== 'null' &&
         window.localStorage.getItem('AT') !== null) {
      const tokenResponse = {
        accessToken: window.localStorage.getItem('AT') || '',
        uid: window.localStorage.getItem('ID') || 0
      };

      return tokenResponse;
    }
    return null;
  }

  async refreshToken():Promise<string | undefined>{
    var user = await this.afAuth.currentUser;
    return user?.getIdToken(true);
  }

  getUserRoles(): any| null{
    this.fbs.collection("users")
      .doc(localStorage.getItem("ID")?.toString())
      .get()
      .subscribe((res) => {

        localStorage.setItem("userData", JSON.stringify(res.data()));
        
        if(JSON.parse(window.localStorage.getItem("userData")!).userTypeId == 1){
          this.router.navigate(["home"]);
        }
        else if(JSON.parse(window.localStorage.getItem("userData")!).userTypeId == 2){
          this.router.navigate(["dashboard"]);
        }

      }, (err) => console.error(err));
  }
}
