import 'package:flutter/material.dart';

class Intro3 extends StatelessWidget {
  const Intro3({Key? key}) : super(key: key);

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
                  color: Colors.blue,
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
                  color: Colors.blue,
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
              bottom: size.height * 0.45,
              left: size.width * 0.12,
              child: Image.asset(
                'assets/icons/help.png',
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
                      """By taking this first step
with us, you are making 
a significant contribution
to reducing hunger in India.""",
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
