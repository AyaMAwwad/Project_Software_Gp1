// ignore_for_file: prefer_const_declarations

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/chat/notification_service.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';

String title = '';
List<Map<String, dynamic>> productFromNotificaiom = [];
List<Map<String, dynamic>> productDetailFromNotificaiom = [];
String typeOfProductForRating = '';
int idOfProductForRating = 0;
String nameOfProductForRating = '';
dynamic imageOfProductForRating = '';
///////////////////

int idx = 0;
void scheduleNotifications() async {
  final List<String> fcmTokens = await CRUDService.getFCMTokensFromDatabase();
  List<Map<String, dynamic>> itemsToNotify = [];
  int userId = Login.idd;
  /*var response = await http.get(Uri.parse(
      'http://$ip:3000/tradetryst/Product/checkQuantityForNotification?userId=$userId'));
  if (response.statusCode == 200 || response.statusCode == 201) {
    dynamic responseData = jsonDecode(response.body);
    List<Map<String, dynamic>> names =
        List<Map<String, dynamic>>.from(responseData['results']);
    List<Map<String, dynamic>> details =
        List<Map<String, dynamic>>.from(responseData['allProductDetails']);

    names = names.where((item) => item['user_id'] != userId).toList();

    itemsToNotify.addAll(names.map((item) => {
          'title': '[Private Reminder]',
          'name': item['name'],
          'body':
              'An item ${item['name']} in your cart is nearly out of stock. Shop it before it sells out.'
        }));
    productFromNotificaiom.addAll(names);
    productDetailFromNotificaiom.addAll(details);
  }*/

  var response = await http.get(Uri.parse(
      'http://$ip:3000/tradetryst/Product/ProductNewCollectionForNotification?userId=$userId'));
  if (response.statusCode == 200 || response.statusCode == 201) {
    dynamic responseData = jsonDecode(response.body);
    List<Map<String, dynamic>> names =
        List<Map<String, dynamic>>.from(responseData['allProducts']);
    List<Map<String, dynamic>> details =
        List<Map<String, dynamic>>.from(responseData['allProductDetails']);

    names = names.where((item) => item['user_id'] != userId).toList();

    itemsToNotify.addAll(names.map((item) => {
          'title': 'New Collection',
          'name': item['name'],
          'body':
              'New Collection of ${item['name']} available now. Check it out before it sells out.'
        }));
    productFromNotificaiom.addAll(names);
    productDetailFromNotificaiom.addAll(details);
  }
  print('^^^^^^^^^^^^ productFromNotificaiom $productFromNotificaiom');
  print('^^^^^^^^^^^^itemsToNotify $itemsToNotify');
  for (int i = 0; i < itemsToNotify.length; i++) {
    for (final token in fcmTokens) {
      String title = itemsToNotify[i]['title'];
      String body = itemsToNotify[i]['body'];

      Duration delay = Duration(minutes: 5 + i);
      idx = i;
      Timer(delay, () async {
        await sendNotification(token, title, body);
      });
    }
  }
}

Future<void> triggerNotificationFromPages(String title, String body) async {
  print('********* IN  triggerNotification  ');
  final List<String> fcmTokens = await CRUDService.getFCMTokensFromDatabase();
  print(fcmTokens);

  for (final token in fcmTokens) {
    await sendNotification(token, title, body);
  }
}

