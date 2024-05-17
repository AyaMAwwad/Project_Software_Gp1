// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';

class SellarPage extends StatefulWidget {
  @override
  SellarPageState createState() => SellarPageState();
}

class SellarPageState extends State<SellarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        //child: CustemAppBar(),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("homepagee");
              },
            ),
          ],
        ),
      ),
      /*
       appBar: AppBar(
        title: Text(widget.categoryName),
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustemAppBar(
                  text: "144".tr,
                ),
                SizedBox(
                  height: 10,
                  //  child:Carousel(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
