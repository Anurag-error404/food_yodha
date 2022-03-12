import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_yodha/screens/terms_conditions.dart';
import 'package:overlay_support/overlay_support.dart';

import '../all_screen.dart';

class UserInfoForm extends StatefulWidget {
  const UserInfoForm({Key? key})
      : super(key: key);

  @override
  State<UserInfoForm> createState() =>
      _UserInfoFormState();
}

class _UserInfoFormState
    extends State<UserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String? userName;
  DateTime? dob;
  String? contact;
  String? addressLine;
  String? pinCode;
  String? city;
  String? state;
  bool isTnCAccepted = false;

  var userUid = "";
  var userMail = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  void inputData() {
    setState(() {
      final User? user = auth.currentUser;
      userUid = user!.uid.toString();
      userMail = user.email!;
    });
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  _submit() {
    DocumentReference documentReference =
        firestore
            .collection("users_app")
            .doc(userUid);

    bool isValid =
        _formKey.currentState!.validate();
    if (isTnCAccepted) {
      if (isValid) {
        documentReference
            .get()
            .then((value) async {
          await firestore
              .collection("users_app")
              .doc(userUid)
              .update({
            "name": userName,
            "phoneNumber": contact,
            "credits": 100,
            "dob": dob,
            "address": addressLine,
            "city": city,
            "pincode": pinCode,
            "email": userMail
          });
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) =>
                    const AllScreen()));
      } else {
        const SnackBar(
          content: Text("Form Submission error"),
        );
      }
    } else {
      showSimpleNotification(
        const Text(
            "Terms and conditions need to be accepted to use the app"),
      );
    }
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        dob = value!;
      });
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates =
        <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 20),
        width: size.width,
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
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "User Profile",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 60,
              ),
              // name
              TextFormField(
                key: const ValueKey('userName'),
                keyboardType: TextInputType.name,
                onSaved: (newValue) {
                  userName = newValue;
                },
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field can not be empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.users,
                      color: Colors.purple,
                    ),
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(
                      color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // contact
              TextFormField(
                key: const ValueKey('contact'),
                keyboardType:
                    TextInputType.number,
                onSaved: (newValue) {
                  contact = newValue;
                },
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.length != 10) {
                    return "Invalid Contact Number";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.phone,
                      color: Colors.purple,
                    ),
                  ),
                  labelText: 'Contact Number',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  hintText:
                      'Enter your contact details',
                  hintStyle: const TextStyle(
                      color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // dob
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black
                          .withOpacity(0.45)),
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.calendar,
                    color: Colors.purple,
                  ),
                  onTap: _showDatePicker,
                  title: const Text(
                    "Date of birth",
                    style:
                        TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(dob == null
                      ? ""
                      : "${dob?.day} - ${dob?.month} - ${dob?.year}"),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // address
              TextFormField(
                key:
                    const ValueKey('addressLine'),
                keyboardType:
                    TextInputType.streetAddress,
                onSaved: (newValue) {
                  addressLine = newValue;
                },
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field can not be empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.map,
                      color: Colors.purple,
                    ),
                  ),
                  labelText: 'Address',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // city
              TextFormField(
                key: const ValueKey('city'),
                keyboardType: TextInputType.name,
                onSaved: (newValue) {
                  city = newValue;
                },
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field can not be empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.city,
                      color: Colors.purple,
                    ),
                  ),
                  labelText: 'City',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // pincode
              TextFormField(
                key: const ValueKey('pinCode'),
                keyboardType:
                    TextInputType.number,
                onSaved: (newValue) {
                  pinCode = newValue;
                },
                cursorColor: Colors.purple,
                validator: (value) {
                  if (value!.length != 6) {
                    return "Invalid Pin";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons
                          .locationArrow,
                      color: Colors.purple,
                    ),
                  ),
                  labelText: 'Pincode',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              TermsAndConditions()));
                },
                child: Text(
                    "Click here to read the terms and conditions"),
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor:
                        MaterialStateProperty
                            .resolveWith(
                                getColor),
                    value: isTnCAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        isTnCAccepted = value!;
                      });
                    },
                  ),
                  const Text(
                      "Terms and Conditions"),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius:
                        BorderRadius.circular(
                            15)),
                child: MaterialButton(
                  onPressed: _submit,
                  child: const Text(
                    "Submit",
                    style:
                        TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
