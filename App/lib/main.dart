import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:houseapp/helpers/auth.dart';
import 'package:houseapp/helpers/auth_provider.dart';
import 'package:houseapp/helpers/startup_data.dart';
import 'package:houseapp/root_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late StartupData startupData;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBt1JFCVM_ZrjNTpShh9jwYYyVEeCO_EBQ",
        authDomain: "houseapp-tdev.firebaseapp.com",
        projectId: "houseapp-tdev",
        storageBucket: "houseapp-tdev.appspot.com",
        messagingSenderId: "977376339668",
        appId: "1:977376339668:web:c05f6ef3931b8c367b7d41"
    )
  );
  startupData = await initializeStartupData();
  runApp(const MyApp());
}

Future<SharedPreferences> initializeSharedPreferences() {
  return SharedPreferences.getInstance();
}

Future<StartupData> initializeStartupData() async {
  SharedPreferences sharedPreferences = await initializeSharedPreferences();
  return Future.value(StartupData(sharedPreferences));
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: "TenantApp",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color.fromRGBO(37, 46, 66, 1)
        ),
        home: const RootPage(),
      ),
    );
  }
}