// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_cast, use_key_in_widget_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project/src/screen/ipaddress.dart';
//import 'package:flutter/material.dart' as material;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/payment.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/delivery_page.dart';
import 'package:project/widgets/demo_counter.dart';
import 'package:get/get.dart';
import 'package:project/widgets/search_page.dart';

class CartItem extends StatefulWidget {
  @override
  State<CartItem> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  void _showDeliveryModal(
      BuildContext context, String deliveryOption, int productId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DeliveryPage(
          isFree: false,
          deliveryOption: deliveryOption,
          productId: productId,
          onPaymentSuccess: refreshCart,
        );
      },
    );
  }

  ////////
  static String selectedCurr = Providercurrency.selectedCurrency;
  String prevselectedCurr = 'ILS';
  static String getsymbol() {
    String sympol = '';
    switch (selectedCurr) {
      case 'USD':
        sympol = '\$';
        break;
      case 'DIN':
        sympol = 'JOD';
        break;
      case 'ILS':
        sympol = '₪';
        break;

      default:
        sympol = '';

      //return
    }
    return '$sympol';
  }

  static String? deliveryOption;
  static int? productId;
  List<Map<String, dynamic>> cartShopContain = [];
  static List<Map<String, dynamic>> productInCart = [];
  List<Map<String, dynamic>> allProductDetails = [];
  static List<int> productCount = [];
  static List<bool> selectedCheckboxes = [];
  static bool allCheckboxChecked = false;
  static List<int> selectedListOfUserToPay = [];

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    if (productInCart != null &&
        selectedCheckboxes != null &&
        productCount != null) {
      for (int i = 0; i < productInCart.length; i++) {
        if (i < selectedCheckboxes.length &&
            i < productCount.length &&
            selectedCheckboxes[i]) {
          if (i < allProductDetails.length && productCount[i] != null) {
            Map<String, dynamic> details = allProductDetails[i];
            double price = double.tryParse(details['price'] ?? '0.0') ?? 0.0;

            int count = productCount[i] ?? 0;
            totalPrice += price * count;
          }
        }
      }
    }
    return totalPrice;
  }

  void deleteProduct(int index) {
    setState(() {
      if (index < productInCart.length) productInCart.removeAt(index);
      if (index < allProductDetails.length) allProductDetails.removeAt(index);
      if (index < cartShopContain.length) cartShopContain.removeAt(index);
      if (index < selectedListOfUserToPay.length)
        selectedListOfUserToPay.removeAt(index);
      if (index < selectedCheckboxes.length) selectedCheckboxes.removeAt(index);

      /*  productInCart.removeAt(index);
      allProductDetails.removeAt(index);
      cartShopContain.removeAt(index);
      selectedListOfUserToPay.removeAt(index);
      selectedCheckboxes.removeAt(index);
  */
    });
  }

  void deleteProductAll(int start, int end) {
    setState(() {
      productInCart = List.from(productInCart);
      cartShopContain = List.from(cartShopContain);
      allProductDetails = List.from(allProductDetails);
      selectedListOfUserToPay = List.from(selectedListOfUserToPay);
      selectedCheckboxes = List.from(selectedCheckboxes);
      productInCart.removeRange(start, end);
      allProductDetails.removeRange(start, end);
      cartShopContain.removeRange(start, end);
      selectedListOfUserToPay.removeRange(start, end);
      selectedCheckboxes.removeRange(start, end);
    });
  }

  @override
  void initState() {
    super.initState();

    fetchCart();
  }

  void refreshCart() {
    fetchCart();
  }

  static double? amount;
  void fetchCart() async {
    getsymbol();
    await getProductCart(Login.idd);

    setState(() {
      if (selectedCheckboxes.isEmpty) {
        allCheckboxChecked = false;
      }
      if (allCheckboxChecked && Payment.isPay) {
        //for (int i = 0; i < selectedCheckboxes.length; i++) {
        // deleteProduct(i);
        // }
        Payment.isPay = false;
        allCheckboxChecked = false;
        deleteProductAll(0, selectedCheckboxes.length);
      }
      if (selectedCheckboxes.isEmpty ||
          selectedCheckboxes.length != productInCart.length) {
        selectedCheckboxes =
            List.generate(productInCart.length, (index) => false);
      }

      if (productCount == null ||
          productCount.isEmpty ||
          productCount.length != productInCart.length) {
        productCount = List.filled(productInCart.length, 1);
      }

      selectedCheckboxes = List.from(selectedCheckboxes, growable: true);

      while (selectedCheckboxes.length < productInCart.length) {
        selectedCheckboxes.add(false);
      }

      for (int i = 0; i < selectedCheckboxes.length; i++) {
        if (i >= productCount.length || selectedCheckboxes[i] == null) {
          selectedCheckboxes[i] = false;
        }
      }
      //// new 8_MAY
      if (selectedListOfUserToPay.isEmpty ||
          selectedListOfUserToPay.length != productInCart.length) {
        selectedListOfUserToPay =
            List.generate(productInCart.length, (index) => 0);
      }
      selectedListOfUserToPay =
          List.from(selectedListOfUserToPay, growable: true);

      while (selectedListOfUserToPay.length < selectedCheckboxes.length) {
        selectedListOfUserToPay.add(0);
      }

      for (int i = 0; i < selectedCheckboxes.length; i++) {
        if (i >= selectedListOfUserToPay.length ||
            selectedListOfUserToPay[i] == null) {
          selectedListOfUserToPay[i] = 0;
        }
      }

      // }
    });
  }

