//import 'dart:html';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/mixins/valid_mixin.dart';

import 'package:project/src/screen/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:project/src/screen/forget_pass.dart';

import 'package:project/src/screen/signup_screen.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/form_field.dart';
import 'package:project/widgets/pass_field.dart';

//import 'package:awesome_dialog/awesome_dialog.dart';
class Login extends StatefulWidget {
  // @override
  //LoginScreen Login.createState({super.key}) => LoginScreen();

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
          /* Image.asset(
            'lib/assest/logo3.png',
            width: 900.0,
            height: 200.0,
          ),
*/
          SizedBox(
            height: 20.0,
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
            hintText: 'Login',
            onPressed: () async {
              // Add the action the button should perform
              onFormSubmitted();
              try {
                final credential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                if (credential.user!.emailVerified) {
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
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
              // Navigator.push(
              //   context, MaterialPageRoute(builder: (context) => HomePage()));

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
          accountfunction(),
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
                color: Color.fromARGB(255, 2, 92, 123),
                size: 30,
              ),
              // Twitter Icon
              //  SizedBox(width: 10.0), //
              Icon(
                FontAwesomeIcons.twitter,
                color: Color.fromARGB(255, 2, 92, 123),
                size: 30,
              ),
              // Google Icon
              // SizedBox(width: 2.0), //
              Icon(
                FontAwesomeIcons.google,
                color: Color.fromARGB(255, 2, 92, 123),
                size: 30,
              ),
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

// function have account ???
  accountfunction() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't Have an Account? ",
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 1, 3, 4),
                fontSize: 14,

                // decoration: TextDecoration.underline,
                decorationThickness: 1,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
////
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
            child: Text(
              "Sign Up",
              //  body: :
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 14,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  fontWeight: FontWeight.bold,
                  //padding: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    //return  ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('career Voyage'),
          // Text(),
          ),
      body: Padding(
        // Text(style: ,),
        padding: EdgeInsets.all(55.0),
        //  child: textfield1(),
        child: SingleChildScrollView(
          child: //FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser == null
                  ? textfield1()
                  : FirebaseAuth.instance.currentUser!.emailVerified
                      ? textfield1()
                      : ElevatedButton(
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
                        ),
          // textfield1(),
        ),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Either email or password is invalid, handle accordingly
        print('Invalid email or password');
      }
      // Perform the login action or any other actions
      // print('Form is valid. Logging in...');
    }
    //return isemailvalid;
  }
} // login screen end


//
/*
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else {
    final isValid = validateEmail(value);
    if (isValid != null) {
      return null; // Return null if the email is valid
    } else {
      return 'Please enter a valid email address';
    }
  }
}*/
