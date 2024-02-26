// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/mixins/valid_mixin.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/form_field.dart';
import 'package:project/widgets/pass_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  SignupScreen createState() => SignupScreen();
}

class SignupScreen extends State<Signup> with ValidationMixin {
  String? selectedGender;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  //TextEditingController phone = TextEditingController();
  //TextEditingController gender = TextEditingController();
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
                } /*else if (validatemail(value)) {
                return null;
              } else {
                return 'Please enter your valid email';
              }*/
              },
              icon: Icons.person,
            ),

            SizedBox(
              height: 30.0,
            ),

            custemField(
              hintText: 'Last Name',
              controller: lastName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name';
                }
              },
              icon: Icons.person,
            ),
            SizedBox(
              height: 30.0,
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
              height: 30.0,
            ),
            phoneField(3),
            //Style(child: 3),
            SizedBox(
              height: 30.0,
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
              height: 30.0,
            ),
////////////////////////
            //
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(82, 209, 224, 223),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color(0xFF063A4E),
                  size: 22,
                ),
                hintText: selectedDate == null
                    ? 'Select your birthday'
                    : DateFormat('yyyy-MM-dd').format(selectedDate!),
                hintStyle: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF107086),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2679A3)),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16,
                ),
              ),
              // validator: validPhone,
              onSaved: (String? val) {
                // ignore: avoid_print
                phone = val!;
              },
              onTap: () {
                // Show date picker when the text field is tapped
                _selectDate(context);
              },
            ),
            //////////////
            //Style(child: 5),
            SizedBox(
              height: 30.0,
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
              hintText: 'Sign Up',
              onPressed: () async {
                if (formKey.currentState != null) {
                  //formKey.currentState!.reset();
                  // ignore: avoid_print
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // ignore: avoid_print
                    //print('Time to post $email and $password to API');

                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      //FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      Navigator.of(context).pushReplacementNamed("login");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }
              },
              borderRadius: BorderRadius.all(Radius.circular(40)),
              // loginButton(),
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
      controller: address,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    //double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Account ',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 2, 92, 123),
              fontSize: 20,

              // decoration: TextDecoration.underline,
              decorationThickness: 1,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: textfield1(),
        ),
      ),
    );
  }
}
