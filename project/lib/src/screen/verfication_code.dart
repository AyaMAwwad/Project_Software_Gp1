// ignore_for_file: prefer_final_fields, unused_field, avoid_print

/*import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerificationCode(String email) async {
    // Generate a verification code (4 digits in this example)
    String verificationCode = _generateVerificationCode(4);

    // Compose the action link with the verification code
    String actionCode =
        'https://example.com/?verificationCode=$verificationCode';

    // Send the custom email
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,

        actionCodeSettings: ActionCodeSettings(
          url: actionCode,
          handleCodeInApp: true,
          //iOSBundleId: 'your_ios_bundle_id',
          androidPackageName: 'com.example.project',
          androidInstallApp: true,
          androidMinimumVersion: '16',

        ),

      );

      print('Verification code sent to $email: $verificationCode');
    } catch (e) {
      print('Error sending verification code: $e');
      // Handle error
    }
  }

  String _generateVerificationCode(int length) {
    final random = Random();
    const chars = '0123456789';
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}

*/ /*
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerificationCode(String email) async {
    // Generate a verification code (4 digits in this example)
    String verificationCode = _generateVerificationCode(4);

    // Send email with verification code
    try {
      await _auth.sendPasswordResetEmail(email: email);
      
      print('Verification code sent to $email: $verificationCode');
    } catch (e) {
      print('Error sending verification code: $e');
      // Handle error
    }
  }

  String _generateVerificationCode(int length) {
    final random = Random();
    const chars = '0123456789';
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}
*/

import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:your_email_service_provider.dart'; // Import your email service provider package

class VerificationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerificationCode(String email) async {
    // Generate a verification code (4 digits in this example)
    String verificationCode = _generateVerificationCode(4);

    // Send email with verification code
    try {
      // Use your email service provider to send a custom email
      await sendEmail(
        email: email,
        subject: 'Verfication Code',
        body: 'Your verification code is: $verificationCode',
      );

      print('Verfication code sent to $email: $verificationCode');
    } catch (e) {
      print('Error sending verfication code: $e');
      // Handle error
    }
  }

  String _generateVerificationCode(int length) {
    final random = Random();
    const chars = '0123456789';
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  Future<void> sendEmail(
      {required String email,
      required String subject,
      required String body}) async {}
}
