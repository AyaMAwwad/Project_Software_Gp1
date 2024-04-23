// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/locale/locale.dart';
import 'package:project/locale/locale_controller.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/home_page.dart';

import 'package:project/src/screen/login_screen.dart';

import 'package:project/src/screen/screen_state.dart';

import 'package:project/src/screen/signup_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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
    Get.put(mylocalcontroller());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: //CustemAppBar(), // SliderPage(), //NewPass(),
          (FirebaseAuth.instance.currentUser == null)
              ? CoverStateScreen()
              : Login(),
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
      locale: Get.deviceLocale,
      translations: mylocale(),
      navigatorKey: navigatorKey,
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "homepagee": (context) => HomePage(),
        "notification": (context) => NotificationPage(),
        //"category": (context) => ScreenCategory(),
      },
      // Login(), // Signup(), //CoverStateScreen(), // Display SplashScreen initially
    );
  }
}
