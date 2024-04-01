import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';

import 'package:project/src/screen/home_page.dart';

import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/new_pass.dart';
import 'package:project/src/screen/otp_form.dart';
import 'package:project/src/screen/screen_state.dart';

import 'package:project/src/screen/signup_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/slider.dart';
import 'package:project/src/screen/verify_email.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  //MyApp({Key? key}) : super(key: key);
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        /*if (user.emailVerified) {
          // If the user is signed in and their email is verified, navigate to the login page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Login()),
          );
        }*/
      }
    });
    super.initState();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //ScreenCategory(), //CustemAppBar(), // SliderPage(), //NewPass(),
          (FirebaseAuth.instance.currentUser == null)
              ? CoverStateScreen()
              : Login(),
      ///////////////
      /*FirebaseAuth.instance.currentUser != null  &&
                      FirebaseAuth.instance.currentUser!.emailVerified)
                  ? Login()
                  : VerifyEmail(),*/
      /*(FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : CoverStateScreen(),*/
      /*FirebaseAuth.instance.currentUser == null
          ? CoverStateScreen()
          : HomePage(),*/
      //CoverStateScreen(),
      //(FirebaseAuth.instance.currentUser != null &&
      // FirebaseAuth.instance.currentUser!.emailVerified)
      // OtpForm(),
      //Signup(),
      // CoverPage(),
      //  Demo(),
      // Login(),
      //HomePage(),
      //  VerifyEmail(),
      // OtpForm(),
      //FirebaseAuth.instance.currentUser == null ? Login() : HomePage(),
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "homepagee": (context) => HomePage(),
        //"category": (context) => ScreenCategory(),
      },
      // Login(), // Signup(), //CoverStateScreen(), // Display SplashScreen initially
    );
  }
}
