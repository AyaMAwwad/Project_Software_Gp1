// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/product_page.dart';
import 'package:project/widgets/cart_shop.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecentProd extends StatelessWidget {
  final String TypeOfCategory;
  final String prodState;
  static String? thestate;
  final List<Map<String, dynamic>> prod;
  final List<Map<String, dynamic>> detail;

  RecentProd(
      {required this.TypeOfCategory,
      required this.prodState,
      required this.prod,
      required this.detail});

  @override
  Widget build(BuildContext context) {
    thestate = prodState;
    print(prodState);
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 300)), // Simulating a delay
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If still waiting, show CircularProgressIndicator
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 2, 92, 123)),
            ),
          );
        } else {
          // After waiting, check if there is data
          if (prod.isEmpty) {
            // If no data available, show "Product not available" text
            return Center(
              child: Text(
                'Product is not available',
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 20,
                  decorationThickness: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            // If data available, display the product grid
            return SingleChildScrollView(
              child: GridView.builder(
                itemCount: prod.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.70),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: RecentSingleProd(
                      recet_prod_description: prod[index]['description'],
                      recet_prod_name: prod[index]['name'],
                      recet_prod_image: prod[index]['image'], //bytes,
                      recet_prod_price: detail[index]['price'],
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}

/*
class RecentProd extends StatelessWidget {
  final String TypeOfCategory;
  final String prodState;
  static String? thestate;
  final List<Map<String, dynamic>> prod;
  final List<Map<String, dynamic>> detail;

  RecentProd(
      {required this.TypeOfCategory,
      required this.prodState,
      required this.prod,
      required this.detail});

  final prodList = [
    {
      'name': 'Sweatshirt',
      'image': 'images/icon/clo_A.png',
      'price': 50,
      'description': '7777',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/clo_B.jpeg',
      'price': 220,
      'description': 'dada',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/clo_C.jpeg',
      'price': 150,
      'description': 'jadja',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'Howdy',
      'image': 'images/icon/clo_D.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'Crossbody Bag',
      'image': 'images/icon/bag1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'New',
    },
    {
      'name': 'School Bag',
      'image': 'images/icon/bag2.jpeg',
      'price': 80,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'New',
    },
    {
      'name': 'White Bag',
      'image': 'images/icon/bag3.jpeg',
      'price': 120,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'New',
    },
    {
      'name': 'Black Glasses',
      'image': 'images/icon/glas1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Glasses',
      'type': 'New',
    },
    {
      'name': 'Black Glasses',
      'image': 'images/icon/glas2.png',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Glasses',
      'type': 'New',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/watch1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'New',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/clo1.jpeg',
      'price': 150,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'New',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/clo2.jpeg',
      'price': 100,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'New',
    },
    {
      'name': 'Blazer & Pants',
      'image': 'images/icon/wom1.jpeg',
      'price': 200,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'Bizwear',
      'image': 'images/icon/wom2.jpeg',
      'price': 130,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/wom3.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'Dress',
      'image': 'images/icon/dress.jpeg',
      'price': 180,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'shoes Men',
      'image': 'images/icon/sho1.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'New',
    },
    {
      'name': 'shoes Women',
      'image': 'images/icon/sho22.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'New',
    },
    {
      'name': 'Heeles',
      'image': 'images/icon/sho3.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids2.jpeg',
      'price': 70,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },

    {
      'name': 'Kids',
      'image': 'images/icon/kids3.jpeg',
      'price': 120,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids4.jpeg',
      'price': 80,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
    /////////////////////// used
    {
      'name': 'Pants & Shirt',
      'image': 'images/icon/fash_use1.jpeg',
      'price': 100,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'Used',
    },
    {
      'name': 'Dress',
      'image': 'images/icon/fash_use2.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'Used',
    },
    {
      'name': 'Dress',
      'image': 'images/icon/fash_use3.jpeg',
      'price': 150,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'Used',
    },
    {
      'name': 'Dress',
      'image': 'images/icon/fash_use4.jpeg',
      'price': 70,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'Used',
    },
    {
      'name': 'Suit',
      'image': 'images/icon/men_use1.jpeg',
      'price': 170,
      'description': 'dada',
      'category': 'Men',
      'type': 'Used',
    },
    {
      'name': 'Suit',
      'image': 'images/icon/men_use2.jpeg',
      'price': 100,
      'description': 'dada',
      'category': 'Men',
      'type': 'Used',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids_use1.jpeg',
      'price': 50,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'Used',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids_use2.jpeg',
      'price': 40,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'Used',
    },
    {
      'name': ' Bag',
      'image': 'images/icon/bag_use1.jpeg',
      'price': 60,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'Used',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/wat_use1.jpeg',
      'price': 30,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'Used',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/wat_use2.jpeg',
      'price': 50,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'Used',
    },
    {
      'name': 'Glasses',
      'image': 'images/icon/glas_use1.jpeg',
      'price': 60,
      'description': 'sjajsa',
      'category': 'Glasses',
      'type': 'Used',
    },
    ////////////// free
    {
      'name': 'shirt',
      'image': 'images/icon/wom_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'Free',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/wom_free2.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'Free',
    },
    {
      'name': 'shirt',
      'image': 'images/icon/men_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Men',
      'type': 'Free',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/men_free2.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Men',
      'type': 'Free',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/clock_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'Free',
    },
    {
      'name': 'Glasses',
      'image': 'images/icon/glass_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Glasses',
      'type': 'Free',
    },
    {
      'name': 'Bags',
      'image': 'images/icon/bag_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'Free',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids_free2.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'Free',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'Free',
    },
    {
      'name': 'shoes',
      'image': 'images/icon/shoes_free2.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'Free',
    },
    {
      'name': 'shoes ',
      'image': 'images/icon/shoes_free1.jpeg',
      'price': 'Free',
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'Free',
    },
    //------------
  ];
  // static List<Map<String, dynamic>> allProductData = [];
  // static List<Map<String, dynamic>> allProductDetails = [];
  @override
  Widget build(BuildContext context) {
    thestate = prodState;
    print(prodState);
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    if (prod.length == 0) {
      return Center(
        child: Text(
          'This Product is not available',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 2, 92, 123),
              fontSize: 20,

              // decoration: TextDecoration.underline,
              decorationThickness: 1,
              fontWeight: FontWeight.bold,
              //padding: 10,
            ),
          ),
        ),
      );
    } else {
      /* final List<Map<String, dynamic>> filteredProducts = RecentProd.allProductData
        .where((product) => product['category'] == 'Fashion' && product['type'] == 'Women' && product['state'] == 'New')
        .toList();*/

      return SingleChildScrollView(
        child: GridView.builder(
          itemCount: prod.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.70),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: RecentSingleProd(
                recet_prod_description: prod[index]['description'],
                recet_prod_name: prod[index]['name'],
                recet_prod_image: prod[index]['image'], //bytes,
                recet_prod_price: detail[index]['price'],
              ),
            );
          },
        ),
      );
    }
  }
}*/

