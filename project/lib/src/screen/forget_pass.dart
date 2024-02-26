import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/mixins/valid_mixin.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/otp_form.dart';
import 'package:project/src/screen/verfication_code.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/form_field.dart';

class ForgetPassword extends StatefulWidget {
  @override
  ForgetPass createState() => ForgetPass();
}

class ForgetPass extends State<ForgetPassword> with ValidationMixin {
  VerificationService verificationService = VerificationService();
  EmailOTP auth = EmailOTP();

  //////
  TextEditingController email = TextEditingController();
  ////////
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  textfield1() {
    return SingleChildScrollView(
      //child: Padding(
      // key: formKey,
      // padding: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.0,
            ),
            custemField(
              hintText: 'UserName',
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
            CustomeButton(
              hintText: 'Send',
              onPressed: () async {
                auth.setConfig(
                  appEmail: "contact@hdevcoder.com",
                  appName: "Email OTP",
                  userEmail: email.text,
                  otpLength: 4,
                  otpType: OTPType.digitsOnly,
                );
                if (await auth.sendOTP() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP has been sent"),
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtpForm()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP send failed"),
                  ));
                }
              },
              borderRadius: BorderRadius.all(Radius.circular(25)),
              // loginButton(),
            ),
            // loginButton(),
          ],
        ),
      ),
      // ),
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
          'Are You Forget Your Password ? ',
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
