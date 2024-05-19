// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:project/widgets/edit_sellar_product.dart';

class SellarPage extends StatefulWidget {
  @override
  SellarPageState createState() => SellarPageState();
}

class SellarPageState extends State<SellarPage> {
  static List<Map<String, dynamic>> productSellar = [];
  static List<Map<String, dynamic>> productSellarDetails = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    fetchProduct();
  }

  void fetchProduct() async {
    await getProductOfSellar(Login.idd);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteProduct(int productId) async {
    // Add your delete logic here
    setState(() {
      productSellar
          .removeWhere((product) => product['product_id'] == productId);
      productSellarDetails
          .removeWhere((detail) => detail['product_id'] == productId);
    });
  }

  void editProduct(int productId) {
    final productData = productSellar
        .firstWhere((product) => product['product_id'] == productId);
    final productDataDetails = productSellarDetails
        .firstWhere((product) => product['product_id'] == productId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(
          productId: productId,
          productData: productData,
          productDataDetails: productDataDetails,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                Navigator.of(context).pushReplacementNamed("homepagee");
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 2, 92, 123)),
                ),
              )
            : Column(
                children: [
                  CustemAppBar(
                    text: "144".tr,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: productSellar.isEmpty
                          ? Center(child: Text("No products to display"))
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.81,
                              ),
                              itemCount: productSellar.length,
                              itemBuilder: (context, index) {
                                final product = productSellar[index];
                                final details = productSellarDetails[index];
                                final Map<String, dynamic> imageData =
                                    product['image'];
                                List<int> bytes =
                                    List<int>.from(imageData['data']);
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 0.8,
                                          child: Image.memory(
                                            Uint8List.fromList(bytes),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 2,
                                          right: -8,
                                          child: PopupMenuButton<String>(
                                            onSelected: (value) async {
                                              if (value == 'edit') {
                                                editProduct(
                                                    product['product_id']);
                                              } else if (value == 'delete') {
                                                await deleteProductSellar(
                                                    product['product_id'],
                                                    product['product_type']);
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem(
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      IconsaxBold.edit_2,
                                                      color: Color.fromRGBO(
                                                          2, 92, 123, 1),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Edit',
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        textStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 2, 92, 123),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 'delete',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      IconsaxBold.box_remove,
                                                      color: Color.fromRGBO(
                                                          2, 92, 123, 1),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Delete',
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        textStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 2, 92, 123),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            icon: Icon(
                                              Icons.more_vert,
                                              color:
                                                  Color.fromRGBO(2, 92, 123, 1),
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

// delete
  Future<Map<String, dynamic>?> deleteProductSellar(
      int productid, String state) async {
    http.Response? response;

    try {
      response = await http.delete(Uri.parse(
          'http://$ip:3000/tradetryst/Product/deleteItemSellar?productid=$productid&state=$state'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('deleted  item');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body:');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

  // retrive product
  static Future<Map<String, dynamic>?> getProductOfSellar(int userId) async {
    http.Response? response;
    print('*********************8 in getProductOfSellar user id : $userId ');
    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/Product/sallerProduct?userId=$userId'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('results') &&
            responseData.containsKey('allProductDetails')) {
          // Extract allProductData and allProductDetails from the response
          productSellar =
              List<Map<String, dynamic>>.from(responseData['results']);
          productSellarDetails = List<Map<String, dynamic>>.from(
              responseData['allProductDetails']);
          print(productSellar);
          print(productSellarDetails);
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