Future<void> sendNotification(
  String fcmToken,
  String title,
  String body,
  // {Duration delay = Duration.zero}
) async {
  //await Future.delayed(delay);
  final String serverKey =
      'AAAA_avdV4M:APA91bEofdVdaTCvN-6SZ4PjL_sChISv2ysKpdqMhHKewvLXTJRw852X5mM38sAoBEQf5tkDFXaGljqznhGyT0Bzaz6_7aEqxoCIeSrb5-PzQ-Wt8XwZMood-N6LZmnigXbLeZOisZ7a'; // Replace 'YOUR_SERVER_KEY' with your actual Firebase server key

  final Uri fcmUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> data = {
    'notification': {
      'title': title,
      'body': body,
    },
    'to': fcmToken,
  };
  // print(data);

  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(user.email!)
          .collection('userNotifications')
          .add({
        'uid': user.uid,
        'title': title,
        'body': body,
        'token': fcmToken,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Notification data saved in Firestore');
    } else {
      print('User is not logged in');
    }
  } catch (e) {
    print('Failed to save notification data: $e');
  }

  final http.Response response = await http.post(
    fcmUrl,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    //NotificationState.incrementNotification();
    print('Notification sent successfully to FCM token: $fcmToken');
  } else {
    print('Failed to send notification to FCM token: $fcmToken');
    // print('HTTP response code: ${response.statusCode}');
    // print('HTTP response body: ${response.body}');
  }
}

Future<void> triggerNotification() async {
  print('********* IN  triggerNotification  ');
  await checkQuantityForNotification(Login.idd);
  await ProductNewCollectionForNotification(Login.idd);
}

/*
Future<void> triggerNotification(String title, String body) async {
  print('********* IN  triggerNotification  ');
  final List<String> fcmTokens = await CRUDService.getFCMTokensFromDatabase();
  print(fcmTokens);

  for (final token in fcmTokens) {
    await sendNotification(token, title, body);
  }
}*/
Future<void> refreshWshList() async {
  //// using it if make wish list
  print('********* IN  refreshWshList');
  final List<String> fcmTokens = await CRUDService.getFCMTokensFromDatabase();
  print(fcmTokens);

  for (final token in fcmTokens) {
    await sendNotification(
        token, 'Trade Tryst', 'Refresh your wishlist with newly added product');
  }
}

Future<void> checkQuantityForNotification(int userId) async {
  http.Response? response;
  print('********* IN  checkQuantityForNotification  $userId');

  try {
    response = await http.get(Uri.parse(
        'http://$ip:3000/tradetryst/Product/checkQuantityForNotification?userId=$userId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic responseData = jsonDecode(response.body);
      print(responseData);
      final List<String> fcmTokens =
          await CRUDService.getFCMTokensFromDatabase();
      print(fcmTokens);
      List<Map<String, dynamic>> names =
          List<Map<String, dynamic>>.from(responseData['results']);

      for (final name in names) {
        for (final token in fcmTokens) {
          String title = '[Private Reminder]';
          String body =
              'An item ${name['name']} in your cart is nearly out of stock. Shop it before it sells out>>>';
          await sendNotification(token, title, body);
        }
      }
/*
      List<Map<String, dynamic>> name =
          List<Map<String, dynamic>>.from(responseData['results']);

      for (final token in fcmTokens) {
        title = '[Private Reminder]';
        await sendNotification(token, '[Private Reminder]',
            'An item ${name[0]['name']} in your cart is nearly Out of Stock. Shop ite before it selles out>>>');
      }*/
    } else {
      print('Failed to . Status code: ${response.statusCode}');
    }
  } catch (e) {
    print(' Response body: ');
  }
  return null;
}

Future<void> ProductNewCollectionForNotification(int userId) async {
  http.Response? response;
  print('********* IN  ProductNewCollectionForNotification  $userId');

  try {
    response = await http.get(Uri.parse(
        'http://$ip:3000/tradetryst/Product/ProductNewCollectionForNotification?userId=$userId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic responseData = jsonDecode(response.body);
      print(responseData);
      final List<String> fcmTokens =
          await CRUDService.getFCMTokensFromDatabase();
      print(fcmTokens);
      List<Map<String, dynamic>> names =
          List<Map<String, dynamic>>.from(responseData['allProducts']);

      for (final name in names) {
        for (final token in fcmTokens) {
          String title = 'New Collection';
          String body =
              'New Cllection of ${name['name']}  maybe intersted it show it before become sold out';
          await sendNotification(token, title, body);
        }
      }
    } else {
      print('Failed  . Status code: ${response.statusCode}');
    }
  } catch (e) {
    print(' Response body: ');
  }
  return null;
}
