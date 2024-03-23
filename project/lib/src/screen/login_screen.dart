//import 'dart:html';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print, non_constant_identifier_names

//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
//import 'dart:html';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, use_key_in_widget_constructors, use_build_context_synchronously, avoid_print, non_constant_identifier_names

//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:convert';

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
              String jj = passwordController.text;
              print("hi $ii\n");
              print("hi $jj\n");
              await loginnn(ii, jj);

              //ayaaaaa
              try {
                final credential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );

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
              }

              //aya
              on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }

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

/*
import 'dart:convert';
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
import 'package:project/widgets/pass_field.dart';

//import 'package:awesome_dialog/awesome_dialog.dart';
class Login extends StatefulWidget {
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
              String jj = passwordController.text;
              print("hi $ii\n");
              print("hi $jj\n");
              await loginnn(ii, jj);
              try {
                final credential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                Navigator.of(context).pushReplacementNamed("homepagee");
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
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * -0.02,
            left: 0,
            right: MediaQuery.of(context).size.width * -0.05, //-20,
            child: Image.asset(
              'images/icon/designB.png', // Path to your image asset
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

  Future<void> loginnn(String email, String password) async {
    final url = Uri.parse(
        'http://192.168.1.126:3000/login'); // Update with your server IP
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

      if (response.statusCode == 200) {
        // Authentication successful
        print('Login successful');
        // Navigate to the home page or perform any other actions
      } else if (response.statusCode == 401) {
        // Invalid email or password
        print('Invalid email or password');
      } else {
        // Other error occurred
        print('Failed to authenticate. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
*/
