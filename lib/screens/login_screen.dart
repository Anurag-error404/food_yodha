import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_yodha/screens/onboarding.dart';
import 'package:food_yodha/screens/reset_password.dart';
import 'package:food_yodha/screens/signup_screen.dart';
import 'package:food_yodha/widgets/ordivider.dart';

import 'google_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _obscureText = true;
  final auth = FirebaseAuth.instance;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> login() async {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      try {
        final User? user = (await auth
                .signInWithEmailAndPassword(
                    email: _email,
                    password: _password))
            .user;

        if (user!.uid.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    const OnboardingScreen()),
          );
          // vipUser = true;
          SnackBar(
            content: Text(
                "Succesfully Loggedin in as ${user.email}"),
          );
          SnackBar(
            content: Text(
                "Succesfully Loggedin in as ${user.email}"),
          );
          // showSimpleNotification(
          //     Text(
          //         "Succesfully Loggedin in as ${user.email}"),
          //     position:
          //         NotificationPosition.bottom,
          //     background: Colors.red);
        } else {
          setState(() {
            // loginFail = true;
            print('sign in failed!');
            const SnackBar(
              content: Text(
                  "Failed to login. Please try again later"),
            );
            // showSimpleNotification(
            //     const Text(
            //         "Failed to login. Please try again later"),
            //     position:
            //         NotificationPosition.bottom,
            //     background: Colors.red);
          });
        }
      } catch (e) {
        var errorCode = e.toString();
        if (errorCode ==
            '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
          print('this email isnt registered !');
          const SnackBar(
            content: Text(
                "Email isn't registered. Please sign up First"),
            backgroundColor: Colors.black,
          );
          // showSimpleNotification(
          //     Text(
          //         "Email isn't registered. Please sign up First"),
          //     position:
          //         NotificationPosition.bottom,
          //     background: Colors.red);
        } else if (errorCode ==
            '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
          print('invalid password');
          const SnackBar(
            content: Text(
                "Password Entered is incorrect"),
          );
          // showSimpleNotification(
          //     Text(
          //         "Password Entered is incorrect"),
          //     position:
          //         NotificationPosition.bottom,
          //     background: Colors.red);
        } else {
          const SnackBar(
            content: Text(
                "Some Unexpected Error occured please try again later."),
          );
          // showSimpleNotification(
          //     Text(
          //         "Some Unexpected Error occured please try again later."),
          //     position:
          //         NotificationPosition.bottom,
          //     background: Colors.red);
        }
        print(e.toString());
      }
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
                //   'assets/icons/login_fy.svg',
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
                  height: 30,
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
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      login();
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ResetScreen(),
                      ),
                    );
                  },
                ),
                const OrDivider(),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.6),
                      borderRadius:
                          BorderRadius.circular(
                              20)),
                  child: TextButton(
                    child: const Text(
                      'Login with Google',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    onPressed: () {
                      AuthGoogle()
                          .loginGoogle(context);
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
                      'Don\'t have an account ? Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignupScreen(),
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
