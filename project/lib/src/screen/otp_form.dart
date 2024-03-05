// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/src/screen/new_pass.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';

class OtpForm extends StatefulWidget {
  @override
  OtpFormEmail createState() => OtpFormEmail();
}

class OtpFormEmail extends State<OtpForm> {
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
            fromEmail(),
            Container(
              height: 20,
            ),
            CustomeButton2(
              text: 'Confirm',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPass()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  fromEmail() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: TextFormField(
              onSaved: (pin1) {},
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
                  borderSide: BorderSide(color: Colors.black), // Border color
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            width: 70,
            child: TextFormField(
              onSaved: (pin2) {},
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
                  borderSide: BorderSide(color: Colors.black), // Border color
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            width: 70,
            child: TextFormField(
              onSaved: (pin3) {},
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
                  borderSide: BorderSide(color: Colors.black), // Border color
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            width: 70,
            child: TextFormField(
              onSaved: (pin4) {},
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
                  borderSide: BorderSide(color: Colors.black), // Border color
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
