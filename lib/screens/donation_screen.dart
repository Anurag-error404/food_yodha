import 'package:flutter/material.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key})
      : super(key: key);

  @override
  State<DonationScreen> createState() =>
      _DonationScreenState();
}

class _DonationScreenState
    extends State<DonationScreen> {
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
      child: ListView(
        children: [Text('Doante')],
      ),
    ));
  }
}
