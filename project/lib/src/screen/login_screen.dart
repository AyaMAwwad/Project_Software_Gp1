//import 'dart:html';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print, non_constant_identifier_names

//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
//import 'dart:html';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print, non_constant_identifier_names

//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/mixins/valid_mixin.dart';
import 'dart:core';
import 'package:project/src/screen/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/src/screen/forget_pass.dart';
import 'package:project/src/screen/signup_screen.dart';
import 'package:project/src/screen/verify_email.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/form_field.dart';
import 'package:project/widgets/have_account.dart';
import 'package:project/widgets/pass_field.dart';

//import 'package:awesome_dialog/awesome_dialog.dart';
class Login extends StatefulWidget {
  static String Email = '';
  static String FirstName = '';
  static String LastName = '';
  static String first_name = '';
  static String last_name = '';
  static String address = '';
  static String phonenumberr = '';
  static int idd = 0;
  static String birthdaylogin = '';
  // @override
  //LoginScreen Login.createState({super.key}) => LoginScreen();

  @override
  LoginScreen createState() => LoginScreen();
}

class LoginScreen extends State<Login> with ValidationMixin {
  // get kHintTextStyle => null;
  bool valpass = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isemailvalid = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  textfield1() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0,
          ),
          Image.asset(
            'images/icon/logo3.png',
            width: 900.0,
            height: 200.0,
          ),

          SizedBox(
            height: 10.0,
          ),
          custemField(
            hintText: 'UserName',
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (validatemail(value)) {
                return null;
              } else {
                return 'Please enter your valid email';
              }
            },
            icon: Icons.email,
          ),

          SizedBox(
            height: 25.0,
          ),
          textField2(),
          SizedBox(
            height: 15,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: Text(
                  'Forget Your password?',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 2, 92, 123),
                      fontSize: 14,

                      // decoration: TextDecoration.underline,
                      decorationThickness: 1,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
////
            ],
          ),

          SizedBox(
            height: 25,
          ),

          CustomeButton(
            text: 'Login',
            onPressed: () async {
              // Add the action the button should perform
              onFormSubmitted();
              String ii = emailController.text;
              Login.Email = emailController.text;
              String jj = passwordController.text;
              print("hi $ii\n");
              print("hi $jj\n");
              await getTheName(Login.Email);
              await loginnn(ii, jj);

              //ayaaaaa

              /* if (credential.user!.emailVerified) {
                  Navigator.of(context).pushReplacementNamed("login");
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Email Not Verified"),
                        content: Text("Please verify your email to proceed."),
                        actions: <Widget>[
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }*/

//

              //
            },
            borderRadius: BorderRadius.circular(30.0),
          ),
          // passwordfield(),
          //loginButton(),
          SizedBox(
            height: 25.0,
          ),
          HaveAccount(
            name1: "Don't Have An Account? ",
            press: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
            name2: 'Sign up',
          ),
          // SizedBox(height: 25.0,),
          SizedBox(height: 25.0), // Add this line for spacing

          OrText(),
//SizedBox(height: 15.0),
          //

          SizedBox(height: 15.0), // Add this line for spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Facebook Icon
              Icon(
                FontAwesomeIcons.facebook,
                color: Color.fromARGB(255, 9, 93, 123),
                size: 30,
              ),
              // Twitter Icon
              //  SizedBox(width: 10.0), //
              Icon(
                FontAwesomeIcons.twitter,
                //FontAwesomeIcons.twitter,
                color: Color.fromARGB(255, 9, 93, 123),
                size: 30,
              ),
              Icon(
                FontAwesomeIcons.google,
                //FontAwesomeIcons.twitter,
                color: Color.fromARGB(255, 9, 93, 123),
                size: 30,
              ),
              // Google Icon
              // SizedBox(width: 2.0), //
            ],
          ),

          ///
        ],
      ),
    );
  }

// textfield2

  Widget textField2() {
    // bool valpass = true;

    return PassField(
      onPressed: () {
        setState(() {
          valpass = !valpass;
        });
      },
      controller: passwordController,
      obscureText: !valpass,
      icon: valpass ? Icons.visibility : Icons.visibility_off,
      hintText: 'Password',
    );
  }

// function to make text "OR "
  OrText() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: Colors.grey[300], // Use a light color for the divider
          thickness: 1.0, // Adjust the thickness of the divider
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10.0), // Adjust padding as needed
          color: Colors
              .white, // Set the background color to match the background behind the line
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

