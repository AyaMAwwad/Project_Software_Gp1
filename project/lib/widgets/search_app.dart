// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/src/screen/ipaddress.dart';

class SearchAppBar extends StatelessWidget {
  static final TextEditingController controller = TextEditingController();
  static List<Map<String, dynamic>> allProductDataForSearch = [];
  static List<Map<String, dynamic>> allProductDetailsForSearch = [];
  String selected = '';
  String search = "136".tr;
  static String val = '';
  String valofCont = '';
  static List<String> ListRecentSearch = [];

  // static const List<String> listItem = <String>['aya', 'fashion', 'hello '];
  // static bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    // ibtisam **
    double containerWidth = MediaQuery.of(context).size.width;
    double adjustedWidth = containerWidth - 20;
    // ibtisam **
    return Padding(
      // height: 50,
      padding: EdgeInsets.all(10),
      child: // Center(child:
          // ibtisam ****
          //   SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          // child:
          Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            width: containerWidth > 1000 ? containerWidth - 320 : adjustedWidth,
            child: Column(
              // ibtisam ****
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        //  width: containerWidth > 1000? containerWidth-300:containerWidth,
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Container(
                          width:
                              300, // Initial width of the Autocomplete widget
                          child: Autocomplete<String>(
                            optionsBuilder: (TextEditingValue textEditVal) {
                              if (textEditVal.text == '') {
                                return Iterable<String>.empty();
                              }
                              return SearchPage.listItem.where((String item) {
                                return item
                                    .contains(textEditVal.text.toLowerCase());
                              });
                            },
                            onSelected: (value) {
                              val = value;
                              selected = value;
                              // ListRecentSearch.add(value);
                              //  ListRecentSearch.add(value);
                              if (!ListRecentSearch.contains(value)) {
                                ListRecentSearch.add(value);
                                print(
                                    '^^^^^^ ListRecentSearch : $ListRecentSearch');
                              }
                              print(
                                  '^^^^^^ ListRecentSearch : $ListRecentSearch');
                              print('Selected: $value');
                            },
                            fieldViewBuilder: (context, controller, focusNode,
                                onFieldSubmitted) {
                              return Builder(
                                builder: (context) {
                                  return TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    onChanged: (value) {
                                      valofCont = value;
                                      // val = controller.text; //value;
                                      SearchPage.serachGet(controller.text);
                                    },
                                    onTap: () {
                                      HomePageState.isPressTosearch = true;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.search,
                                        color: Color.fromARGB(255, 2, 92, 123),
                                        size: 20,
                                      ),
                                      hintText: '$search...',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 78, 78, 78),
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<String> onSelected,
                                Iterable<String> options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Material(
                                      elevation: 4.0,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      child: Container(
                                        width: 300,
                                        child: SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final option =
                                                  options.elementAt(index);

                                              //    selected = option;
                                              // String s = onSelected(option);
                                              return ListTile(
                                                title: Text(
                                                  option,
                                                  style: GoogleFonts.aBeeZee(
                                                    textStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 16,
                                                      decorationThickness: 1,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () => onSelected(option),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      //padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 95, 150, 168),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.sort_by_alpha,
                          color: Color.fromARGB(255, 2, 92, 123),
                        ),
                        onPressed: () async {
                          await searchbyName(context, selected);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ), //),
        ], // children ibtisam
        //),
      ),
      //  ),
    );
  }

  static Future<void> searchbyName(BuildContext context, String value) async {
    HomePageState.isPressTosearch = false;

    print('*************in button click ');
    final List<Category> categories = [
      Category(name: '50'.tr, imagePath: 'images/icon/fashion.jpg'),
      Category(name: '51'.tr, imagePath: 'images/icon/books.jpg'),
      Category(name: '52'.tr, imagePath: 'images/icon/game.jpg'),
      Category(name: '53'.tr, imagePath: 'images/icon/vehicles.jpg'),
      Category(name: '54'.tr, imagePath: 'images/icon/furniture.jpg'),
      Category(name: '55'.tr, imagePath: 'images/icon/mobile.jpg'),
      Category(name: '56'.tr, imagePath: 'images/icon/Houseware.jpg'),
    ];
    /* print(controller.text);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScreenCategory(categories[0])),
    );*/
    print('********selected:' + value);
    if (value == 'fashion' || value == '50'.tr) {
      //print('fasfas');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[0])),
      );
    } else if (value == 'books' || value == '51'.tr || value == 'book') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[1])),
      );
    } else if (value == 'game' || value == '52'.tr || value == 'games') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[2])),
      );
    } else if (value == 'vehichle' ||
        value == '53'.tr ||
        value == 'vehichles') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[3])),
      );
    } else if (value == 'furniture' || value == '54'.tr) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[4])),
      );
    } else if (value == 'smart device' ||
        value == '55'.tr ||
        value == 'smart devices') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[5])),
      );
    } else if (value == 'houseware' || value == '56'.tr) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenCategory(categories[6])),
      );
    } else {
      print('************* in else');
      //  print('**** the selected:${valofCont}');
      HomePageState.isPressTosearchButton = true;
      print(value);

      allProductDataForSearch.clear;
      allProductDetailsForSearch.clear;
      /* selected.length == 0
          ? serachGetTheProduct(valofCont)
          : */
      serachGetTheProduct(value);
      Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 2, 92, 123)),
        ),
      );

      await Future.delayed(Duration(seconds: 2));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  static Future<Map<String, dynamic>?> serachGetTheProduct(String name) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/search/retriveProductOfsearch?name=$name'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('results') &&
            responseData.containsKey('allProductDetails')) {
          // Extract allProductData and allProductDetails from the response
          allProductDataForSearch =
              List<Map<String, dynamic>>.from(responseData['results']);
          allProductDetailsForSearch = List<Map<String, dynamic>>.from(
              responseData['allProductDetails']);
          print(allProductDetailsForSearch);
        } else {
          print('Failed to fetch data. ');
        }
      } else {
        print('Failed to fetch cart. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: ${response?.body}');
    }
    return null;
  }
}

/*// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/widgets/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchAppBar extends StatelessWidget {
  static final TextEditingController controller = TextEditingController();
  static const List<String> listItem = <String>['aya', 'fashion', 'hello '];
  // static bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      // height: 50,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Color.fromARGB(255, 2, 92, 123),
                        size: 20,
                      ),
                      hintStyle: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 78, 78, 78),
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      HomePageState.isPressTosearch = true;
                      /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                            text: controller.text,
                          ),
                        ),
                      );*/
                    },
                    onChanged: (value) {
                      SearchPage.serachGet(controller.text);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 95, 150, 168),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.sort_by_alpha,
                    color: Color.fromARGB(255, 2, 92, 123),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
