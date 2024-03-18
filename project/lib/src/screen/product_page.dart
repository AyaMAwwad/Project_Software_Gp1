// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/prod_type.dart';
import 'package:project/widgets/recent_prod.dart';

class ProductPage extends StatefulWidget {
  final Category category;
  final String type;
  ProductPage(this.type, this.category);

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  late String selectedCategory;
  String selectedProdState = 'New';

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.type;
    //selectedType = categoryTypes[selectedCategory]![0];
  }

  void updateType(String prodState) {
    setState(() {
      selectedProdState = prodState;
    });
  }

  //////////////////////////////////////////////////
  TypeProductState currentSelectedType = TypeProductState.newprod;

  void updateSelectedType(TypeProductState selectedType) {
    setState(() {
      currentSelectedType = selectedType;
    });
  }

  void handleProductTypeSelection(String typeName) {
    switch (typeName) {
      case 'New':
        updateSelectedType(TypeProductState.newprod);
        // Add functionality specific to 'New' product type
        break;
      case 'Used':
        updateSelectedType(TypeProductState.usedprod);
        // Add functionality specific to 'Used' product type
        break;
      case 'Free':
        updateSelectedType(TypeProductState.freeprod);
        // Add functionality specific to 'Free' product type
        break;
      default:
        break;
    }
  }
  ///////////////////////////////////////////////////

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenCategory(widget.category)),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
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
                height: 40,
                //  child:Carousel(),
              ),
              Container(
                margin: EdgeInsets.only(right: 15, left: 15),
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the desired size of the circle
                height: 50, // Set the desired size of the circle
                // color: Color.fromARGB(255, 95, 150, 168),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      Colors.transparent, //Color.fromARGB(255, 147, 176,186),
                  // Color.fromARGB(255, 95, 150, 168), // Color.fromARGB(
                  // 255, 134, 135, 134), // Color.fromARGB(255, 95, 150, 168),
                  // borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Container(
                  height: 60,
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.13)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.05),
                              ]),
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ProductType(
                              press: () {
                                updateType('New');
                                //handleProductTypeSelection('New');

                                updateSelectedType(TypeProductState.newprod);
                              },
                              //  image: 'images/icon/new.png',
                              name: 'New',
                              selectedType: TypeProductState.newprod,
                              currentSelectedType: currentSelectedType,
                              updateSelectedType: updateSelectedType,
                              //selectedtype: TypeState.newprod,
                            ),
                            ProductType(
                              press: () {
                                updateType('Used');
                                //handleProductTypeSelection('Used');

                                updateSelectedType(TypeProductState.usedprod);
                              },
                              //  image: 'images/icon/used.png',
                              name: 'Used',
                              selectedType: TypeProductState.usedprod,
                              currentSelectedType: currentSelectedType,
                              updateSelectedType: updateSelectedType,
                              //selectedtype: TypeState.usedprod,
                            ),
                            ProductType(
                              press: () {
                                updateType('Free');
                                // handleProductTypeSelection('Free');

                                updateSelectedType(TypeProductState.freeprod);
                              },
                              // image: 'images/icon/donate.png',
                              name: 'Free',
                              selectedType: TypeProductState.freeprod,

                              currentSelectedType: currentSelectedType,
                              updateSelectedType: updateSelectedType,
                              // selectedtype: TypeState.freeprod,
                            ),
                          ],
                        ),
                      ),

                      ///////////
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                //  child:Carousel(),
              ),
              Container(
                height: 750,
                child: RecentProd(
                    category: selectedCategory, prodState: selectedProdState),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
