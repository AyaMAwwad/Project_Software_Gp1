import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:project/src/screen/notification.dart';
import 'package:project/widgets/app_bar.dart';
import '../src/app.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:provider/provider.dart';

//final navigateerKey = GlobalKey<NavigatorState>();
Future firebaseBacjgroundNotification(RemoteMessage msg) async {
  if (msg.notification != null) {
    print('some notification recived in background');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //payment
  await dotenv.load(fileName: ".env");
  //Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
  //
  //await Stripe.instance.applySettings();
  // Platform.isAndroid
  if (kIsWeb) {
    print('some web app is running');
    // Initialize Firebase for web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDrL04dT9BA50QPXEvvE0ikOVhzTTmzQtY",
        // authDomain: "flutterproject-1a0ba.firebaseapp.com",
        projectId: "flutterproject-1a0ba",
        // storageBucket: "flutterproject-1a0ba.appspot.com",
        messagingSenderId: "1089510135683",
        appId: "1:1089510135683:web:85f7cbe649dcdf2ba608b6",
        //  measurementId: "G-7SK0NEKCXZ"
      ),
    );
    runApp(MyApp());
  }
  //
  //
  else {
    Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
    //
    await Stripe.instance.applySettings();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo',
          appId: '1:1089510135683:android:69d0bd6ecd28c8d1a608b6',
          messagingSenderId: '1089510135683',
          projectId: 'flutterproject-1a0ba'),
    );
    // await Firebase.initializeApp();
    // runApp(MyApp());
    runApp(
      ChangeNotifierProvider<Providercurrency>(
        create: (context) => Providercurrency(),
        child: MyApp(),
      ),
    );
  }

  /*
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo',
              appId: '1:1089510135683:android:69d0bd6ecd28c8d1a608b6',
              messagingSenderId: '1089510135683',
              projectId: 'flutterproject-1a0ba'))
      : await Firebase.initializeApp();
*/
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
    NotificationState.incrementNotification();
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
}
