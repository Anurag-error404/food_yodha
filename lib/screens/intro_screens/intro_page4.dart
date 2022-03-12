import 'package:flutter/material.dart';

class Intro4 extends StatelessWidget {
  const Intro4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              right: 0,
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      size.width * 0.25,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      size.width * 0.4,
                    ),
                    topRight: Radius.circular(
                      size.width * 0.4,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.40,
              // left: size.width * 0.05,
              child: Image.asset(
                'assets/icons/feed.png',
                height: size.height * 0.4,
              ),
            ),
            Positioned(
                bottom: size.height * 0.2,
                left: size.width * 0.06,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Container(
                    child: Text(
                      """Let's work for the cause
together to eliminiate
global hunger""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight:
                              FontWeight.bold),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
