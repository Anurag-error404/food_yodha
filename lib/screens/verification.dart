import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_yodha/screens/onboarding.dart';
import 'package:food_yodha/widgets/ordivider.dart';


class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
       width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE5B2CA),
              Color(0xFFCD82DE)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: size.width * 0.80,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black45 , width: 2)),
              child: Column(
                children: [
                  CircleAvatar(backgroundImage : AssetImage('assets/img/venatus_new_logo.png'),
                  radius: 30,),
                SizedBox(height: 20,),
                  Text(
                    'An email has been sent to ${user.email} please verify to continue.',
                    style: TextStyle(color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100,),
            Text(
              'Haven\'t recieved mail yet ? Wait for a moment ',
              style: TextStyle(color: Colors.black),
            ),
            OrDivider(),
            FlatButton(
                onPressed: () {},
                child: Text(
                  'Sign up with another Mail',
                  style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w600),
                  
                ))
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
  }
}