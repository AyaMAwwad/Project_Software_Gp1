import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
/*
Future createPaymentIntent({
  required String name,
  // required String address,
  // required String pin,
  // required String city,
  // required String state,
  // required String country,
  required String currency,
  required String amount,
}) async {
  final url = Uri.parse("https://api.stripe.com/v1/payment_intents");
  final secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
  final body = {
    'amount': amount,
    'currency': currency.toLowerCase(),
    'automatic_payment_methods[enabled]': 'true',
    'description': 'Test Payment of cart',
    /* 'shipping[name]': name,
    'shipping[address][line1]': address,
    'shipping[address][postal_code]': pin,
    'shipping[address][city]': city,
    'shipping[address][state]': state,
    'shipping[address][country]': country,*/
  };
  final response = await http.post(url,
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var json = jsonDecode(response.body);
    print(json);
    return json;
  } else {
    print('error in calling payment intent');
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/cart_item.dart';

class Payment {
  static Map<String, dynamic>? paymentIntent;
  static bool isPay = false;
  //
  static Function()? onPaymentSuccess;

  static void makePayment(BuildContext context, double amount) async {
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
      displayPaymentIntent(context, amount);
    } catch (e) {}
  }

  static void displayPaymentIntent(BuildContext context, double amount) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "payment Done",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));

      await updateQuantityOfProduct(CartItemState.selectedListOfUserToPay);

      await StoreToPay(Login.idd, amount, 'visa');
      await deleteProductPaidFromShopCart(
          CartItemState.selectedListOfUserToPay);
      //isPay = true;
      print('Done');
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
          'http://192.168.0.114:3000/tradetryst/payment/updateTheQuantityToPayment'),
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
      Uri.parse('http://192.168.0.114:3000/tradetryst/payment/add'),
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
          'http://192.168.0.114:3000/tradetryst/payment/deleteFromCartProductThatPaied?productIds=$productIds'));
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
}
