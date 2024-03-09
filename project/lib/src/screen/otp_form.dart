// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/src/screen/new_pass.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';

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
  formDesign() {
    return SingleChildScrollView(
      child: Form(
        /// key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
            ),
            Container(
              height: 110,
            ),
            //fromEmail(),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: TextFormField(
                      onSaved: (pin1) {
                        a1 = pin1!;
                      },
                      controller: otp1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10, left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: TextFormField(
                      controller: otp2,
                      onSaved: (pin2) {
                        a2 = pin2!;
                      },
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10, left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: TextFormField(
                      controller: otp3,
                      onSaved: (pin3) {
                        a3 = pin3!;
                      },
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10, left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust border radius as needed
                          borderSide:
                              BorderSide(color: Colors.black), // Border color
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: TextFormField(
                      controller: otp4,
                      onSaved: (pin4) {
                        a4 = pin4!;
                      },
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10, left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            CustomeButton2(
              text: 'Confirm',
              onPressed: () async {
                if (await widget.myauth.verifyOTP(
                        otp: (otp1.text + otp2.text + otp3.text + otp4.text)) ==
                    true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Verifed"),
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPass()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invlide Code"),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

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
              padding: EdgeInsets.only(right: 20.0, left: 20, top: 300),
              child: formDesign(),
            ),
          ),
        ],
      ),
    );
  }
}
