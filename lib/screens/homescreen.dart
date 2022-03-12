import 'package:flutter/material.dart';
import 'package:food_yodha/screens/forms/food_survey.dart';
import 'package:food_yodha/screens/forms/hunger_zones.dart';
import 'package:food_yodha/screens/forms/volunteer.dart';
import 'package:food_yodha/widgets/donation_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE5B2CA),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor:
                  Theme.of(context).primaryColor,
              expandedHeight: 300,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/home_header.jpg',
                  fit: BoxFit.cover,
                ),
                title: const Text("FoodYodha",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white)),
              ),
            ),
            // silver items

            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(
            //             vertical: 5,
            //             horizontal: 10),
            //     child: ListView(
            //       children: [
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                FoodSurvey()));
                  },
                  child: DonationCard(
                      size: size,
                      title:
                          "Check quality of leftover food ",
                      imgPath:
                          "assets/images/leftover.jpg"),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                VolunteerForm()));
                  },
                  child: DonationCard(
                      size: size,
                      title:
                          "Volunteer to be a FoodYodha",
                      imgPath:
                          "assets/images/vol.jpg"),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                HungerZone()));
                  },
                  child: DonationCard(
                      size: size,
                      title:
                          "Help us find hunger zones",
                      imgPath:
                          "assets/images/hunger_zones.jpg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
