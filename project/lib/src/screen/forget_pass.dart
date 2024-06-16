// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:project/src/mixins/valid_mixin.dart';
import 'package:project/src/screen/otp_form.dart';
import 'package:project/src/screen/verfication_code.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ForgetPassword extends StatefulWidget {
  @override
  ForgetPass createState() => ForgetPass();
}

class ForgetPass extends State<ForgetPassword> with ValidationMixin {
  VerificationService verificationService = VerificationService();
  EmailOTP auth = EmailOTP();
  static String emailUser = '';
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? buildWebForgetPassword() : buildMobileForgetPassword();
  }

  Widget buildMobileForgetPassword() {
    return Scaffold(
      body: Stack(
        children: [
          CustemDesign(
            text: 'Forget Password',
            text2: 'Are you forget your password ?',
            fontSize: 18,
            num2: MediaQuery.of(context).size.width * 0.12,
            num: MediaQuery.of(context).size.width * 0.16,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 380.0,
                left: 50,
                right: 50,
              ),
              child: buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebForgetPassword() {
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
                              'Forget Password',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF063A4E),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Are you forget your password?',
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
                              child: buildForm(),
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

  Widget buildForm() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          custemField(
            hintText: 'Username',
            controller: email,
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
          SizedBox(height: 30.0),
          CustomeButton2(
            text: 'Send',
            onPressed: () async {
              if (formKey.currentState != null &&
                  formKey.currentState!.validate()) {
                formKey.currentState!.save();
                auth.setConfig(
                  appEmail: "system@gmail.com",
                  appName: "Trade Tryst, Your Verification Code",
                  userEmail: email.text,
                  otpLength: 4,
                  otpType: OTPType.digitsOnly,
                );

                try {
                  if (await auth.sendOTP()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP has been sent")),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpForm(myauth: auth)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Oops, OTP send failed")),
                    );
                  }
                } catch (e) {
                  print("Error sending OTP: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Error sending OTP. Please try again later."),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
