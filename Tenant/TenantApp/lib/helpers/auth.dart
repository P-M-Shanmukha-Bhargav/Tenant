import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tenantapp/main.dart';
import 'package:tenantapp/common/Constants.dart';

abstract class BaseAuth{
  Future<void> verifyMobilePin(String pin, String phone, String verId, BuildContext context);
  Future<User?> currentUserData();
  Future<void> signOut();
  Stream<String> get onAuthStateChanged;
  String? getCurentUserId();
  void setCurrentUserId(String userNo);
  bool? getCurentUserRole();
  void setCurrentUserRole(bool isOwner);
  String? getCurentTenantRoomId();
  void setCurentTenantRoomId(String roomId);
}

class Auth implements BaseAuth{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String> get onAuthStateChanged{
    return _firebaseAuth.authStateChanges().map((User? user) => user!.uid);
  }

  Future<User?> currentUserData() async{
    User? user = await _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async{
    return _firebaseAuth.signOut();
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
        final snackBar = SnackBar(content: Text("OTP Verifed"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }on FirebaseAuthException catch(e){
      final snackBar = SnackBar(content: Text("${e.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  String? getCurentUserId() {
    return startupData.sharedPreferences.getString(USERID);
  }

  @override
  void setCurrentUserId(String userId) {
    startupData.sharedPreferences.setString(USERID, userId);
  }

  @override
  bool? getCurentUserRole() {
    return startupData.sharedPreferences.getBool(ISOWNER);
  }

  @override
  void setCurrentUserRole(bool isOwner) {
    startupData.sharedPreferences.setBool(ISOWNER, isOwner);
  }

  @override
  String? getCurentTenantRoomId() {
    return startupData.sharedPreferences.getString(ROOMID);
  }

  @override
  void setCurentTenantRoomId(String roomId) {
    startupData.sharedPreferences.setString(ROOMID, roomId);
  }
}