// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/app.dart';
import 'package:project/src/screen/login_screen.dart';
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
      body: Stack(
        children: [
          CustemDesign(
            text: 'Verify your Email',
            text2: 'We have sent verfication to your email',
            fontSize: 18,
            num2: MediaQuery.of(context).size.width * 0.07,
            num: MediaQuery.of(context).size.width * 0.16,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 123.0, right: 20.0, top: 420),
              child: CustomeButton2(
                text: 'Verify Email',
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  } else {
                    // Handle the case where there's no authenticated user
                    print('No authenticated user found.');
                  }
                  if (FirebaseAuth.instance.currentUser!.emailVerified) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
