// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/enam.dart';
import 'dart:ui';

class HaveAccount extends StatelessWidget {
  final String name1;
  final String name2;
  final VoidCallback press;

  //final TypeState selectedtype;

  const HaveAccount({
    super.key,
    required this.name1,
    required this.press,
    required this.name2,

    // required this.selectedtype,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name1,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 1, 3, 4),
                fontSize: 14,

                // decoration: TextDecoration.underline,
                decorationThickness: 1,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
////
          GestureDetector(
            onTap: press,
            child: Text(
              name2,
              //  body: :
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 14,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  fontWeight: FontWeight.bold,
                  //padding: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
