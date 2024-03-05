// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/cat_product.dart';
import 'package:project/widgets/prod_type.dart';
import 'package:project/widgets/search_app.dart';

class CategScreen extends StatefulWidget {
  @override
  CategState createState() => CategState();
}

class CategState extends State<CategScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        //child: CustemAppBar(),
        child: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ),
      body: SafeArea(
        //SingleChildScrollView(
        child: ListView(
          //padding: EdgeInsets.all(8),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustemAppBar(
              text: 'Home',
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            SearchAppBar(),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ProductType(
                    press: () {},
                    //  image: 'images/icon/new.png',
                    name: 'New Product',
                  ),
                  ProductType(
                    press: () {},
                    //  image: 'images/icon/used.png',
                    name: 'Used Product',
                  ),
                  ProductType(
                    press: () {},
                    // image: 'images/icon/donate.png',
                    name: 'Donation Product',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CatProduct(
                    press: () {},
                    image: 'images/icon/jec_men.png',
                    name: 'Men',
                  ),
                  CatProduct(
                    press: () {},
                    image: 'images/icon/woman.png',
                    name: 'Women',
                  ),
                  CatProduct(
                    press: () {},
                    image: 'images/icon/shoes_A.png',
                    name: 'Shoes',
                  ),
                  CatProduct(
                    press: () {},
                    image: 'images/icon/kids.png',
                    name: 'Kids',
                  ),
                  CatProduct(
                    press: () {},
                    image: 'images/icon/bag.png',
                    name: 'Bags',
                  ),
                  CatProduct(
                    press: () {},
                    image: 'images/icon/clock.png',
                    name: 'Clock',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
