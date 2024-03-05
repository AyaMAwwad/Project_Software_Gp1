// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// splash screen
class CoverPage extends StatelessWidget {
  //const CoverPage({super.key});

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
                color: Color.fromARGB(255, 43, 114, 122), //Color(0xFF0D6775),
              ),
            ),
            Center(
              child: Image.asset(
                "images/icon/splash.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
