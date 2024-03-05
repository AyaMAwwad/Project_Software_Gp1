// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(10),
      child: AnotherCarousel(
        images: [
          AssetImage('images/icon/fash_C.jpg'),
          AssetImage('images/icon/gam_A.png'),
          AssetImage('images/icon/fur_A.jpg'),
          AssetImage('images/icon/book_A.jpg'),
          AssetImage('images/icon/psA.jpeg'),
        ],
        borderRadius: true,
        radius: Radius.circular(30),
        dotBgColor: Colors.transparent,
        dotIncreasedColor: Color(0xFF063A4E),
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(
          milliseconds: 800,
        ),
      ),
    );
  }
}
