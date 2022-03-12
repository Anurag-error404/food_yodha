import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_yodha/screens/login_screen.dart';
import 'package:food_yodha/screens/onboarding.dart';
import 'package:food_yodha/screens/verification.dart';
import 'package:food_yodha/widgets/ordivider.dart';
import 'package:overlay_support/overlay_support.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key})
      : super(key: key);

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {
      var _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _obscureText = true;
  final auth = FirebaseAuth.instance;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

Future<void> _signUpWithMail() async {
    final formState = _formKey.currentState;
    try {
      final User? user = (await auth
              .createUserWithEmailAndPassword(
                  email: _email,
                  password: _password))
          .user;

      if (user!.uid.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  VerifyScreen()),
        );
      } else {
        setState(() {
          print('sign in failed!');
          showSimpleNotification(
              Text(
                  "Failed to SignUp. Please try again later"),
              position:
                  NotificationPosition.bottom,
              background: Colors.red);
        });
      }
    } catch (e) {
      var errorCode = e.toString();
      if (errorCode ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        print(
            'this email is already registered ! Login to continue');
        showSimpleNotification(
            Text(
                "Email is already registered ! Login to continue"),
            position: NotificationPosition.bottom,
            background: Colors.red);
      } else {
        showSimpleNotification(
            Text(
                "Some Unexpected Error occured please try again later."),
            position: NotificationPosition.bottom,
            background: Colors.red);
      }
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    

    return SafeArea(
        child: Scaffold(
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                // SvgPicture.asset(
                //   'assets/images/login.png',
                //   width: size.width * 0.8,
                // ),
                const SizedBox(
                  height: 20,
                ),

                Image.asset(
                  "assets/images/login.png",
                  width: size.width * 0.6,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                              20)),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                    cursorColor: Colors.red,

                    onSaved: (value) {
                      _email = value.toString();
                    },
                    keyboardType: TextInputType
                        .emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field can not be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon:
                          const IconButton(
                        icon: Icon(Icons.mail),
                        onPressed: (null),
                      ),
                      hintText:
                          'Enter Your Email',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1,
                    ),
                    // controller: emailTextController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                              20)),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                    obscureText: _obscureText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                    cursorColor: Colors.red,
                    key: const ValueKey(
                        'Password'),
                    onSaved: (value) {
                      _password =
                          value.toString();
                    },
                    keyboardType: TextInputType
                        .emailAddress,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password too short";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon:
                            const IconButton(
                          icon: Icon(
                            Icons.lock,
                          ),
                          onPressed: (null),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.visibility,
                          ),
                          onPressed: () {
                            _toggle();
                          },
                        ),
                        hintText: 'Password',
                        hintStyle:
                            Theme.of(context)
                                .textTheme
                                .bodyText1),
                  ),
                  // controller: passwordTextController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color:
                          const Color(0xff78258B),
                      borderRadius:
                          BorderRadius.circular(
                              20)),
                  child: TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      onPressed: _signUpWithMail),
                ),
                TextButton(
                  child: const Text(
                      'Already have an account ? Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
