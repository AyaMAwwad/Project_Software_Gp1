import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/forget_pass.dart';
import 'package:project/src/screen/home_page.dart';
//import 'package:project/src/screen/cover_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/otp_form.dart';
import 'package:project/src/screen/signup_screen.dart';
//import 'package:project/src/screen/screen_state.dart';
//import 'package:project/src/screen/signup_screen.dart';

class MyApp extends StatefulWidget {
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
      }
    });
    super.initState();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: //(FirebaseAuth.instance.currentUser != null &&
          // FirebaseAuth.instance.currentUser!.emailVerified)
          // OtpForm(),
          //  Signup(),
          Login(),
      // OtpForm(),
      //FirebaseAuth.instance.currentUser == null ? Login() : HomePage(),
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "homepagee": (context) => HomePage(),
      },
      // Login(), // Signup(), //CoverStateScreen(), // Display SplashScreen initially
    );
  }
}
