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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustemAppBar(
              text: selectedCategory,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProductType(
                    press: () {
                      updateType(MultiLanguage.isEnglish ? 'New' : 'جديد');
                      updateSelectedType(TypeProductState.newprod);
                    },
                    name: MultiLanguage.isEnglish ? 'New' : 'جديد',
                    selectedType: TypeProductState.newprod,
                    currentSelectedType: currentSelectedType,
                    updateSelectedType: updateSelectedType,
                  ),
                  ProductType(
                    press: () {
                      updateType(MultiLanguage.isEnglish ? 'Used' : 'مستعمل');
                      updateSelectedType(TypeProductState.usedprod);
                    },
                    name: MultiLanguage.isEnglish ? 'Used' : 'مستعمل',
                    selectedType: TypeProductState.usedprod,
                    currentSelectedType: currentSelectedType,
                    updateSelectedType: updateSelectedType,
                  ),
                  ProductType(
                    press: () {
                      updateType(MultiLanguage.isEnglish ? 'Free' : 'مجاني');
                      updateSelectedType(TypeProductState.freeprod);
                    },
                    name: MultiLanguage.isEnglish ? 'Free' : 'مجاني',
                    selectedType: TypeProductState.freeprod,
                    currentSelectedType: currentSelectedType,
                    updateSelectedType: updateSelectedType,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (MediaQuery.of(context).size.width > 1000)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    //  scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the row

                      // children: List.generate(
                      //   allProductData.length,
                      //   (index) =>
                      children: [
                        MediaQuery.of(context).size.width > 1000
                            ? Center(
                                child: SizedBox(
                                  width:
                                      800, // Adjust the width as needed   // 600  3 0.7  5.0
                                  child: RecentProd(
                                    TypeOfCategory: selectedCategory,
                                    prodState: selectedProdState,
                                    prod: allProductData,
                                    detail: allProductDetails,
                                  ),
                                ),
                              )
                            : RecentProd(
                                // For mobile, directly render RecentProd
                                TypeOfCategory: selectedCategory,
                                prodState: selectedProdState,
                                prod: allProductData,
                                detail: allProductDetails,
                              ),
                      ],
                      // ),
                    ),
                  ),
                ),
              ),
            //
            if (MediaQuery.of(context).size.width < 700)
              Container(
                //    height: 500,
                padding: EdgeInsets.only(left: 3, right: 3),
                child: RecentProd(
                  TypeOfCategory: selectedCategory,
                  prodState: selectedProdState,
                  prod: allProductData,
                  detail: allProductDetails,
                ),
              ),

            //
          ],
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
                CartState().resetCart();
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
