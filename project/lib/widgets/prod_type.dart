// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductType extends StatelessWidget {
  final String name;
  final VoidCallback press;
  const ProductType({
    super.key,
    required this.name,
    required this.press,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: press,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 95, 150, 168),
              // borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Color.fromARGB(255, 4, 51, 67),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
