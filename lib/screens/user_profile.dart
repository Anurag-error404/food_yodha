import 'package:flutter/material.dart';
import 'package:food_yodha/screens/google_login.dart';
import 'package:food_yodha/screens/login_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() =>
      _UserProfileState();
}

class _UserProfileState
    extends State<UserProfile> {
  Widget listObject(String _title, String _desc) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: Colors.black45)),
      child: ListTile(
        leading: const Icon(
          Icons.person,
          size: 50,
          color: Colors.black,
        ),
        title: Text(
          _title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(_desc),
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              listObject("Username", "Anurag"),
              const SizedBox(
                height: 5,
              ),
              listObject("Username", "Anurag"),
              const SizedBox(
                height: 5,
              ),
              listObject("Username", "Anurag"),
              const SizedBox(
                height: 5,
              ),
              listObject("Username", "Anurag"),
              const SizedBox(
                height: 5,
              ),
              listObject("Username", "Anurag"),
              const SizedBox(
                height: 5,
              ),
              listObject("Username", "Anurag"),
              const SizedBox(
                height: 5,
              ),
              MaterialButton(
                onPressed: () {
                  AuthGoogle().logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              LoginScreen()));
                },
                child: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
