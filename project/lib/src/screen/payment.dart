import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:get/get.dart';
import 'package:project/src/app.dart';
import 'package:project/src/screen/home_page.dart';

import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/widgets/cart_item.dart';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';

class Payment {
  static Map<String, dynamic>? paymentIntent;
  static bool isPay = false;
  static List<int> selectedListToPay = [];
  static List<Map<String, dynamic>> productCart = [];
  //
  static Function()? onPaymentSuccess;

  static void makePayment(
      BuildContext context, double amount, int productId) async {
    print(' in makePayment ');
    print(amount);
    String merchantCountryCode = "IL";
    String currencyCode = "ILS";
    if (Providercurrency.selectedCurrency == "USD") {
      merchantCountryCode = "UD";
      currencyCode = "USD";
    } else if (Providercurrency.selectedCurrency == "DIN") {
      merchantCountryCode = "JO";
      currencyCode = "JOD";
    } else if (Providercurrency.selectedCurrency == "ILS") {
      merchantCountryCode = "IL";
      currencyCode = "ILS";
    }
    print(merchantCountryCode);
    print(currencyCode);
    try {
      paymentIntent = await createPaymentIntent(amount, context, currencyCode);
      var gPay = PaymentSheetGooglePay(
          merchantCountryCode: merchantCountryCode,
          currencyCode: currencyCode,
          testEnv: true);
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
      selectedListToPay = CartItemState.selectedListOfUserToPay;
      productCart = CartItemState.productInCart;
      /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "payment Done",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));*/
      String? gg = CartItemState.deliveryOption;
      await updateQuantityOfProduct(CartItemState.selectedListOfUserToPay);

      //showRatingDialog();
      // for (int i = 0; i < 10; i++) {

      Duration delay = Duration(minutes: 10);

      Timer(delay, () async {
        triggerNotificationFromPages('Rating Products',
            "We'd Love Your Feedback on Your Recent Purchase!");
      });

      // }
      await StoreToPay(
          Login.idd, amount, 'visa', CartItemState.selectedListOfUserToPay, gg);
      await deleteProductPaidFromShopCart(
          CartItemState.selectedListOfUserToPay);
      isPay = true;
      print('Done');
      HomePageState.InteractionOfUser(Login.idd, productId, 0, 0, 1);
      Flushbar(
        message: "Payment Done",
        duration: Duration(seconds: 3),
        // backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
      if (onPaymentSuccess != null) {
        onPaymentSuccess!();
      }
      await sendAdminNotification(amount, CartItemState.selectedListOfUserToPay,
          Login.Email); // ibtisam ****
      //

      print("huuuuu :::::::::::::::: \n \n \n $gg \n \n  ");
      print(gg);
      print("gggggg :::::::::::::::: \n \n \n $gg \n \n  ");
      if (CartItemState.deliveryOption == "Our Service" ||
          gg == "Our Service") {
        await sendNotificationToServiceEmployee(
            amount, CartItemState.selectedListOfUserToPay, Login.Email);

        print("yes service employee \n ");
      }

      //
      // CartItemState.functionPayed();
    } catch (e) {
      Flushbar(
        message: "Payment Failed",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
      print('Failed Pay');
    }
    // CartItemState cart = CartItemState();
    // cart.functionPayed();
  }

  static createPaymentIntent(
      double amount, BuildContext context, String currencyCode) async {
    try {
      print(amount);
      print(currencyCode);
      final secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
      int amountInCents = (amount * 100).toInt();
      Map<String, dynamic> body = {
        "amount": amountInCents.toString(),
        "currency": currencyCode,
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

  static Future<void> StoreToPay(int userId, double amount, String payMethod,
      List<int> productIds, String? deliveryOption) async {
    //
    print(amount);
    print(payMethod);
    print(productIds);
    print(deliveryOption);

    final response = await http.post(
      Uri.parse('http://$ip:3000/tradetryst/payment/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'userId': userId,
        'amount': amount,
        'payMethod': payMethod,
        'productIds':
            productIds.where((id) => id != 0).toList(), // productIds, //
        'deliveryOption': deliveryOption,
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
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

  // ibtisam ****
  static Future<void> sendAdminNotification(
      double amount, List<int> productIds, String userEmail) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc('kharroushehahlam@gmail.com')
          .collection('userNotifications')
          .add({
        'title': 'Payment Received',
        //'body': 'A payment of ', // products: ${productIds.join(', ')}.
        'body':
            'A payment of \$${amount.toStringAsFixed(2)} has been received from $userEmail for order  ',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Admin notification sent successfully');
    } catch (e) {
      print('Failed to send admin notification: $e');
    }
  }

  /// iiiibtisam ****
  ///
// ayaaaa   newww

  static void showRatingDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) {
      return;
    }

    List<Map<String, dynamic>> ratings = [];
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final selectedListOfUserToPay = Payment.selectedListToPay;
        final productInCart = Payment.productCart;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hi ${Login.first_name} ${Login.last_name}',
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
                      'Thank you for purchasing from Tryde Tryst! We hope you\'re enjoying it.',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 105, 105, 105),
                          fontSize: 16,
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
                    TextField(
                      controller: feedbackController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Additional Notes',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
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
                            ),
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
                            String additionalNotes = feedbackController.text;
                            submitRating(ratings);
                            Navigator.of(context).pop();
                            Future.delayed(Duration(milliseconds: 200), () {
                              Flushbar(
                                message: "Thank you for your feedback",
                                duration: Duration(seconds: 3),
                                margin: EdgeInsets.all(8),
                                borderRadius: BorderRadius.circular(8),
                              ).show(context);
                            });
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

  // enddd

  // new service

  static Future<void> sendNotificationToServiceEmployee(
      double amount, List<int> productIds, String userEmail) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(
              'ibtisamkharoush@gmail.com') // replace with the actual email or ID
          .collection('userNotifications')
          .add({
        'title': 'New Order Received',
        'body':
            'You have received a new order from $userEmail. Please process the order promptly.',

        //  'body':
        // 'A payment of \$${amount.toStringAsFixed(2)} has been received from $userEmail for order. Please process the order.',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Service employee notification sent successfully');
    } catch (e) {
      print('Failed to send service employee notification: $e');
    }
  }
}
