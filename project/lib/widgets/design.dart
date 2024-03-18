// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemDesign extends StatelessWidget {
  final String text;
  final String text2;
  final double? num;
  final double? num2;
  final double? fontSize;

  const CustemDesign(
      { //super.key,
      required this.text,
      required this.num,
      required this.text2,
      required this.num2,
      required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * -0.016,
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * -0.05,
          child: Stack(
            children: [
              Image.asset(
                'images/icon/designB.png', // Path to your image asset
                // Adjust height as needed
                fit: BoxFit.cover, // Adjust BoxFit as needed
              ),
              /*  Positioned(
                  top: 130,
                  left: 7,
                  child: Image.asset(
                    'images/icon/logo3.png',
                    width: 900.0,
                    height: 230.0,
                  ),
                  
                  Text(
                    'Are You Forget Your Password ? ',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 43, 115, 122),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 99, 166, 173)
                                .withOpacity(0.5), // Shadow color
                            blurRadius: 5, // Spread radius
                            offset:
                                Offset(2, 2), // Offset in x and y directions
                          ),
                        ],
                      ),
                    ),
                  ),*/
              //   ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.13,
          right: 0,
          left: 0,
          child: Image.asset(
            'images/icon/logo3.png',
            //width: 900.0,
            height: 230.0,
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            right: MediaQuery.of(context).size.width * -0.05,
            left: num,
            child: Text(
              text,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 43, 115, 122),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 99, 166, 173)
                          .withOpacity(0.5), // Shadow color
                      blurRadius: 5, // Spread radius
                      offset: Offset(2, 2), // Offset in x and y directions
                    ),
                  ],
                ),
              ),
            )
            /* Image.asset(
              'images/icon/logo3.png',
              width: 900.0,
              height: 230.0,
            ),*/
            ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.501,
          left: num2,
          child: Text(
            text2,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 168, 169, 170),
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
