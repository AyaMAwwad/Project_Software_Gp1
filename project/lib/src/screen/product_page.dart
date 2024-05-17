// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/multiLanguage.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/prod_type.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/user_profile.dart';

class ProductPage extends StatefulWidget {
  final Category category;
  final String type;
  ProductPage(this.type, this.category);

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  late String selectedCategory;
  String selectedProdState = MultiLanguage.isEnglish ? 'New' : 'جديد';
  static String TypeGlobal = '';
  static String StateGlobal = '';
  static String CategoryGlobal = '';
  List<Map<String, dynamic>> allProductData = [];
  List<Map<String, dynamic>> allProductDetails = [];

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.type;
    fetchProducts();
  }

  void fetchProducts() async {
    allProductData.clear();
    await getProductTypeState(
        widget.category.name, widget.type, selectedProdState);
    setState(() {});
  }

  void updateType(String prodState) async {
    setState(() async {
      selectedProdState = prodState;
      StateGlobal = prodState;
      print(prodState);
      await getProductTypeState(widget.category.name, widget.type, prodState);
      setState(() {});
    });
  }
  /*void updateType(String prodState) async {
  setState(() async {
    selectedProdState = prodState;
    StateGlobal = prodState;
    await getProductTypeState(widget.category.name, widget.type, prodState);
    setState(() {});
  });
} */

  TypeProductState currentSelectedType = TypeProductState.newprod;
  void updateSelectedType(TypeProductState selectedType) {
    setState(() {
      currentSelectedType = selectedType;
      fetchProducts(); // Fetch products based on the selected type
    });
  }

/*
  void updateSelectedType(TypeProductState selectedType) {
    setState(() {
      currentSelectedType = selectedType;

      TypeGlobal = selectedCategory;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    // getProductTypeState(widget.category.name, widget.type, selectedProdState);
    int selectedIndex = 0;
    CategoryGlobal = widget.category.name;
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
                /* decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      Colors.transparent, //Color.fromARGB(255, 147, 176,186),
                  // Color.fromARGB(255, 95, 150, 168), // Color.fromARGB(
                  // 255, 134, 135, 134), // Color.fromARGB(255, 95, 150, 168),
                  // borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(95, 218, 218, 218),
                      blurRadius: 5,
                    ),
                  ],
                ),*/
                child: Container(
                  height: 60,
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      /*  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.13)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 147, 198, 215),
                                // .withOpacity(0.15),
                                Color.fromARGB(255, 95, 150, 168),
                                // .withOpacity(0.1),
                                Color.fromARGB(255, 66, 119, 138),
                                //  .withOpacity(0.05),
                                Color.fromARGB(255, 95, 150, 168),
                                // .withOpacity(0.1),
                                Color.fromARGB(255, 147, 198, 215),
                                // .withOpacity(0.15),
                              ]),
                        ),
                        child:*/
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ProductType(
                            press: () {
                              updateType(
                                  MultiLanguage.isEnglish ? 'New' : 'جديد');
                              //handleProductTypeSelection('New');

                              updateSelectedType(TypeProductState.newprod);
                            },
                            //  image: 'images/icon/new.png',
                            name: MultiLanguage.isEnglish ? 'New' : 'جديد',
                            selectedType: TypeProductState.newprod,
                            currentSelectedType: currentSelectedType,
                            updateSelectedType: updateSelectedType,
                            //selectedtype: TypeState.newprod,
                          ),
                          /**ProductType(
  press: () {
    updateType('Used'); // Update to 'Used' product type
    updateSelectedType(TypeProductState.usedprod); // Update the selected type state
  },
  name: 'Used',
  selectedType: TypeProductState.usedprod,
  currentSelectedType: currentSelectedType,
  updateSelectedType: updateSelectedType,
), */
                          ProductType(
                            press: () {
                              updateType(
                                  MultiLanguage.isEnglish ? 'Used' : 'مستعمل');
                              //handleProductTypeSelection('Used');

                              updateSelectedType(TypeProductState.usedprod);
                            },
                            //  image: 'images/icon/used.png',
                            name: MultiLanguage.isEnglish ? 'Used' : 'مستعمل',
                            selectedType: TypeProductState.usedprod,
                            currentSelectedType: currentSelectedType,
                            updateSelectedType: updateSelectedType,
                            //selectedtype: TypeState.usedprod,
                          ),
                          ProductType(
                            press: () {
                              updateType(
                                  MultiLanguage.isEnglish ? 'Free' : 'مجاني');
                              // handleProductTypeSelection('Free');

                              updateSelectedType(TypeProductState.freeprod);
                            },
                            // image: 'images/icon/donate.png',
                            name: MultiLanguage.isEnglish ? 'Free' : 'مجاني',
                            selectedType: TypeProductState.freeprod,

                            currentSelectedType: currentSelectedType,
                            updateSelectedType: updateSelectedType,
                            // selectedtype: TypeState.freeprod,
                          ),
                        ],
                      ),
                      //    ),

                      ///////////
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
                //  child:Carousel(),
              ),
              Container(
                height: 500,
                padding: EdgeInsets.only(left: 3, right: 3),
                child: RecentProd(
                  TypeOfCategory: selectedCategory,
                  prodState: selectedProdState,
                  prod: allProductData,
                  detail: allProductDetails,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                HomePageState.isPressTosearch = false;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartShop()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
                break;
            }
          });
        },
        // context: context,
      ), /*BottomNavBar(
        selectedMenu: MenuState.home,
      ),*/
    );
  }

  Future<Map<String, dynamic>?> getProductTypeState(
      String category, String type, String state) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/Product/typeofproduct?category=$category&type=$type&state=$state'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('allProductData') &&
            responseData.containsKey('allProductDetails')) {
          // Extract allProductData and allProductDetails from the response
          allProductData =
              List<Map<String, dynamic>>.from(responseData['allProductData']);
          allProductDetails = List<Map<String, dynamic>>.from(
              responseData['allProductDetails']);
          //  final translator = GoogleTranslator();
          /*  int i = 0;
          allProductData.forEach((product) async {
            print('^^^^^^^^^^^^^^^^^^');
            var translation = MultiLanguage.isArabic
                ? await translator.translate(product['name'],
                    from: 'en', to: 'ar')
                : await translator.translate(product['name'],
                    from: 'ar', to: 'en');
            /*  allProductData[i]['name'] = MultiLanguage.isArabic
                ? LangugeService.transFromEnglishToArabic(product['name'])
                : LangugeService.transFromArabicToEnglish(product['name']);*/
            allProductData[i]['name'] = translation;
            i++;

            // Translate other fields as needed
          });*/
        } else {
          print('Failed to fetch data. ');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: '); //${response?.body}
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }
}
