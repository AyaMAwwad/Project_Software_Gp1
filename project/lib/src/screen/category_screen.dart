// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/product_page.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';

class ScreenCategory extends StatefulWidget {
  final Category category;
  ScreenCategory(this.category);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  var height, width;

  Map<String, List<String>> categoryTypes = {
    'Fashion': [
      'Men',
      'Women',
      'Shoes',
      'Kids',
      'Bags',
      'Clock',
      'Glasses',
    ],
    'Smart devices': [
      'Mobile',
      'Laptob',
      'iPad',
      'AirPods',
      'computer',
      'Watch',
      'cmputer',
      'Tablet',
      'TV',
      'Wearable Fitness Trackers',
      'speakers',
    ],
    'Books': ['Other'],
    'Games': ['Other'],
    'Houseware': ['Other'],
    'Vehicles': ['Other'],
    'Furniture': ['Other'],
  };

  Map<String, List<String>> categoryimage = {
    'Fashion': [
      'images/icon/men_back.png',
      'images/icon/wom_back.png',
      'images/icon/shoes_back.png',
      'images/icon/kids_back.png',
      'images/icon/bag_back.png',
      'images/icon/watch_back.png',
      'images/icon/glass1_back.png',
    ],
    'Smart devices': [
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
      'images/icon/woman.png',
    ],
    'Books': ['images/icon/jec_men.png'],
    'Games': ['images/icon/jec_men.png'],
    'Houseware': ['images/icon/jec_men.png'],
    'Vehicles': ['images/icon/jec_men.png'],
    'Furniture': ['images/icon/jec_men.png'],
  };
  late String selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category.name;
    //selectedType = categoryTypes[selectedCategory]![0];
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
          child: SingleChildScrollView(
        child: Column(
          children: [
            CustemAppBar(
              text: selectedCategory,
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            SearchAppBar(),
            SizedBox(
              height: 30,
              //  child:Carousel(),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryTypes[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  String type = categoryTypes[selectedCategory]![index];
                  String image = categoryimage[selectedCategory]![index];

                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(type, widget.category)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 1,
                            //  blurRadius: 6,
                          ),
                        ],
                      ),
                      /* child: Container(
                        width: 50,
                        height: 50,
                        //margin:
                        //  EdgeInsets.symmetric(vertical: 40, horizontal: 38),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color:
                              Color.fromARGB(255, 2, 92, 123).withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),*/

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 80, // Set the desired size of the circle
                              height: 80, // Set the desired size of the circle
                              color: Color.fromARGB(255, 95, 150, 168),

                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  image,
                                  width: 50,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            type,
                            style: GoogleFonts.aDLaMDisplay(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 95, 150, 168),
                                // Color.fromARGB(255, 4, 51, 67),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