class RecentSingleProd extends StatefulWidget {
  final recet_prod_name;
  final recet_prod_image;
  final recet_prod_price;
  final recet_prod_description;

  const RecentSingleProd(
      {super.key,
      this.recet_prod_name,
      this.recet_prod_image,
      this.recet_prod_price,
      this.recet_prod_description});

  @override
  State<RecentSingleProd> createState() => _RecentSingleProdState();
}

class _RecentSingleProdState extends State<RecentSingleProd> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> imageData = widget.recet_prod_image;
    List<int> bytes = List<int>.from(imageData['data']);
    String textP = '';
    double? width = 0.0;

    if (RecentProd.thestate == 'Free') {
      textP = 'Free';
      width = 100;
    } else {
      textP = 'Price:\$${widget.recet_prod_price}';
      width = 40;
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
            width: 180,
            //height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 239, 237, 245),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  // child: Text(recet_prod_name), //
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: // Image.asset(
                        // imagePath[0],
                        Image.memory(
                      // Use Image.memory for Uint8List
                      Uint8List.fromList(bytes),
                      // 200
                      fit: BoxFit.cover,
                    ),
                    /*child: Image.asset(
                      //Image.memory(
                      'images/icon/kids_free1.jpeg',
                      // Use Image.memory for Uint8List
                      // Uint8List.fromList('images/icon/kids_free1.jpeg' ),//(widget.recet_prod_image),
                      width: 150,
                      height: 200, // 200
                      fit: BoxFit.cover,
                    ),*/

                    /*child: Image.asset(
                      'images/icon/kids_free1.jpeg',
                      fit: BoxFit.cover,
                    ),*/
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recet_prod_name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          '${textP}',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        SizedBox(
                          width: width,
                        ),
                        GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.facebookMessenger,
                            size: 18,
                            color: Color.fromARGB(255, 2, 92, 123),
                          ),
                          onTap: () async {
                            OpenChatWithSellar.functionForChar(
                                widget.recet_prod_name, context);
                          },
                        ),
                      ],
                    ),
                    /* Text(
                      widget.recet_prod_description,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),*/
                  ],
                ),
                /* ListTile(
                  title: Text(
                    widget.recet_prod_name,
                    //  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(widget.recet_prod_description),
                  trailing: Text(
                    'Price:\$${widget.recet_prod_price}',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  //subtitle: Text('\$${recet_prod_price}'),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

//getProductTypeState('Fashion', 'Women', 'New');
  /* static Future<Map<String, dynamic>?> getProductTypeState(
      String category, String type, String state) async {
    print('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/Product/typeofproduct?category=$category&type=$type&state=$state'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::');
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('allProductData') &&
            responseData.containsKey('allProductDetails')) {
          // Extract allProductData and allProductDetails from the response
          RecentProd.allProductData =
              List<Map<String, dynamic>>.from(responseData['allProductData']);
          RecentProd.allProductDetails = List<Map<String, dynamic>>.from(
              responseData['allProductDetails']);

          print(RecentProd.allProductData);
          print(RecentProd.allProductDetails);
          print(RecentProd.allProductData[0]['name']);
          print("LALALALALALLALALLALLALLLALALLAAL");
          // print(RecentProd.allProductData[1]);
          // Use allProductData and allProductDetails as needed
          // For example:
          // for (var productData in allProductData) {
          //   print('Product Name: ${productData['name']}');
          // }
        } else {
          throw Exception('Invalid response data format');
        }
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e, Response body: ${response?.body}');
      throw Exception('Failed to fetch data: $e');
    }
    return null;
  }
*/
/*
  Future<Map<String, dynamic>?> getProductTypeState(
      String category, String type, String state) async {
    http.Response? response;

    // print(Login.Email);
    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/Product/typeofproduct?category=$category&type=$type&state=$state'));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          // Extract price from the first item in the list

          dynamic user = responseData;
          /* if (email == Login.Email) {
            FirstNameSender = user['first_name'];
            LastNameSender = user['last_name'];
            dynamic userId = user['user_id'].toString();
          } else {
            FirstNameReceiver = user['first_name'];
            LastNameReceiver = user['last_name'];
            dynamic userId = user['user_id'].toString();
          }*/

          //  dynamic userId = responseData[2];

          //print(FirstName + LastName + userId);
        } else {
          throw Exception('Empty or invalid response data format for price');
        }
      } else {
        throw Exception(
            'Failed to fetch price for product . Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e, Response body: ${response?.body}');
      throw Exception('Failed to fetch price for product : $e');
    }
  }*/
}
