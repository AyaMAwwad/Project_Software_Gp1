// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:project/src/screen/ipaddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  static String EmailSignup = '';
  @override
  SignupScreen createState() => SignupScreen();
}

class SignupScreen extends State<Signup> with ValidationMixin {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //////////
  String? selectedGender;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneA = TextEditingController();
  TextEditingController gender = TextEditingController();
  //String email = '';
  String phone = '';
  DateTime? selectedDate;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Function to show date picker
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
      // child: Padding(
      // key: formKey,
      // padding: EdgeInsets.all(20.0),
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
                return null; /*else if (validatemail(value)) {
                return null;
              } else {
                return 'Please enter your valid email';
              }*/
              },
              icon: Icons.person,
            ),

            SizedBox(
              height: 25.0,
            ),

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
            SizedBox(
              height: 25.0,
            ),
            // emailField(),

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
            SizedBox(
              height: 25.0,
            ),
            phoneField(3),
            //Style(child: 3),
            SizedBox(
              height: 25.0,
            ),

            custemField(
              hintText: 'Adreess',
              controller: address,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Adreess';
                }
                return null;
              },
              icon: Icons.location_on,
            ),
            SizedBox(
              height: 25.0,
            ),
////////////////////////
            //
            DateField(
              controller: gender,
              onTap: () {
                _selectDate(context);
              },
              selectedDate: selectedDate,
            ),

            SizedBox(
              height: 25.0,
            ),
            textField2(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
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
                  //formKey.currentState!.reset();

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
                        phoneA.text);

                    //print('Time to post $email and $password to API');
                    //  signInWithEmailAndPassword();
/*
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );

                      //FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      // Navigator.of(context).pushReplacementNamed("login");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }*/
                  }
                }
              },
              borderRadius: BorderRadius.all(Radius.circular(40)),
              // loginButton(),
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
      //  ),
    );
  }

/////////////////////////////////////
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
    // bool valpass = true;

    return PassField(
      onPressed: () {
        setState(() {
          valpass = !valpass;
        });
      },
      controller: password,
      obscureText: !valpass,
      icon: valpass ? Icons.visibility : Icons.visibility_off,
      hintText: 'Password', //Icons.visibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * -0.045, //-20,
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
    final url = Uri.parse(
        'http://$ip:3000/tradetryst/user/signup'); // Update with your server IP
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
          //FirebaseAuth.instance.currentUser!.sendEmailVerification();
          // Navigator.of(context).pushReplacementNamed("login");
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
        // Authentication successful
        print('Signup successful');
        // Navigate to the home page or perform any other actions
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email already in use."),
        ));
        // Invalid email or password
        print('Email already in use.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to authenticate.'),
        ));
        // Other error occurred
        print('Failed to authenticate. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
