// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/src/screen/cover_page.dart';
import 'package:project/src/screen/login_screen.dart';

//splash screen
class CoverStateScreen extends StatefulWidget {
  @override
  CoverStateThreeSec createState() => CoverStateThreeSec();
}

class CoverStateThreeSec extends State<CoverStateScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CoverPage(),
      ),
    );
  }
}