// password controller
  bool iscoorectpass() {
    if (passwordController.text.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * -0.02,
            left: 0,
            right: MediaQuery.of(context).size.width * -0.05, //-20,
            child: Image.asset(
              'images/icon/designB.png', // Path to your image asset
              //'images/icon/svg.png',
              // Adjust height as needed
              fit: BoxFit.cover, // Adjust BoxFit as needed
            ),
          ),
          // This widget holds the content of your app
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(55.0),
              child:
                  textfield1(), /*FirebaseAuth.instance.currentUser == null
                  ? textfield1()
                  : FirebaseAuth.instance.currentUser!.emailVerified
                      ? textfield1()
                      : Container(),*/

              //VerifyEmail(),
              /*ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0D6775),
                            minimumSize: Size(90, 40),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                          onPressed: () {
                            if (FirebaseAuth.instance.currentUser != null) {
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                            } else {
                              // Handle the case where there's no authenticated user
                              print('No authenticated user found.');
                            }
                          },
                          child: Text(
                            'Verify Your Email',
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),*/
            ),
          ),
          // This widget holds the image and is positioned at the top of the stack
        ],
      ),
    );
  }

  ///
  ///
  onFormSubmitted() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isemailvalid = validatemail(emailController.text);
      });
      if (isemailvalid && iscoorectpass()) {
        // Both email and password are valid, navigate to HomePage
      } else {
        // Either email or password is invalid, handle accordingly
        print('Invalid email or password');
      }
      // Perform the login action or any other actions
      // print('Form is valid. Logging in...');
    }
    //return isemailvalid;
  }

//// new
  Future<void> loginnn(String email, String password) async {
    final url = Uri.parse('http://192.168.0.114:3000/tradetryst/user/login');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        /////////ibtisam
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('user')) {
          final user = responseData['user'];
          if (user.containsKey('first_name')) {
            Login.first_name = user['first_name'];
            Login.last_name = user['last_name'];
            Login.address = user['address'];
            Login.phonenumberr = user['phone_number'];
            Login.idd = user['user_id'];
            Login.birthdaylogin = user['birthday'];
            print('First Name: ${Login.first_name}');
            print('id user: ${Login.idd}');
            print('id user: ${Login.birthdaylogin}');
          }
        }
        setState(() {});

        /////////// ayosh
        try {
          UserCredential credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          SignupScreen.firestore
              .collection('Theusers')
              .doc(credential.user!.uid)
              .set({
            'uid': credential.user!.uid,
            'email': emailController.text,
            'first_name': Login.FirstName,
            'last_name': Login.LastName,
          }, SetOptions(merge: true));
        }

        //aya
        on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
        Navigator.of(context).pushReplacementNamed("homepagee");
        // Authentication successful
        print('Login successful');
        // Navigate to the home page or perform any other actions
      } else if (response.statusCode == 401) {
        // Invalid email or password
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid email or password"),
        ));
        //
        print('Invalid email or password');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to authenticate."),
        ));
        //
        // Other error occurred
        print('Failed to authenticate. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>?> getTheName(String email) async {
    http.Response? response;

    // print(email);
    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/user/userName?email=$email'));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          // Extract price from the first item in the list

          dynamic user = responseData[0];
          // print(responseData[0]);

          Login.FirstName = user['first_name'];
          Login.LastName = user['last_name'];

          print(Login.FirstName);
          print(Login.LastName);

          //  dynamic userId = responseData[2];

          //print(FirstName + LastName + userId);
        } else {
          throw Exception('Empty or invalid response ');
        }
      } else {
        throw Exception('Failed . Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e, Response body: ${response?.body}');
      throw Exception('Failed  : $e');
    }
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    } else {
      return null;
    }
  }
/*
loginnn(email , password) async {
  var url ="http://127.0.0.1:3000";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email ,'password': password,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.statusCode);
    print(response.body);
   // return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

// in terminal command  pc 
curl -X POST -H "Content-Type: application/json" -d "{\"email\":\"ibtisam@gmail.com\", \"password\":\"password123\"}" http://localhost:3000/login
//terminal vs
cd  C:\projects\ProjectSoft\ProjectSoft\ProjectSoft\project\lib\src\serivenode
node service.js
*/
} // login screen end
