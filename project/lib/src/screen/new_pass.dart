// ignore_for_file: use_key_in_widget_constructors, invalid_return_type_for_catch_error

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/forget_pass.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/pass_field.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? buildWebNewPass() : buildMobileNewPass();
  }

  Widget buildMobileNewPass() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 410.0,
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

  Widget buildWebNewPass() {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 226, 153, 110),
                  Color.fromARGB(255, 90, 110, 199),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Container(
                  width: 500,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 7,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: AssetImage('images/icon/back.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Update Password',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF063A4E),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Enter your new password',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Color(0xFF063A4E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30.0, left: 30),
                              child: textfield1(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updatePassword(String email, String newPassword) async {
    final response = await http.put(
      Uri.parse('http://$ip:3000/tradetryst/user/UpdatePass'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      changePassword(email, 'aya123', newPassword);
      print('Password updated successfully');
    } else {
      print('Failed to update password');
    }
  }
}
