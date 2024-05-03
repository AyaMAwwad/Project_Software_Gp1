// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/chat/notification_service.dart';

Future<void> sendNotification(
    String fcmToken, String title, String body) async {
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
    print('Notification sent successfully to FCM token: $fcmToken');
  } else {
    print('Failed to send notification to FCM token: $fcmToken');
    // print('HTTP response code: ${response.statusCode}');
    // print('HTTP response body: ${response.body}');
  }
}

Future<void> triggerNotification() async {
  final List<String> fcmTokens = await CRUDService.getFCMTokensFromDatabase();
  print(fcmTokens);

  for (final token in fcmTokens) {
    await sendNotification(
        token, 'New Fashion Collection', 'Check out our latest fashion items!');
  }
}
