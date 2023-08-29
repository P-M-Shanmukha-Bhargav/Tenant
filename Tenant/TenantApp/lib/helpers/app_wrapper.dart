import 'package:flutter/material.dart';
import 'package:tenantapp/models/startup_data.dart';
import 'package:tenantapp/root_page.dart';
import 'package:tenantapp/screens/main_screen.dart';
import 'package:tenantapp/screens/splash_screen.dart';


class AppWrapper extends StatelessWidget {
  final bool loading;
  final StartupData? startupData;
  AppWrapper({this.loading = false, this.startupData});
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  RootPage(),
    );
  }
}
