// ignore_for_file: prefer_const_constructors
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:intl/intl.dart';
import 'package:project/src/mixins/valid_mixin.dart';

class Style extends StatelessWidget with ValidationMixin {
  final int child;
  final TextEditingController myController;
  final List<String> hint = [
    'First Name',
    'Last Name',
    'Email',
    'Phone',
    'Address',
    'Birthday',
  ];
  //final List<String> icon = ['', 'email'];

  Style({super.key, required this.child, required this.myController});

  @override
  Widget build(context) {
    IconData? prefixIconData; // Default icon
    if (child == 0 || child == 1) {
      prefixIconData = Icons.person;
    } else if (child == 2) {
      prefixIconData = Icons.email;
    } else if (child == 3) {
      prefixIconData = Icons.phone;
    } else if (child == 4) {
      prefixIconData = Icons.location_on;
    } else if (child == 5) {
      prefixIconData = Icons.date_range_sharp;
    } else {
      prefixIconData = null;
    }
    return TextFormField(
      controller: myController,
      //  cursorHeight: hi,
      // style: TextStyle(color: Colors.red),
      // SizedBox:
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIconData,
          //Icons.email,
          color: Color(0xFF0D6775),
          size: 22,
        ),
        // labelText: 'Username'),
        //  border: OutlineInputBorder(),
        hintText: hint[child],
        hintStyle: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Colors.black,
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
      ),

    //  validator: validateAll,
      /*validator: (value) {
        if (value == null || value.isEmpty) {
          return '${hint[child]} number is required';
        }
        // Check if the phone number is of length 10 and starts with '059' or '056'
        /*if (value.length != 10 || (!value.startsWith('059') && !value.startsWith('056'))) {
        return 'Invalid phone number';
      }*/
        return null; // Return null if the validation passes
      },*/
    );
  }

  /* static TextStyle hintStyle() {
    return GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  static OutlineInputBorder border() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF107086),
      ),
      borderRadius: BorderRadius.circular(30),
    );
  }

  static OutlineInputBorder contentBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2679A3)),
      borderRadius: BorderRadius.circular(30),
    );
  }*/
}
*/