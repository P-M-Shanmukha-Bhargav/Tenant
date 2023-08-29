import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenantapp/helpers/startup_data.dart';
import 'package:tenantapp/common/Constants.dart';
import 'package:tenantapp/screens/tenant/tenant_home.dart';
import 'package:tenantapp/screens/login.dart';
import 'package:tenantapp/screens/owner/owner_home.dart';

import 'helpers/auth.dart';
import 'helpers/auth_provider.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPage createState() => _RootPage();
}

class _RootPage extends State<RootPage> {

  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth as BaseAuth;
    return StreamBuilder<String>(
        stream: auth.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            final bool isLoggedIn = snapshot.hasData;
            return isLoggedIn ? _LoginBasedOnLoginType(): LoginPage();
          }
          return _buildWaitingScreen();
        }
    );
  }

  @override
  void initState() {

  }

  Widget _LoginBasedOnLoginType(){
    if(Auth().getCurentUserRole().toString() == "true"){
      return OwnerHomePage();
    }
    else{
      return TenantHomePage();
    }
  }

  Widget _buildWaitingScreen(){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}