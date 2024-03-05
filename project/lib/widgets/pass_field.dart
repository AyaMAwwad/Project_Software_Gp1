// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onPressed;
  final bool obscureText;
  final IconData icon;
  final String hintText;
  //bool valpass = false;

  PassField(
      { //super.key,
      required this.controller,
      this.onPressed,
      required this.obscureText,
      required this.icon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) => value!.length < 6 ? 'enter please 6 number ' : null,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(88, 194, 214, 212),
        // obscureText: true,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Color.fromARGB(255, 1, 67, 89),
          ),
        ),

        /*
       GestureDetector(
        onTap: (){

      // setState( () {
       valpass =!valpass;
       //});
       


       },
       child: Icon(valpass ? Icons.visibility : Icons.visibility_off),
       
       
       
       ),*/

        prefixIcon: Icon(
          Icons.lock,
          // color: Color(0xFF063A4E),
          color: Color.fromARGB(255, 3, 56, 73),
          size: 22,
        ),
        //: true,
        // obc
        hintText: hintText, //'Password',
        hintStyle: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 78, 78, 78),
            fontSize: 16,
          ),
        ),
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
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.0), // Adjust the vertical padding
      ),
    );
  }
}
