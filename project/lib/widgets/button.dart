// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final BorderRadius borderRadius;
  CustomeButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color.fromARGB(109, 69, 102, 99),
            //  Color(0xFF0D6775),
            Color.fromARGB(108, 82, 173, 166),
            Color.fromARGB(255, 21, 101, 117)
//0xAC8FDDD7
          ],
          // زهري و بنفزجي
          // Color(0xFFEC94C8),
          // Color(0xFF471086)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: borderRadius,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            //],

            //),

            //

            style: ElevatedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 22, 66, 177),
              backgroundColor: Color.fromARGB(0, 72, 107, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              //elevation: 1.5,
              shadowColor: Color.fromARGB(192, 64, 128, 122),
            ),
          ),
        ],
      ),
    );
  }
}
