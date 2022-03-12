import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_yodha/screens/all_screen.dart';
import 'package:food_yodha/screens/onboarding.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {
  var loginCheck;

  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<void> loginGoogle(ctx) async {
    User user;
    final GoogleSignInAccount?
        googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication
          googleSignInAuthentication =
          await googleSignInAccount
              .authentication;

      final AuthCredential credential =
          GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication
            .accessToken,
        idToken:
            googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth
                .signInWithCredential(credential);

        user = userCredential.user!;

        print(
            "name =============== ${user.displayName}");
        print(
            "uid =============== ${user.uid.toString()}");

        if (userCredential
            .additionalUserInfo!.isNewUser) {
          Navigator.pushReplacement(
              ctx,
              MaterialPageRoute(
                  builder: (ctx) =>
                     OnboardingScreen()));
        } else {
          Navigator.pushReplacement(
              ctx,
              MaterialPageRoute(
                  builder: (ctx) =>
                      AllScreen()));
          showSimpleNotification(Text(
              'succefully signed in as ${user.email}'));
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }

  Future<void> logout() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn();

    try {
      GoogleSignIn().disconnect();
      googleSignIn.signOut();
      auth.signOut();
      
    } catch (e) {
      print(e);
    }
  }
}
