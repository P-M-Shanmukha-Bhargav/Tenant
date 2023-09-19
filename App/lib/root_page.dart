import 'package:flutter/material.dart';
import 'package:houseapp/screens/LoginPage.dart';
import 'package:houseapp/helpers/auth_provider.dart';
import 'package:houseapp/screens/HomePage.dart';
import 'helpers/auth.dart';

class RootPage extends StatefulWidget{
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPage();
}

class _RootPage extends State<RootPage>{
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? const HomePage(): const LoginPage();
        }
        return _buildWaitingScreen();
      }
    );
  }

  Widget _buildWaitingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}