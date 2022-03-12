import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      fontSize: 30,
                      color: Colors.white)),
            ),
          ),
          // silver items

          SliverToBoxAdapter(
            child: Container(
              color: Colors.blue,
              height: 200,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.blue,
              height: 200,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.blue,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