/*
  void fetchCart() async {
    await getProductCart(Login.idd);
//selectedListOfUserToPay
    setState(() {
      if (selectedCheckboxes.isEmpty ||
          selectedCheckboxes.length != productInCart.length) {
        selectedCheckboxes =
            List.generate(productInCart.length, (index) => false);
      }

      if (productCount == null ||
          productCount.isEmpty ||
          productCount.length != productInCart.length) {
        productCount = List.filled(productInCart.length, 1);
      }

      // Ensure that selectedCheckboxes has the same length as productInCart
      selectedCheckboxes.length = productInCart.length;

      // Update selectedCheckboxes based on the current length of the list
      for (int i = 0; i < selectedCheckboxes.length; i++) {
        if (i >= productCount.length || selectedCheckboxes[i] == null) {
          selectedCheckboxes[i] = false; // Set new items to false by default
        }
      }

      //// new 8_MAY
      /* if (selectedListOfUserToPay.isEmpty) {
        selectedListOfUserToPay.length = selectedCheckboxes.length;
        for (int i = 0; i < selectedCheckboxes.length; i++) {
          if (i >= selectedListOfUserToPay.length ||
              selectedCheckboxes[i] == null) {
            selectedListOfUserToPay[i] = 0;
          }
        }
      }*/
      ////
    });
  }*/

