// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// splash screen
class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0xFF0D6775),
              ),
            ),
            Center(
              child: Image.asset(
                "images/icon/splash.png",
              ),
            ),
            /*  Image.asset(
              'images/icon/star.png',
            ),
            Image.asset(
              'images/icon/star.png',
              height: 200,
            ),
            Image.asset(
              'images/icon/star.png',
              height: 300,
              width: 100,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'images/icon/star.png',
              ),
            ),
            Positioned(
              bottom: 130,
              right: 0,
              child: Image.asset(
                'images/icon/star.png',
              ),
            ),
            Positioned(
              bottom: 80,
              right: 110,
              child: Image.asset(
                'images/icon/star.png',
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
