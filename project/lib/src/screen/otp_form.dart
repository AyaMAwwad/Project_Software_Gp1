// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/src/screen/new_pass.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OtpForm extends StatefulWidget {
  final EmailOTP myauth;

  const OtpForm({super.key, required this.myauth});

  @override
  OtpFormEmail createState() => OtpFormEmail();
}

class OtpFormEmail extends State<OtpForm> {
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  late String a1, a2, a3, a4;

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? buildWebOtpForm() : buildMobileOtpForm();
  }

  Widget buildMobileOtpForm() {
    return Scaffold(
      body: Stack(
        children: [
          CustemDesign(
            text: 'Verification Code',
            text2: 'We have sent verification code to your email',
            num2: MediaQuery.of(context).size.width * 0.07,
            fontSize: 15,
            num: MediaQuery.of(context).size.width * 0.16,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20, top: 410),
              child: buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebOtpForm() {
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
                              'Verification Code',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF063A4E),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'We have sent a verification code to your email',
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
                              child:
                                  buildForm(), // Ensure the buildForm() widget exists and is defined in your code
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildOtpTextField(otp1),
              buildOtpTextField(otp2),
              buildOtpTextField(otp3),
              buildOtpTextField(otp4),
            ],
          ),
          SizedBox(height: 20),
          CustomeButton2(
            text: 'Confirm',
            onPressed: () async {
              if (await widget.myauth.verifyOTP(
                      otp: (otp1.text + otp2.text + otp3.text + otp4.text)) ==
                  true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Verified"),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPass()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid Code"),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildOtpTextField(TextEditingController controller) {
    return SizedBox(
      height: 70,
      width: 70,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
