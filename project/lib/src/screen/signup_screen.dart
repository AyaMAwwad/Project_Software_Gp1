// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:project/src/screen/ipaddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/mixins/valid_mixin.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/verify_email.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/date_field.dart';
import 'package:project/widgets/form_field.dart';
import 'package:project/widgets/have_account.dart';
import 'package:project/widgets/pass_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Signup extends StatefulWidget {
  static String EmailSignup = '';
  @override
  SignupScreen createState() => SignupScreen();
}

class SignupScreen extends State<Signup> with ValidationMixin {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedGender;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneA = TextEditingController();
  TextEditingController gender = TextEditingController();
  String phone = '';
  DateTime? selectedDate;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool valpass = false;

  textfield1() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            custemField(
              hintText: 'First Name',
              controller: firstName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name';
                }
                return null;
              },
              icon: Icons.person,
            ),
            SizedBox(height: 25.0),
            custemField(
              hintText: 'Last Name',
              controller: lastName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name';
                }
                return null;
              },
              icon: Icons.person,
            ),
            SizedBox(height: 25.0),
            custemField(
              hintText: 'Email',
              controller: email,
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
            SizedBox(height: 25.0),
            phoneField(3),
            SizedBox(height: 25.0),
            custemField(
              hintText: 'Address',
              controller: address,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Address';
                }
                return null;
              },
              icon: Icons.location_on,
            ),
            SizedBox(height: 25.0),
            DateField(
              controller: gender,
              onTap: () {
                _selectDate(context);
              },
              selectedDate: selectedDate,
            ),
            SizedBox(height: 25.0),
            textField2(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  activeColor: Color.fromARGB(255, 2, 92, 123),
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value.toString();
                    });
                  },
                ),
                Text(
                  'Male',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fontSize: 15,
                  ),
                ),
                Radio(
                  activeColor: Color.fromARGB(255, 2, 92, 123),
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value.toString();
                    });
                  },
                ),
                Text(
                  'Female',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            CustomeButton(
              text: 'Sign Up',
              onPressed: () async {
                if (formKey.currentState != null) {
                  if (formKey.currentState!.validate() &&
                      selectedGender != null) {
                    formKey.currentState!.save();
                    Signup.EmailSignup = email.text;
                    await signupback(
                      firstName.text,
                      lastName.text,
                      email.text,
                      password.text,
                      address.text,
                      selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : '',
                      phoneA.text,
                    );
                  }
                }
              },
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            HaveAccount(
              name1: "Do Have An Account? ",
              press: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              name2: 'Login',
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneField(int child) {
    return custemField(
      hintText: 'Phone Number',
      controller: phoneA,
      validator: (value) {
        if (value!.length == 10 &&
            (value.startsWith('059') || value.startsWith('056'))) {
        } else if (value.isEmpty) {
          return 'This Field is required';
        } else {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      icon: Icons.phone,
    );
  }

  Widget textField2() {
    return PassField(
      onPressed: () {
        setState(() {
          valpass = !valpass;
        });
      },
      controller: password,
      obscureText: !valpass,
      icon: valpass ? Icons.visibility : Icons.visibility_off,
      hintText: 'Password',
    );
  }

  Widget buildWebSignup() {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/icon/back.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Navigation bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trade Tryst',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Home',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'About',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Contact',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Signup form
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.only(top: 10, right: 60, left: 60),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF063A4E),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        textfield1(),
                        // Add other fields here as needed
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? buildWebSignup() : buildMobileSignup();
  }

  Widget buildMobileSignup() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * -0.045,
            left: MediaQuery.of(context).size.width * -0.05,
            right: MediaQuery.of(context).size.width * -0.05,
            child: Stack(
              children: [
                Image.asset(
                  'images/icon/DESSIGNUP.png',
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * -0.025,
                  child: Icon(
                    Icons.circle,
                    size: 50,
                    color: Color.fromARGB(255, 215, 218, 219),
                  ),
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * -0.025,
                  child: Icon(Icons.account_circle,
                      size: 50, // Adjust the size of the icon as needed
                      color: const Color.fromARGB(255, 46, 120, 126)),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 90, right: 40, left: 40),
              child: textfield1(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signupback(
      String first_name,
      String last_name,
      String email,
      String password,
      String address,
      String birthday,
      String phone_number) async {
    final url = Uri.parse('http://$ip:3000/tradetryst/user/signup');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'first_name': first_name,
          'last_name': last_name,
          'email': email,
          'password': password,
          'address': address,
          'birthday': birthday,
          'phone_number': phone_number,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          UserCredential credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          firestore.collection('Theusers').doc(credential.user!.uid).set({
            'uid': credential.user!.uid,
            'email': email,
            'first_name': first_name,
            'last_name': last_name,
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VerifyEmail()));
        print('Signup successful');
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email already in use."),
        ));
        print('Email already in use.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to authenticate.'),
        ));
        print('Failed to authenticate. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
