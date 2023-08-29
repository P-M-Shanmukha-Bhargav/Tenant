import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenantapp/helpers/auth.dart';
import 'package:tenantapp/helpers/auth_provider.dart';
import 'package:tenantapp/root_page.dart';

import 'helpers/startup_data.dart';

late StartupData startupData;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  startupData = await initializeStartupData();
  runApp(App());
}

Future<SharedPreferences> initializeSharedPreferences() {
  return SharedPreferences.getInstance();
}

Future<StartupData> initializeStartupData() async {
  SharedPreferences _sharedPreferences = await initializeSharedPreferences();
  return Future.value(StartupData(_sharedPreferences));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child:  MaterialApp(
        title: "Tenant App",
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primaryColor: Color.fromRGBO(37, 46, 66, 1)
        ),
        home: new RootPage(),
      ),
    );
  }
}