// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyYourEmail createState() => _VerifyYourEmail();
}

class _VerifyYourEmail extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb ? buildWebVerifyEmail() : buildMobileVerifyEmail();
  }

  Widget buildMobileVerifyEmail() {
    return Scaffold(
      body: Stack(
        children: [
          CustemDesign(
            text: 'Verify your Email',
            text2: 'We have sent verification to your email',
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

  Widget buildWebVerifyEmail() {
    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 226, 153, 110),
                  Color.fromARGB(255, 90, 110, 199),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Container(
                  width: 500,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: AssetImage('images/icon/back.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Verify your Email',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF063A4E),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'We have sent verification to your email',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Color(0xFF063A4E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32),
                            CustomeButton2(
                              text: 'Verify Email',
                              onPressed: () {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                } else {
                                  // Handle the case where there's no authenticated user
                                  print('No authenticated user found.');
                                }
                                if (FirebaseAuth
                                    .instance.currentUser!.emailVerified) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
