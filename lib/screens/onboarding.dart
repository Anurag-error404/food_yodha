import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_yodha/screens/forms/user_info.dart';
import 'package:food_yodha/screens/homescreen.dart';
import 'package:food_yodha/screens/intro_screens/intro_page3.dart';
import 'package:food_yodha/screens/intro_screens/intro_page4.dart';
import 'package:food_yodha/screens/intro_screens/intro_pg1.dart';
import 'package:food_yodha/screens/intro_screens/intro_pg2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key})
      : super(key: key);

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  var userUid = "";
  var userMail = "";
  // var id = "-1";

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  void inputData() {
    setState(() {
      final User? user = auth.currentUser;
      userUid = user!.uid.toString();
      userMail = user.email!;
    });
  }

  // getID() {
  //   setState(() {
  //     id = firestore
  //         .collection("users_app")
  //         .doc(userUid)
  //         .id;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    inputData();
    // getID();
  }

  _submit() {
    DocumentReference documentReference =
        firestore
            .collection("users_app")
            .doc(userUid);

    documentReference.get().then((value) async {
      await firestore
          .collection("users_app")
          .doc(userUid)
          .set({
        "name": "",
        "phoneNumber": "",
        "credits": 100,
        "dob": "",
        "address": "",
        "city": "",
        "pincode": "",
        "email": userMail
      });
    });
  }

  // controller to keep track of pages
  final PageController _controller =
      PageController();

  // keep track of page no
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              lastPage = (value == 3);
            });
          },
          children: const [
            Intro1(),
            Intro2(),
            Intro3(),
            Intro4(),
          ],
        ),

        // dot indicator

        Container(
          alignment: const Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              // skip
              lastPage
                  ? GestureDetector(
                      onTap: () {
                        _controller.previousPage(
                            duration:
                                const Duration(
                                    microseconds:
                                        500),
                            curve: Curves.easeIn);
                      },
                      child: const Text("Back"),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(3);
                      },
                      child: const Text("Skip"),
                    ),

              // dot indicator
              SmoothPageIndicator(
                  controller: _controller,
                  count: 4),

              // next
              lastPage
                  ? GestureDetector(
                      onTap: () {
                        _submit();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    const UserInfoForm()));
                      },
                      child:
                          const Text("Continue"),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration:
                                const Duration(
                                    microseconds:
                                        500),
                            curve: Curves.easeIn);
                      },
                      child: const Text("Next"),
                    ),
            ],
          ),
        )
      ],
    ));
  }
}
