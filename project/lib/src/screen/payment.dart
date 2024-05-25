import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:project/src/app.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/cart_item.dart';

class Payment {
  static Map<String, dynamic>? paymentIntent;
  static bool isPay = false;
  //
  static Function()? onPaymentSuccess;

  static void makePayment(
      BuildContext context, double amount, int productId) async {
    try {
      paymentIntent = await createPaymentIntent(amount, context);
      var gPay = PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "Sabir",
        googlePay: gPay,
      ));
      displayPaymentIntent(context, amount, productId);
    } catch (e) {}
  }

  static void displayPaymentIntent(
      BuildContext context, double amount, int productId) async {
    try {
      print('***********before');
      await Stripe.instance.presentPaymentSheet();
      print('***********after');
      /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "payment Done",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));*/

      await updateQuantityOfProduct(CartItemState.selectedListOfUserToPay);
      showRatingDialog();
      await StoreToPay(Login.idd, amount, 'visa');
      await deleteProductPaidFromShopCart(
          CartItemState.selectedListOfUserToPay);
      isPay = true;
      print('Done');
      HomePageState.InteractionOfUser(Login.idd, productId, 0, 0, 1);

      if (onPaymentSuccess != null) {
        onPaymentSuccess!();
      }

      // CartItemState.functionPayed();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "payment Failed",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ));
      print('Failed Pay');
    }
    // CartItemState cart = CartItemState();
    // cart.functionPayed();
  }

  static createPaymentIntent(double amount, BuildContext context) async {
    try {
      print(amount);
      final secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
      int amountInCents = (amount * 100).toInt();
      Map<String, dynamic> body = {
        "amount": amountInCents.toString(),
        "currency": "USD",
      };
      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        print(json);
        return json;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "CHECKOUT Failed\nSelect Item to CHECKOUT",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
        print('error in calling payment intent');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  // update the quantity of product after payment ***

  static Future<void> updateQuantityOfProduct(List<int> productIds) async {
    print(productIds);
    final response = await http.put(
      Uri.parse(
          'http://$ip:3000/tradetryst/payment/updateTheQuantityToPayment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'productIds': productIds,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('quantity number updated successfully');
    } else {
      print('Failed  to update quantity ');
    }
  }

// store to pay table

  static Future<void> StoreToPay(
      int userId, double amount, String payMethod) async {
    print(amount);
    print(payMethod);
    final response = await http.post(
      Uri.parse('http://$ip:3000/tradetryst/payment/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'userId': userId,
        'amount': amount,
        'payMethod': payMethod,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('payment successfully');
    } else {
      print('Failed to pay ');
    }
  }

  // delete the product that paied from shopping cart
  static Future<Map<String, dynamic>?> deleteProductPaidFromShopCart(
      List<int> productIds) async {
    http.Response? response;

    try {
      response = await http.delete(Uri.parse(
          'http://$ip:3000/tradetryst/payment/deleteFromCartProductThatPaied?productIds=$productIds'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('deleted cart item');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body:');
    }
    return null;
  }

  ///////// new
  /// for rating done just need when prees to notification appear it
  static void showRatingDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) {
      return;
    }

    List<Map<String, dynamic>> ratings = [];
    showDialog(
      context: context,
      builder: (context) {
        final selectedListOfUserToPay = CartItemState.selectedListOfUserToPay;
        final productInCart = CartItemState.productInCart;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rate the Products',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 2, 92, 123),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please rate the products you have purchased.',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 105, 105, 105),
                          fontSize: 16,
                          //  fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ...selectedListOfUserToPay.map((itemId) {
                      final item = productInCart.firstWhere(
                          (product) => product['product_id'] == itemId,
                          orElse: () => {});

                      if (item.isEmpty) {
                        return Container();
                      }

                      final imageData = item['image'];
                      final bytes = List<int>.from(imageData['data']);
                      double rating = 3.0;
                      return Column(
                        children: [
                          Text(
                            item['name'],
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 2, 92, 123),
                                fontSize: 18,
                                //  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 120,
                              height: 70,
                              child: Image.memory(
                                Uint8List.fromList(bytes),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {
                              rating = value;
                              int existingIndex = ratings.indexWhere(
                                  (entry) => entry['product_id'] == itemId);

                              if (existingIndex != -1) {
                                ratings[existingIndex]['rating'] = value;
                              } else {
                                ratings.add(
                                    {'product_id': itemId, 'rating': value});
                              }
                            },
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    }).toList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 51, 27, 27),
                            side: BorderSide(
                              color: Color.fromARGB(255, 112, 112, 112),
                            ), // Border color
                            textStyle: TextStyle(fontSize: 16.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            submitRating(ratings);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 2, 92, 123),
                            textStyle: TextStyle(fontSize: 16.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> submitRating(List<Map<String, dynamic>> ratings) async {
    print('Ratings: $ratings');

    final response = await http.post(
      Uri.parse('http://$ip:3000/tradetryst/product/addRatingProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': Login.idd,
        'ratings': ratings,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('rating  number added successfully');
    } else {
      print('Failed to add rating number');
    }
  }
}
