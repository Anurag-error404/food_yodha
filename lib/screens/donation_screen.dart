import 'package:flutter/material.dart';
import 'package:food_yodha/screens/forms/donate_cash.dart';
import 'package:food_yodha/screens/forms/donate_food.dart';
import 'package:food_yodha/widgets/donation_card.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            DonateFoodForm()));
              },
              child: DonationCard(
                size: size,
                title: "Donate food",
                imgPath:
                    "assets/images/food_donate.png",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            DonateCashForm()));
              },
              child: DonationCard(
                size: size,
                title: "Donate cash",
                imgPath:
                    "assets/images/don_cash.png",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // DonationCard(
            //   size: size,
            //   title: "Request Pickup",
            //   imgPath:
            //       "assets/images/home_header.jpg",
            // ),
          ],
        ),
      ),
    ));
  }
}

