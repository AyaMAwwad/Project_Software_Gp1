import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/mixins/valid_mixin.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/src/screen/forget_pass.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/signup_screen.dart';
import 'package:project/src/screen/verify_email.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/form_field.dart';
import 'package:project/widgets/have_account.dart';
import 'package:project/widgets/pass_field.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  static String usertypee = ''; // admin

  @override
  LoginScreen createState() => LoginScreen();
}

class LoginScreen extends State<Login> with ValidationMixin {
  static bool isUserLog = false;
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
          SizedBox(height: kIsWeb ? 50 : 20.0),
          Container(
            width: 300,
            child: custemField(
              hintText: 'Email',
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (validatemail(value)) {
                  return null;
                } else {
                  return 'Please enter a valid email';
                }
              },
              icon: Icons.email,
            ),
          ),
          SizedBox(height: 25.0),
          Container(
            width: 300,
            child: textField2(),
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                  },
                  child: Container(
                    child: Text(
                      'Forget Your password?',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 2, 92, 123),
                          fontSize: 14,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          CustomeButton(
            text: 'Login',
            onPressed: () async {
              onFormSubmitted();
              String ii = emailController.text;
              Login.Email = emailController.text;
              String jj = passwordController.text;
              await getTheName(Login.Email);
              await loginnn(ii, jj);
            },
            borderRadius: BorderRadius.circular(30.0),
          ),
          SizedBox(height: 25.0),
          HaveAccount(
            name1: "Don't Have An Account? ",
            press: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
            name2: 'Sign up',
          ),
          SizedBox(height: 25.0),
          OrText(),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.facebook,
                color: Color.fromARGB(255, 9, 93, 123),
                size: 30,
              ),
              Icon(
                FontAwesomeIcons.twitter,
                color: Color.fromARGB(255, 9, 93, 123),
                size: 30,
              ),
              Icon(
                FontAwesomeIcons.google,
                color: Color.fromARGB(255, 9, 93, 123),
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textField2() {
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

  OrText() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.white,
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
      body: kIsWeb ? webLoginScreen() : mobileLoginScreen(),
    );
  }

  Widget mobileLoginScreen() {
    return Stack(
      children: [
        Positioned(
          // top:0,  // ibti web
          // left:0, ayy
          //  right: 0,  // ibti web
          top: MediaQuery.of(context).size.height * -0.026, // -0.02
          // left: 0,
          left: MediaQuery.of(context).size.width * -0.4,
          right: MediaQuery.of(context).size.width * -0.02, //-20,
          child: Image.asset(
            'images/icon/FINALDES.png', //'images/icon/DS1.png', //designB.png,
            //'images/icon/svg.png',
            // Adjust height as needed
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            // pri
            height: 250,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90.0),
              Image.asset(
                'images/icon/FinalLogo.png',
                width: 900.0,
                height: 200.0,
              ),
              // SizedBox(height: 10.0),
              textfield1(),
            ],
          ),
        ),
      ],
    );
  }

  Widget webLoginScreen() {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'images/icon/back.jpg',
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
                        'Login',
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
        // Login form
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 400,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 167, 167, 167)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'LOG IN',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF063A4E),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textfield1(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

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

  Future<void> loginnn(String email, String password) async {
    final url = Uri.parse('http://$ip:3000/tradetryst/user/login');
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
            Login.usertypee = user['user_type']; // admin
            print('First Name: ${Login.first_name}');
            print('id user: ${Login.idd}');
            print('id user: ${Login.birthdaylogin}');
            print('typehh  user: ${Login.usertypee}');
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
        isUserLog = true;
        Navigator.of(context).pushReplacementNamed("homepagee");
        // Authentication successful
        // await checkQuantityForNotification(Login.idd);
        print('Login successful');
        scheduleNotifications();
        // triggerNotification();
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
      response = await http.get(
          Uri.parse('http://$ip:3000/tradetryst/user/userName?email=$email'));
      if (response.statusCode == 200 || response.statusCode == 201) {
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
      //    throw Exception('Failed  : $e');
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
}
