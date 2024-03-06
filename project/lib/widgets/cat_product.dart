// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatProduct extends StatelessWidget {
  final String name, image;
  final VoidCallback press;
  const CatProduct(
      {super.key,
      required this.name,
      required this.press,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: press,
        // child: ClipRRect(
        // borderRadius: BorderRadius.circular(20),
        child: Container(
          child: Chip(
            backgroundColor:
                Color.fromARGB(255, 146, 190, 204), // Color.fromARGB(
            // 255, 95, 150, 168), //Color.fromARGB(255, 215, 215, 215),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  // 'images/icon/men.png',
                  height: 40,
                ),
                SizedBox(width: 10),
                Text(
                  name,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255,
                          255), // Color.fromARGB(255, 2, 92, 123),
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
