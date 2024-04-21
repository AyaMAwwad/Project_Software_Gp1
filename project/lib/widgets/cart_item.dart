// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_cast, use_key_in_widget_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/demo_counter.dart';

class CartItem extends StatefulWidget {
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  List<Map<String, dynamic>> cartShopContain = [];
  List<Map<String, dynamic>> productInCart = [];
  List<Map<String, dynamic>> allProductDetails = [];
  List<int?> selectedRadioValues = [];
  static List<int> productCount = [];
  String? valueState;
  String? theValueState;
  int? theValueState1;
  bool colorEnabled = false;
  Color? activeColor;
  static List<bool> selectedCheckboxes = [];
  static bool allCheckboxChecked = false;

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int i = 0; i < productInCart.length; i++) {
      if (selectedCheckboxes[i]) {
        Map<String, dynamic> details = allProductDetails[i];
        double price = double.parse(details['price']);

        int count = productCount[i];

        totalPrice += price * count;
      }
    }
    return totalPrice;
  }

  void deleteProduct(int index) {
    setState(() {
      productInCart.removeAt(index);
      allProductDetails.removeAt(index);
      cartShopContain.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();

    fetchCart();
  }

  void fetchCart() async {
    await getProductCart();

    setState(() {
      if (selectedCheckboxes == null || selectedCheckboxes.isEmpty) {
        selectedCheckboxes =
            List.generate(productInCart.length, (index) => false);
      }
      if (productCount == null || productCount.isEmpty) {
        productCount = List.generate(productInCart.length, (index) => 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   height: MediaQuery.of(context).size.height,
      body: Column(
        children: [
          Container(
            height: 60,
            color: const Color.fromARGB(255, 241, 235, 245),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: allCheckboxChecked
                          ? Color.fromARGB(255, 13, 60, 99)
                          : Colors.transparent,
                      child: Checkbox(
                        value: allCheckboxChecked,
                        onChanged: (value) {
                          setState(() {
                            allCheckboxChecked = value ?? false;
                            // Update the state of all individual checkboxes
                            selectedCheckboxes = List.filled(
                                selectedCheckboxes.length, allCheckboxChecked);
                          });
                        },
                        activeColor: Color.fromARGB(255, 13, 60, 99),
                        checkColor: Colors.white,
                        shape: CircleBorder(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'All',
                      style: TextStyle(
                        color: Color.fromARGB(255, 13, 60, 99),
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$${calculateTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 60, 99),
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                CustomeButton2(
                  text: 'CHECKOUT',
                  onPressed: () {
                    //Navigator.push(context,
                    //  MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productInCart.length,
              itemBuilder: (context, index) {
                final theproduct = productInCart[index];
                final details = allProductDetails[index];
                final imageData = theproduct['image'];
                final bytes = List<int>.from(imageData['data']);
                final productName = theproduct['name'];
                // final priceOfProd1 = details['price'];
                final quantity1 = theproduct['quantity'];

                ///
                String theState = theproduct['product_type'];
                int productId = theproduct['product_id'];
                // int thequantity = product['quantity'];
                String thepriceOfProd = (theState == 'new' ||
                        theState == 'New' ||
                        theState == 'Used' ||
                        theState == 'used')
                    ? details['price']
                    : 'Free';

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: selectedCheckboxes[index]
                                ? Color.fromARGB(255, 13, 60, 99)
                                : Colors.transparent,
                            child: Checkbox(
                              value: selectedCheckboxes[index],
                              onChanged: (value) {
                                setState(() {
                                  selectedCheckboxes[index] = value ?? false;
                                });
                              },
                              activeColor: Color.fromARGB(255, 13, 60, 99),
                              checkColor: Colors.white,
                              shape: CircleBorder(),
                            ),
                          ),
                          SizedBox(
                            // height: 10,
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 90,
                              height: 100,
                              child: Image.memory(
                                Uint8List.fromList(bytes),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        productName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 2, 46, 82),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price: $thepriceOfProd',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Quantity: $quantity1',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      trailing: CountItem(
                        count: productCount[index],
                        increment: () {
                          setState(() {
                            if (productCount[index] < quantity1) {
                              repos.incrementCounter(context, index);
                              productCount[index] =
                                  repos.getCount(context, index);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.orange,
                                          size: 24,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Quantity Out of Stock',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 13, 60, 99),
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                            letterSpacing: 1.2,
                                            shadows: [
                                              Shadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(2, 2),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      'The quantity of this product is above the range, That Exists of product  ${productName}: ${quantity1}',
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                          color: Color.fromARGB(255, 1, 3, 4),
                                          fontSize: 14,

                                          // decoration: TextDecoration.underline,
                                          decorationThickness: 1,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      CustomeButton2(
                                        text: 'OK',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        },
                        decrement: () {
                          setState(() {
                            if (productCount[index] > 1) {
                              repos.decrementCounter(context, index);
                              productCount[index] =
                                  repos.getCount(context, index);
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    // insetPadding: EdgeInsets.all(20),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2.0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                            255, 241, 235, 245), // Colors.white
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              'Confirm',
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 2, 92, 123),
                                                ),
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              'Are you sure you want to delete this item?',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 2, 92, 123),
                                                ),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 24.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor:
                                                      Color.fromARGB(
                                                          255, 51, 27, 27),
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 112, 112, 112),
                                                  ), // Border color
                                                  textStyle:
                                                      TextStyle(fontSize: 16.0),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 8.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.aBeeZee(
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  deleteProduct(index);
                                                  Navigator.of(context).pop();
                                                  getProductTypeState(
                                                      productId);
                                                  fetchCart();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 2, 92, 123),
                                                  textStyle:
                                                      TextStyle(fontSize: 16.0),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 8.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: GoogleFonts.aBeeZee(
                                                    textStyle: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                    ),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> getProductCart() async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/shoppingcart/getCartItem'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        print(responseData);

        List<Map<String, dynamic>> theRes = [];
        List<Map<String, dynamic>> allProductData = [];

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('theRes') &&
            responseData.containsKey('allProductData') &&
            responseData.containsKey('allProductDetails')) {
          cartShopContain =
              List<Map<String, dynamic>>.from(responseData['theRes']);
          productInCart =
              List<Map<String, dynamic>>.from(responseData['allProductData']);
          allProductDetails = List<Map<String, dynamic>>.from(
              responseData['allProductDetails']);
          print(productInCart);
          print(cartShopContain);
        } else {
          print('Failed to fetch cart.');
        }
      } else {
        print('Failed to fetch cart. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: ${response?.body}');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

////////////////////// delete
  Future<Map<String, dynamic>?> getProductTypeState(int productid) async {
    http.Response? response;

    try {
      response = await http.delete(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/shoppingcart/deleteCartItem?product_id=$productid'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('deleted cart item');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: ${response?.body}');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }
}
