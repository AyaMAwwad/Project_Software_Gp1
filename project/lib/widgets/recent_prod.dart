// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project/src/screen/detailpage.dart';

import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/multiLanguage.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/product_page.dart';
import 'package:project/widgets/cart_shop.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:translator/translator.dart';

class RecentProd extends StatelessWidget {
  final String TypeOfCategory;
  final String prodState;
  static String? thestate;
  static int? theProdId;
  final List<Map<String, dynamic>> prod;
  final List<Map<String, dynamic>> detail;

  RecentProd(
      {required this.TypeOfCategory,
      required this.prodState,
      required this.prod,
      required this.detail});
  /*Future<void> translateProductNames(
      List<Map<String, dynamic>> products) async {
    await Future.forEach(products, (product) async {
      print('^^^^^^^^^^^^^^^^^^');
      product['name'] = MultiLanguage.isArabic
          ? await LangugeService.transFromEnglishToArabic(product['name'])
          : await LangugeService.transFromArabicToEnglish(product['name']);
      print(product['name']);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    // GoogleTranslator translate = GoogleTranslator();
    thestate = prodState;

    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 300)), // Simulating a delay
      builder: (context, snapshot) {
        //translateProductNames(prod);
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
            /*  for (int i = 0; i < prod.length; i++)  {
              print('^^^^^^^^^^^^^^^^^^');
              prod[i]['name'] = MultiLanguage.isArabic
                  ?  LangugeService.transFromEnglishToArabic(prod[i]['name'])
                  :  LangugeService.transFromArabicToEnglish(prod[i]['name']);
              print(prod[i]['name']);
            }*/
            /*
            int i = 0;
            prod.forEach((product) async {
              print('^^^^^^^^^^^^^^^^^^');
              /*  var translation = MultiLanguage.isArabic
                  ? await translator.translate(product['name'],
                      from: 'en', to: 'ar')
                  : await translator.translate(product['name'],
                      from: 'ar', to: 'en');*/
              prod[i]['name'] = MultiLanguage.isArabic
                  ? LangugeService.transFromEnglishToArabic(product['name'])
                      .toString()
                  : LangugeService.transFromArabicToEnglish(product['name'])
                      .toString();
              print('WEEEEWEEEEEEEEEWEEEEEEEEEWEEEEEEEEEEE');
              print(prod[i]['name']);
              //   prod[i]['name'] = translation;
              i++;

              // Translate other fields as needed
            });*/
            // If data available, display the product grid
            return SingleChildScrollView(
              child: GridView.builder(
                itemCount: prod.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  mainAxisSpacing: 5.0,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  theProdId = prod[index]['product_id'];
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
  State<RecentSingleProd> createState() => RecentSingleProdState();
}

class RecentSingleProdState extends State<RecentSingleProd> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> imageData = widget.recet_prod_image;
    List<int> bytes = List<int>.from(imageData['data']);
    String textP = '';
    double? width = 0.0;

    if (RecentProd.thestate == 'Free' || RecentProd.thestate == 'مجاني') {
      textP = 'Free';
      width = 100;
    } else {
      textP = 'Price:\$${widget.recet_prod_price}';
      width = 40;
    }
    return GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
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
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 46, 82),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${textP}',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Icon(
                                FontAwesomeIcons.facebookMessenger,
                                size: 16,
                                color: Color.fromARGB(255, 2, 92, 123),
                              ),
                              onTap: () async {
                                OpenChatWithSellar.functionForChar(
                                    widget.recet_prod_name, context);
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.shopping_cart_checkout,
                                //FontAwesomeIcons.cartShopping,
                                size: 17,
                                color: Color.fromARGB(255, 2, 92, 123),
                              ),
                              onTap: () async {
                                DateTime now = DateTime.now();
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd – kk:mm').format(
                                        now); // Format the date as per your requirement

                                await shoppingCartStore(
                                    '1',
                                    formattedDate,
                                    widget.recet_prod_name,
                                    RecentProd.thestate!,
                                    widget.recet_prod_description);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                categoryName: widget.recet_prod_name,
                imagePaths: imageData,
                price: textP,
                productid: RecentProd.theProdId!,
                Typeproduct: RecentProd.thestate!,
              ),
            ),
          );
        });
  }

/*  */
  static Future<void> shoppingCartStore(
    String numberItem,
    String date,
    String name,
    String state,
    String description,
  ) async {
    final url =
        Uri.parse('http://192.168.0.114:3000/tradetryst/shoppingcart/add');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<dynamic, dynamic>{
          'id': Login.idd,
          'Number_Item': numberItem,
          'date': date,
          'name': name,
          'state': state,
          'description': description,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Authentication successful
        print('store to cart  successful');
        // Navigate to the home page or perform any other actions
      } else if (response.statusCode == 401) {
        //  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        // content: Text("not store"),
        // ));
        // Invalid email or password
        print('not store');
      } else {
        // Other error occurred
        print('failed to store Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
