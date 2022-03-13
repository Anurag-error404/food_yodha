import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import '../all_screen.dart';

class VolunteerForm extends StatefulWidget {
  const VolunteerForm({Key? key})
      : super(key: key);

  @override
  State<VolunteerForm> createState() =>
      _VolunteerFormState();
}

class _VolunteerFormState
    extends State<VolunteerForm> {
  final _formKey = GlobalKey<FormState>();
  String? userName;
  String? contact;
  String? city;
  var userUid = "";
  var userMail = "";
  var id = '-1';

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  getId() {
    id = firestore
        .collection('volunteers')
        .doc()
        .id
        .toString();
  }

  @override
  void initState() {
    super.initState();
    getId();
  }

  _submit() {
    DocumentReference documentReference =
        firestore
            .collection("volunteers")
            .doc(id);

    bool isValid =
        _formKey.currentState!.validate();

    if (isValid) {
      documentReference.get().then((value) async {
        await firestore
            .collection("users_app")
            .doc(id)
            .update({
          "name": userName,
          "phoneNumber": contact,
          "city": city,
        });
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) =>
                  const AllScreen()));
    } else {
      showSimpleNotification(
        const Text("Form Submission error"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 20),
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
          child: ListView(
            // mainAxisAlignment:
            // MainAxisAlignment.e,
            children: [
              SvgPicture.asset(
                'assets/icons/volun.svg',
                height: size.height * 0.3,
              ),
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width * 0.9,
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
