// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyYourEmail createState() => _VerifyYourEmail();
}

class _VerifyYourEmail extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
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
      ),*/
      body: Stack(
        children: [
          CustemDesign(
            text: 'Verify your Email',
            text2: 'We have sent verfication to your email',
            fontSize: 18,
            num2: 24,
            num: 70,
          ),
          /* Positioned(
            top: 375,
            left: 20,
            child: Text(
              'We have sent verfication to your email',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 168, 169, 170),
                  fontSize: 18,
                ),
              ),
            ),
          ),*/
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 123.0, right: 20.0, top: 420),
              child: CustomeButton2(text: 'Verify Email', onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
