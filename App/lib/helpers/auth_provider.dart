import 'package:flutter/material.dart';
import 'package:houseapp/helpers/auth.dart';

class AuthProvider extends InheritedWidget{

  AuthProvider({Key? key, required Widget child, required this.auth}): super(key: key, child: child);
  final BaseAuth auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<AuthProvider>()) as AuthProvider;
  }
}