import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class custemFieldforProductPage extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  //final String Function()? validator;
  //final String? Function(String?)? validator;

  const custemFieldforProductPage(
      {super.key,
      required this.hintText,
      required this.controller,
      // required this.validator,
      required this.text,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 2, 92, 123),
              fontSize: 20,

              // decoration: TextDecoration.underline,
              decorationThickness: 1,
              fontWeight: FontWeight.bold,
              //padding: 10,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true, // Set to true to enable filling
            fillColor: const Color.fromARGB(255, 239, 240, 245),

            //  fillColor: Color.fromARGB(82, 209, 224, 223),
            // nice
            // fillColor: Color.fromARGB(255, 2, 92, 123),

            // labelText: 'Username'),
            //  border: OutlineInputBorder(),
            hintText: hintText,
            hintStyle: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 78, 78, 78),
                fontSize: 15,
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
              borderRadius: BorderRadius.circular(15),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 95, 150, 168),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 16), // Adjust the vertical padding
            //
          ),
          validator: validator,
        ),
      ],
    );
  }
}
