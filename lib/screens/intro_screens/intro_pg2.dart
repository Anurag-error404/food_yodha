import 'package:flutter/material.dart';

class Intro2 extends StatelessWidget {
  const Intro2({Key? key}) : super(key: key);

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
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      size.width * 0.2,
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
                  color: Colors.red,
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
              bottom: size.height * 0.4,
              left: size.width * 0.1,
              child: Image.asset(
                'assets/icons/beg.png',
                height: size.height * 0.35,
              ),
            ),
            Positioned(
                bottom: size.height * 0.2,
                left: size.width * 0.07,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Container(
                    child: Text(
                      """Still every night, 811 
million people worldwide 
go to bed hungry. That's
one in nine people!""",
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
