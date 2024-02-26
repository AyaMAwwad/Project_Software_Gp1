import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyYourEmail createState() => _VerifyYourEmail();
}

class _VerifyYourEmail extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Veirify Your Email  ',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 2, 92, 123),
              fontSize: 20,

              // decoration: TextDecoration.underline,
              decorationThickness: 1,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D6775),
                minimumSize: Size(90, 40),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
              ),
              child: Text(
                'Veirify Email',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
