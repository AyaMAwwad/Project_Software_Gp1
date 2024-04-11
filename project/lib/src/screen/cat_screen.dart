// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/cat_product.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/prod_type.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';

class CategScreen extends StatefulWidget {
  final Category category;
  CategScreen(this.category);

  @override
  CategState createState() => CategState();
}

class CategState extends State<CategScreen> {
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
      'images/icon/jec_men.png',
      'images/icon/woman.png',
      'images/icon/shoes_A.png',
      'images/icon/kids.png',
      'images/icon/bag.png',
      'images/icon/clock.png',
      'images/icon/glasses.png',
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
  String selectedType = 'Men';
  String selectedProdState = 'New';

  late String selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category.name;
    selectedType = categoryTypes[selectedCategory]![0];
  }

  void updateCategory(String type) {
    setState(() {
      selectedType = type;
    });
  }

  void updateType(String prodState) {
    setState(() {
      selectedProdState = prodState;
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
                  text: selectedCategory,
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
                      /* ProductType(
                        press: () {
                          updateType('New');
                        },
                        //  image: 'images/icon/new.png',
                        name: 'New',
                        //selectedtype: TypeState.newprod,
                      ),
                      ProductType(
                        press: () {
                          updateType('Used');
                        },
                        //  image: 'images/icon/used.png',
                        name: 'Used',
                        //selectedtype: TypeState.usedprod,
                      ),
                      ProductType(
                        press: () {
                          updateType('Free');
                        },
                        // image: 'images/icon/donate.png',
                        name: 'Free',
                        // selectedtype: TypeState.freeprod,
                      ),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                  //  child:Carousel(),
                ),
                Container(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // children: [
                    itemCount: categoryTypes[selectedCategory]!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String type = categoryTypes[selectedCategory]![index];
                      String image = categoryimage[selectedCategory]![index];
                      return CatProduct(
                        press: () {
                          updateCategory(type);
                        },
                        image: image,

                        ///getImageForType(type),
                        name: type,
                      );
                    },
                    /* CatProduct(
                        press: () {
                          updateCategory('Men');
                        },
                        image: 'images/icon/jec_men.png',
                        name: selectedType,
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
                      ),*/
                    //],
                  ),
                ),
                SizedBox(
                  height: 30,
                  //  child:Carousel(),
                ),
                Container(
                  height: 750,
                  child: RecentProd(
                      TypeOfCategory: selectedType,
                      prodState: selectedProdState),
                ),
              ],
            ),
          ),
        ));
  }
}
*/