/*
void fetchCart() async {
  await getProductCart();

  setState(() {
    if (selectedCheckboxes.isEmpty) {
      selectedCheckboxes = List.generate(productInCart.length, (index) => false);
    }


    if (productCount == null) {
      productCount = List.filled(productInCart.length, 1);
    } else if (productCount.isEmpty) {
      productCount = List.generate(productInCart.length, (index) => 1);
    } else if (productInCart != null) { // Add null check here
      productCount = List.filled(productInCart.length, 1);
       // Set a default value if productInCart is null
      
    }
  });
}
*/
/////////////////////////////////////////////////////////////////
  ///
  /*
  Future<void> initPaymentSheet() async {
    try {
// 1. create payment intent on the server
      final data = await createPaymentIntent(
          name: 'aya', currency: 'USD', amount: '1000');
// 2. initialize the payment sheet
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
// Set to true for custom flow
          customFlow: false,
// Main params
          merchantDisplayName: 'Test payment',
          paymentIntentClientSecret: data['paymentIntent'],
// Customer keys
          customerEphemeralKeySecret: data[' ephemeralKey'],
          customerId: data['id'],
          /*   applePay: const PaymentSheetApplePay (
merchantCountryCode: 'US',

),
googlePay: const PaymentSheetGoogLePay (
merchantCountryCode: 'US', testEnv: true,

),*/
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }
*/
/////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    amount = calculateTotalPrice();
    print('**********allProductDetails: $allProductDetails ');
    print('***************productInCart: $productInCart');
    print('***************selectedListOfUserToPay: $selectedListOfUserToPay');
    print('************* calculateTotalPrice() ${calculateTotalPrice()}');
    print('************* prevselectedCurr ${prevselectedCurr}');
    String currpriceAll =
        SearchPage.priceprosearch(calculateTotalPrice(), prevselectedCurr);
    String Totalprice = SearchPage.getsymbol(currpriceAll);
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
                            print(
                                '********* setState prevselectedCurr: $prevselectedCurr');
                            currpriceAll = SearchPage.priceprosearch(
                                calculateTotalPrice(), prevselectedCurr);
                            if (selectedCurr != prevselectedCurr) {
                              prevselectedCurr = selectedCurr;
                            }
                            Totalprice = SearchPage.getsymbol(currpriceAll);
                            allCheckboxChecked = value ?? false;
                            // Update the state of all individual checkboxes
                            selectedCheckboxes = List.filled(
                                selectedCheckboxes.length, allCheckboxChecked);
                            for (int i = 0;
                                i < selectedCheckboxes.length;
                                i++) {
                              selectedListOfUserToPay[i] = allCheckboxChecked
                                  ? productInCart[i]['product_id']
                                  : 0;
                            }
                            // selectedListOfUserToPay = List.filled(
                            //  selectedListOfUserToPay.length,
                            //  allCheckboxChecked ? productInCart[i][] : 0);
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
                      "120".tr,
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
                  //calculateTotalPrice().toStringAsFixed(2) SearchPage.getsymbol(currpriceAll) //
                  '${Totalprice.split(":")[1]}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 60, 99),
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 241, 235, 245)
                            .withOpacity(0.9), //Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                CustomeButton2(
                  text: "150".tr,
                  onPressed: () async {
                    /* DeliveryPageState.onPressedSuccess = () {
                      refreshCart();
                    };*/
                    Payment.onPaymentSuccess = () {
                      refreshCart();
                    };
                    //  try {
                    _showDeliveryModal(context, deliveryOption!, productId!);
                    /* Payment.onPaymentSuccess = () {
                        refreshCart();
                      };
                      //  Payment.onPaymentSuccess = refreshCart;
                      Payment.makePayment(context, calculateTotalPrice());

                      print('Payment sheet initialized successfully.');
                    } catch (e) {
                      print('Error initializing payment sheet: $e');
                    }*/
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productInCart.length,
              itemBuilder: (context, index) {
                if (index >= productInCart.length ||
                    index >= allProductDetails.length) {
                  return Container();
                }

                final theproduct = productInCart[index];
                final details = allProductDetails[index];
                final imageData = theproduct['image'];
                final bytes = List<int>.from(imageData['data']);
                final productName = theproduct['name'];
                // final priceOfProd1 = details['price'];
                final quantity1 = theproduct['quantity'];

                ///
                String theState = theproduct['product_type'];
                productId = theproduct['product_id'];
                deliveryOption = theproduct['Delivery_option'];
                String curr = theproduct['currency'];
                String currprice =
                    SearchPage.priceprosearch(details['price'], curr);

                /* if (selectedCheckboxes[index]) {
                  selectedListOfUserToPay[index] = productId;
                } */
                // int thequantity = product['quantity'];
                String thepriceOfProd = (theState == 'new' ||
                        theState == 'used' ||
                        theState == 'New' ||
                        theState == 'Used' ||
                        theState == 'مستعمل' ||
                        theState == 'جديد')
                    ? SearchPage.getsymbol(currprice)
                    : 'Free';
                String qunt = "101".tr;
                String pr = "110".tr;
                String stock = "123".tr;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  color: Color.fromARGB(255, 241, 235, 245).withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor:
                                index < selectedCheckboxes.length &&
                                        selectedCheckboxes[index]
                                    ? Color.fromARGB(255, 13, 60, 99)
                                    : Colors.transparent,
                            child: Checkbox(
                              value: //selectedCheckboxes[index],
                                  // index < selectedCheckboxes.length && selectedCheckboxes[index],
                                  index < selectedCheckboxes.length
                                      ? selectedCheckboxes[index]
                                      : false,
                              onChanged: (value) {
                                setState(() {
                                  selectedCheckboxes[index] = value ?? false;
                                  if (selectedCheckboxes[index] == false) {
                                    selectedListOfUserToPay[index] = 0;
                                  } else {
                                    selectedListOfUserToPay[index] =
                                        productInCart[index]
                                            ['product_id']; // productId!;
                                  }
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
                            '$thepriceOfProd',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '$qunt: $quantity1',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      trailing: CountItem(
                        // count: productCount[index],
                        count: (productCount.isNotEmpty &&
                                index < productCount.length)
                            ? productCount[index]
                            : 0,

                        increment: () {
                          setState(() {
                            if (productCount[index] < quantity1) {
                              repos.incrementCounter(context, index);
                              productCount[index] =
                                  repos.getCount(context, index);
                              updateItemOnShopCart(
                                  repos.getCount(context, index), productId!);
                              /////
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 241, 235, 245),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.orange,
                                          size: 24,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "122".tr,
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
                                      '$stock $productName: $quantity1',
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
                                        text: "124".tr,
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
                              ////
                              updateItemOnShopCart(
                                  repos.getCount(context, index), productId!);
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
                                              "125".tr,
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
                                              "126".tr,
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
                                                  "127".tr,
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
                                                      productId!);
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
                                                  "128".tr,
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

  Future<Map<String, dynamic>?> getProductCart(int userId) async {
    http.Response? response;
    print('********* IN SHOP GET PROD CART $userId');
    print(
        "********************selectedListOfUserToPay : $selectedListOfUserToPay");

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/shoppingcart/getCartItem?userId=$userId'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);

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
        } else {
          print('Failed to fetch cart.');
        }
      } else {
        print('Failed to fetch cart. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: '); //${response?.body}
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

////////////////////// delete
  Future<Map<String, dynamic>?> getProductTypeState(int productid) async {
    http.Response? response;

    try {
      response = await http.delete(Uri.parse(
          'http://$ip:3000/tradetryst/shoppingcart/deleteCartItem?product_id=$productid'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('deleted cart item');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body:');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

  Future<void> updateItemOnShopCart(int item, int productId) async {
    print(item);
    print(productId);
    final response = await http.put(
      Uri.parse('http://$ip:3000/tradetryst/shoppingcart/updateItemOnShopCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'item': item,
        'productId': productId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('item number updated successfully');
    } else {
      print('Failed to update item number ');
    }
  }
}

/*
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      "120".tr,
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
                  text: "121".tr,
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
                String qunt = "101".tr;
                String pr = "110".tr;
                String stock = "123".tr;

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
                            '$pr: $thepriceOfProd',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '$qunt: $quantity1',
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
                                          "122".tr,
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
                                      '$stock $productName: $quantity1',
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
                                        text: "124".tr,
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
                                              "125".tr,
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
                                              "126".tr,
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
                                                  "127".tr,
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
                                                  "128".tr,
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
*/