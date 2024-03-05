import 'package:flutter/material.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/design.dart';
import 'package:project/widgets/pass_field.dart';

class NewPass extends StatefulWidget {
  @override
  NewPassword createState() => NewPassword();
}

class NewPassword extends State<NewPass> {
  bool valpass = false;
  TextEditingController passwordController = TextEditingController();
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
            PassField(
              onPressed: () {
                setState(() {
                  valpass = !valpass;
                });
              },
              controller: passwordController,
              obscureText: !valpass,
              icon: valpass ? Icons.visibility : Icons.visibility_off,
              hintText: 'New Password',
            ),
            SizedBox(
              height: 20,
            ),
            PassField(
              onPressed: () {
                setState(() {
                  valpass = !valpass;
                });
              },
              controller: passwordController,
              obscureText: !valpass,
              icon: valpass ? Icons.visibility : Icons.visibility_off,
              hintText: 'Confirm Password',
            ),
            SizedBox(
              height: 20,
            ),
            CustomeButton2(
                text: 'Update',
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }),
          ],
        ),
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustemDesign(
            text: 'Update Password ',
            text2: 'Enter your new password',
            fontSize: 18,
            num2: MediaQuery.of(context).size.width * 0.2,
            num: MediaQuery.of(context).size.width * 0.16,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 430.0,
                left: 50,
                right: 50,
              ),
              child: textfield1(),
            ),
          ),
        ],
      ),
    );
  }
}
