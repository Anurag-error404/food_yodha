import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_yodha/screens/login_screen.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/food_yodha_logo.png',
      nextScreen: const LoginScreen(),
      splashTransition:
          SplashTransition.fadeTransition,
    );
  }
}