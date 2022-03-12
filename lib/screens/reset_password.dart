import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() =>
      _ResetScreenState();
}

class _ResetScreenState
    extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: size.height * 0.38,
                  child: SvgPicture.asset(
                      'assets/icons/pswd_reset.svg'),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.all(8.0),
                child: Form(
                  child: Container(
                    width: size.width * 0.80,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                10),
                        color: Theme.of(context)
                            .accentColor),
                    child: TextFormField(
                        style: const TextStyle(
                            color: Colors.white),
                        keyboardType:
                            TextInputType
                                .emailAddress,
                        decoration:
                            InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(Icons.mail),
                          ),
                          hintText:
                              'Enter your registered email',
                          hintStyle: const TextStyle(
                              color:
                                  Colors.black),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can not be empty";
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width * 0.80,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10),
                  color: Colors.purple[800],
                ),
                child: TextButton(
                  child: const Text(
                    'Send Request',
                    style: const TextStyle(
                        color: Colors.white),
                  ),
                  onPressed: () {
                    auth.sendPasswordResetEmail(
                        email: _email);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
