import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpForm extends StatefulWidget {
  @override
  OtpFormEmail createState() => OtpFormEmail();
}

class OtpFormEmail extends State<OtpForm> {
  formDesign() {
    return SingleChildScrollView(
      // child: Padding(
      // key: formKey,
      // padding: EdgeInsets.all(20.0),
      child: Form(
        /// key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
            ),
            Text(
              'Verification Code ',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 30,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Text(
              'We have sent verification code to your email',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 168, 169, 170),
                  fontSize: 15,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 40,
            ),
            fromEmail(),
            Container(
              height: 40,
            ),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0D6775),
        minimumSize: Size(90, 40),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      /*child: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushReplacementNamed("login");
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => Login()));
        },*/
      child: Text(
        'Confirm',
        style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
          ),
        ),
      ),
      //),
      onPressed: () async {},
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Code Verfication  ',
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
          child: formDesign(),
        ),
      ),
    );
  }
}
