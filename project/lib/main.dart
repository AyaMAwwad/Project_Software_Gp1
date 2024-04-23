import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/notification.dart';
import '../src/app.dart';

//final navigateerKey = GlobalKey<NavigatorState>();
Future firebaseBacjgroundNotification(RemoteMessage msg) async {
  if (msg.notification != null) {
    print('some notification recived in background');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo',
              appId: '1:1089510135683:android:69d0bd6ecd28c8d1a608b6',
              messagingSenderId: '1089510135683',
              projectId: 'flutterproject-1a0ba'))
      : await Firebase.initializeApp();

  /////// new
  await FirebaseNotification.initNotifications();
  await FirebaseNotification.localNotification();
  FirebaseMessaging.onBackgroundMessage(firebaseBacjgroundNotification);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
    if (msg.notification != null) {
      print(msg);
      print('background notification tapped');
      navigatorKey.currentState!.pushNamed('notification'); //, arguments: msg
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
    String payloadData = jsonEncode(msg.data);
    print('got msg in foreground');
    if (msg.notification != null) {
      FirebaseNotification.showNotification(
          msg.notification!.title!, msg.notification!.body!, payloadData);
    }
  });
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    print('lunched from terminated state');
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!
          .pushNamed('notification'); //, arguments: message
    });
  }
  //  options: DefaultFirebaseOptions.currentPlatform,
  runApp(MyApp());
}
