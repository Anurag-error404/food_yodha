import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_yodha/screens/donation_screen.dart';
import 'user_profile.dart';
import 'homescreen.dart';
import 'map_screen.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() =>
      _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': const HomeScreen(),
      'title': 'Home',
    },
    {
      'page': const MapScreen(),
      'title': 'Maps',
    },
    {
      'page': const DonationScreen(),
      'title': 'donation Screen',
    },
    {
      'page': const UserProfile(),
      'title': 'user profile',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      print(_selectedPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      // backgroundColor:
      //     Theme.of(context).primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.purple,
        unselectedItemColor: Colors.white,
        // selectedItemColor: Colors.pink,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Color(0xffcd82de),
              icon: Icon(
                FontAwesomeIcons.home,
                color: Colors.purple,
                size: 30,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.mapMarked,
                color: Colors.purple,
                size: 30,
              ),
              label: 'locate us'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.donate,
                color: Colors.purple,
                size: 30,
              ),
              label: 'donate'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userAlt,
                color: Colors.purple,
                size: 30,
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}
