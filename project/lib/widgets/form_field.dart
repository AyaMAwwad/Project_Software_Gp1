// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class custemField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  //final String Function()? validator;
  final String? Function(String?)? validator;

  final IconData icon;
  custemField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.icon,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //  cursorHeight: hi,
      // style: TextStyle(color: Colors.red),
      // SizedBox:
      controller: controller,

      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(82, 209, 224, 223), // nice
        // fillColor: Color.fromARGB(255, 2, 92, 123),
        prefixIcon: Icon(
          icon,
          color: Color(0xFF063A4E),
          size: 22,
        ),
        // labelText: 'Username'),
        //  border: OutlineInputBorder(),
        hintText: hintText,
        hintStyle: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 78, 78, 78),
            fontSize: 16,
          ),
        ),

        // hintStyle:  TextStyle(color: Colors.black, fontSize: 16
        //google_fonts.hashCode(GoogleFonts()),
        //  GoogleFonts.aBeeZee,
        // ),

        //borderRadius:
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF107086),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2679A3)),
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 16), // Adjust the vertical padding
//
      ),
      validator: validator,
      //////
      /*
         onChanged: (value) {
           setState(() {
             isemailvalid = validatemail(value);
           });
         },
            */

      /*
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (validatemail(value)) {
          return null;
        } else {
          return '.. please enter your valid email';
        }

        // return null;
      },*/
    );
  }
}
