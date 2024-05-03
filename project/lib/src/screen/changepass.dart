// ignore_for_file: use_key_in_widget_constructors, invalid_return_type_for_catch_error

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/src/screen/forget_pass.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/pass_field.dart';

class changepass extends StatefulWidget {
  @override
  changepasspage createState() => changepasspage();
}

class changepasspage extends State<changepass> {
  bool valpass = false;
  TextEditingController oldPasswordController =
      TextEditingController(); // Added TextEditingController for old password
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
            SizedBox(
              height: 40,
            ),
            PassField(
              onPressed: () {
                setState(() {
                  valpass = !valpass;
                });
              },
              controller:
                  oldPasswordController, // Changed controller to oldPasswordController
              obscureText: !valpass,
              icon: valpass ? Icons.visibility : Icons.visibility_off,
              hintText: 'Old Password', // Changed hintText to 'Old Password'
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
                    //  updatePassword(email, passwordController1.text);
                    bool uu = await checkOldPassword(
                        email, oldPasswordController.text);
                    if (uu) {
                      updatePassword(email, passwordController1.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Old password is wrong')));
                    }
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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 150, 168),
        elevation: 40,
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(width: 10),
              Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 95, 150, 168),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: kToolbarHeight),
          alignment: Alignment.bottomCenter,
          child: SizedBox(height: 20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200.0, // Adjust the height as needed
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Text(
                      'Update Password',
                      style: TextStyle(
                        color: Color.fromARGB(255, 43, 115, 122),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 99, 166, 173)
                                .withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Add spacing between texts
                    Text(
                      'Enter your new password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    //    Divider(
                    // color: Colors.grey, // Add a simple line separator
                    //   ),
                  ],
                ),
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
      Uri.parse('http://192.168.1.126:3000/tradetryst/user/UpdatePass'),
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
      changePassword(email, oldPasswordController.text,
          newPassword); // Pass old password to changePassword
      // Re-authenticate the user
      // updateFirebasePassword(email, 'aya123');

      print('Password updated successfully');
    } else {
      print('Failed to update password');
    }
  }

  // check old pass
  Future<bool> checkOldPassword(String email, String oldPassword) async {
    print("hi $email \n \n");
    print(" hi $oldPassword \n \n");
    // Make an HTTP request to your backend API to verify the old password
    final response = await http.post(
      Uri.parse('http://192.168.1.126:3000/tradetryst/old/oldpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'oldPassword': oldPassword,
      }),
    );

    // Check if the response indicates that the old password is correct
    if (response.statusCode == 200) {
      print(" it is true pass old with stored ");
      // If the response is successful (status code 200), return true
      return true;
    } else {
      print(" it is not true pass old with stored");

      return false;
    }
    // catch (e) {

    // print('Error checking old password: $e');

    // return false;
  }

  //
}
