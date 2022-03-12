import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_yodha/screens/launch_screen.dart';
import 'package:food_yodha/screens/login_screen.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffcd82de)),
          primaryColor: const Color(0xffCD82DE),
          accentColor: Colors.white,
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
