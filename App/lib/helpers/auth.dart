import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:houseapp/main.dart';
import 'package:houseapp/models/Constants.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';

abstract class BaseAuth{
  Future<String?> signIn(String email, String password);
  Future<String?> createUser(String email, String password);
  void forgotPassword(String email);

  Future<void> verifyMobilePin(String pin, String phone, String verId, BuildContext context);

  Future<ConfirmationResult> signInWithPhoneNumber(String phone);
  Future<UserCredential> confirmOtp(ConfirmationResult confirmationResult, String code);

  User? currentUserData();
  Future<void> signOut();
  Stream<String> get onAuthStateChanged;
  String? getCurrentUserId();
  void setCurrentUserId(String userNo);
}

class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String> get onAuthStateChanged{
    return _firebaseAuth.authStateChanges().map((User? user) => user!.uid);
  }

  @override
  User? currentUserData(){
    User? user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }

  @override
  String? getCurrentUserId() {
    return startupData.sharedPreferences.getString(USERID);
  }

  @override
  void setCurrentUserId(String userId) {
    startupData.sharedPreferences.setString(USERID, userId);
  }

  @override
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if(user.user != null) {
        setCurrentUserId(user.user!.uid);
        return user.user!.uid;
      }
      else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> createUser(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if(user.user != null) {
        setCurrentUserId(user.user!.uid);
        return user.user!.uid;
      }
      else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> verifyMobilePin(String pin, String phone, String verId, BuildContext context) async {
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

    try{
      FirebaseFirestore.instance
          .collection(USERS)
          .doc(phone)
          .get().then((userData) {
        //setCurrentUserRole(userData.get("isOwner"));
        _firebaseAuth.signInWithCredential(credential);
        const snackBar = SnackBar(content: Text("OTP Verified"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }on FirebaseAuthException catch(e){
      final snackBar = SnackBar(content: Text("${e.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Future<ConfirmationResult> signInWithPhoneNumber(String phone) async{
    return await _firebaseAuth.signInWithPhoneNumber(phone, RecaptchaVerifier(auth: FirebaseAuthWeb.instance,
    ));
  }

  @override
  Future<UserCredential> confirmOtp(ConfirmationResult confirmationResult, String code) async{
    return await confirmationResult.confirm(code);
  }
}