import 'package:flutter/material.dart';

class Intro1 extends StatelessWidget {
  const Intro1({Key? key}) : super(key: key);

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
                  color: Colors.amber,
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
                  color: Colors.amber,
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
                'assets/icons/healthy.png',
                height: size.height * 0.4,
              ),
            ),
            Positioned(
                bottom: size.height * 0.2,
                left: size.width * 0.1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Container(
                    child: Text(
                      """In the world, more than 
enough food is produced
to feed everybody.""",
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
