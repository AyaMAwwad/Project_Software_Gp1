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
/*
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  EmailAuth auth = new EmailAuth(sessionName: 'email');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter your email'),
            ),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            ElevatedButton(
              onPressed: () {
                _sendOTP(_emailController.text);
              },
              child: Text('Send Verification Code'),
            ),
            ElevatedButton(
              onPressed: () {
                _verifyOTP();
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendOTP(String email) async {
    var res = await auth.sendOtp(recipientMail: email);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP sent successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send OTP'),
        ),
      );
    }
  }

  void _verifyOTP() async {
    var res = auth.validateOtp(
      recipientMail: _emailController.text,
      userOtp: _otpController.text,
    );
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP verified successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP'),
        ),
      );
    }
  }
}
*/