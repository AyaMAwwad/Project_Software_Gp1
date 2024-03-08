// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/cat_product.dart';
import 'package:project/widgets/prod_type.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';

class CategScreen extends StatefulWidget {
  @override
  CategState createState() => CategState();
}

class CategState extends State<CategScreen> {
  //////////////
  String selectedCategory = 'Men';
  String selectedType = 'New';

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateType(String category) {
    setState(() {
      selectedType = category;
    });
  }
  ///////////////

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
                  Navigator.of(context).pushReplacementNamed(
                      "homepagee"); // This will pop the current route (Drawer)
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          //SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: ListView(
              //padding: EdgeInsets.all(8),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustemAppBar(
                  text: 'Fashion',
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
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ProductType(
                        press: () {
                          updateType('New');
                        },
                        //  image: 'images/icon/new.png',
                        name: 'New',
                      ),
                      ProductType(
                        press: () {
                          updateType('Used');
                        },
                        //  image: 'images/icon/used.png',
                        name: 'Used',
                      ),
                      ProductType(
                        press: () {
                          updateType('Free');
                        },
                        // image: 'images/icon/donate.png',
                        name: 'Free',
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
                        press: () {
                          updateCategory('Men');
                        },
                        image: 'images/icon/jec_men.png',
                        name: 'Men',
                      ),
                      CatProduct(
                        press: () {
                          updateCategory('Women');
                        },
                        image: 'images/icon/woman.png',
                        name: 'Women',
                      ),
                      CatProduct(
                        press: () {
                          updateCategory('Shoes');
                        },
                        image: 'images/icon/shoes_A.png',
                        name: 'Shoes',
                      ),
                      CatProduct(
                        press: () {
                          updateCategory('Kids');
                        },
                        image: 'images/icon/kids.png',
                        name: 'Kids',
                      ),
                      CatProduct(
                        press: () {
                          updateCategory('Bags');
                        },
                        image: 'images/icon/bag.png',
                        name: 'Bags',
                      ),
                      CatProduct(
                        press: () {
                          updateCategory('Clock');
                        },
                        image: 'images/icon/clock.png',
                        name: 'Clock',
                      ),
                      CatProduct(
                        press: () {
                          updateCategory('Glasses');
                        },
                        image: 'images/icon/glasses.png',
                        name: 'Glasses',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  //  child:Carousel(),
                ),
                Container(
                  height: 750,
                  child: RecentProd(
                      category: selectedCategory, type: selectedType),
                ),
              ],
            ),
          ),
        ));
  }
}
