import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../src/app.dart';

//import 'firebase_options.dart';
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
  //  options: DefaultFirebaseOptions.currentPlatform,

  runApp(MyApp());
}
