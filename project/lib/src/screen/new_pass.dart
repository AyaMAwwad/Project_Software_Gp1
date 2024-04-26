// ignore_for_file: use_key_in_widget_constructors, invalid_return_type_for_catch_error

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/src/screen/forget_pass.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/pass_field.dart';

class NewPass extends StatefulWidget {
  @override
  NewPassword createState() => NewPassword();
}

class NewPassword extends State<NewPass> {
  bool valpass = false;
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  var auth = FirebaseAuth.instance;
  changePassword(email, oldPass, NewPass) async {
    var cred = EmailAuthProvider.credential(email: email, password: oldPass);
    await currentUser!
        .reauthenticateWithCredential(cred)
        .then((value) => {
              currentUser!.updatePassword(NewPass),
              print('updated successfully in firebase')
            })
        .catchError((error) => {print(error.toString())});
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  textfield1() {
    return SingleChildScrollView(
      //child: Padding(
      // key: formKey,
      // padding: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PassField(
              onPressed: () {
                setState(() {
                  valpass = !valpass;
                });
              },
              controller: passwordController1,
              obscureText: !valpass,
              icon: valpass ? Icons.visibility : Icons.visibility_off,
              hintText: 'New Password',
            ),
            SizedBox(
              height: 20,
            ),
            PassField(
              onPressed: () {
                setState(() {
                  valpass = !valpass;
                });
              },
              controller: passwordController2,
              obscureText: !valpass,
              icon: valpass ? Icons.visibility : Icons.visibility_off,
              hintText: 'Confirm Password',
            ),
            SizedBox(
              height: 20,
            ),
            CustomeButton2(
                text: 'Update',
                onPressed: () async {
                  if (formKey.currentState!.validate() &&
                      passwordController2.text == passwordController1.text) {
                    String email =
                        Login.Email != '' ? Login.Email : ForgetPass.emailUser;
                    updatePassword(email, passwordController1.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  } else if (passwordController2.text !=
                      passwordController1.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("The password not same"),
                    ));
                  }
                }),
          ],
        ),
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 430.0, // Adjust the height as needed
              child: CustemDesign(
                text: 'Update Password ',
                text2: 'Enter your new password',
                fontSize: 18,
                num2: MediaQuery.of(context).size.width * 0.2,
                num: MediaQuery.of(context).size.width * 0.16,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: textfield1(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updatePassword(String email, String newPassword) async {
    print(email);
    print(newPassword);
    final response = await http.put(
      Uri.parse('http://192.168.0.114:3000/tradetryst/user/UpdatePass'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('******************************************');
      print(email);
      print(newPassword);
      changePassword(email, 'aya123', newPassword);
      // Re-authenticate the user
      // updateFirebasePassword(email, 'aya123');

      print('Password updated successfully');
    } else {
      print('Failed to update password');
    }
  }

/*
// Update the password in Firebase Authentication
  void updateFirebasePassword(String email, String newPassword) async {
    try {
      // Sign in the user with their email and current password
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: newPassword, // Provide the user's current password here
      );

      // Get the user object from the userCredential
      User user = userCredential.user!;

      // Update the password in Firebase Authentication
      await user.updatePassword(newPassword);

      print('Password updated successfully in Firebase Authentication.');
    } catch (e) {
      print('Failed to update password in Firebase Authentication: $e');
    }
  }*/
}
