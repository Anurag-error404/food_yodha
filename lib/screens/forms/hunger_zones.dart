import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_yodha/screens/all_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HungerZone extends StatefulWidget {
  const HungerZone({Key? key}) : super(key: key);

  @override
  State<HungerZone> createState() =>
      _HungerZoneState();
}

class _HungerZoneState extends State<HungerZone> {
  final _formKey = GlobalKey<FormState>();
  String? addressLine;
  String? city;
  String? state;
  var imgUrl = "";
  var docId = '-1';
  var userUid = '';

  File _image = File('');

  Future _getImage() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future _uploadFile() async {
    FirebaseStorage storage =
        FirebaseStorage.instance;
    Reference ref = storage.ref().child(
        'hunger_zones/${Path.basename(_image.path)}');
    UploadTask uploadTask = ref.putFile(_image);
    var url = await (await uploadTask)
        .ref
        .getDownloadURL();
    imgUrl = url.toString();
  }

  getID() {
    setState(() {
      userUid =
          FirebaseAuth.instance.currentUser!.uid;
      docId = FirebaseFirestore.instance
          .collection('hunger_zones')
          .doc()
          .id
          .toString();
    });
  }

  _submit() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance
            .collection('hunger_zones')
            .doc(docId);

    var isValid =
        _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      if (_image != null) {
        await _uploadFile();
      } else {
        return showSimpleNotification(
          Text(
            'Please upload screenshot',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(
            seconds: 1,
          ),
        );
      }
      documentReference.get().then((value) async {
        await FirebaseFirestore.instance
            .collection('hunger_zones')
            .doc(docId)
            .set({
          // form fields
          "address": addressLine,
          "city": city,
          "state": state,
          "imgUrl": imgUrl,
          "submittedBy": userUid,
        });
      });
      showSimpleNotification(
          Text(
            "Succesfully Submitted",
          ),
          duration: Duration(
            seconds: 3,
          ));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AllScreen(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    getID();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hunger Zones'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: const ValueKey('city'),
                  keyboardType: TextInputType.text,
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
                TextFormField(
                  key: const ValueKey('state'),
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    state = newValue;
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
                        FontAwesomeIcons.landmark,
                        color: Colors.purple,
                      ),
                    ),
                    labelText: 'State',
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
                GestureDetector(
                  onTap: () {
                    _getImage();
                  },
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Colors.black45),
                          borderRadius:
                              BorderRadius.circular(
                                  15),
                          color: Colors.white
                              .withOpacity(0.15),
                        ),
                        height:
                            MediaQuery.of(context)
                                    .size
                                    .height *
                                0.25,
                        width:
                            MediaQuery.of(context)
                                .size
                                .width,
                        child: _image == File('')
                            ? Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Theme.of(
                                        context)
                                    .cardColor,
                              )
                            : Image.file(_image,
                                fit:
                                    BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
