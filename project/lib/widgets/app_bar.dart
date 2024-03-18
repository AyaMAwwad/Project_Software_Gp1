// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/login_screen.dart';

class CustemAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustemAppBar({super.key, required this.text});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    double wid, wid1;
    if (text == 'Smart devices') {
      wid = MediaQuery.of(context).size.width * 0.14;
      wid1 = MediaQuery.of(context).size.width * 0.13;
    } else if (text == 'Houseware') {
      wid = MediaQuery.of(context).size.width * 0.2;
      wid1 = MediaQuery.of(context).size.width * 0.17;
    } else {
      wid = MediaQuery.of(context).size.width * 0.25;
      wid1 = MediaQuery.of(context).size.width * 0.17;
    }
    return
        // backgroundColor: Color.fromARGB(255, 201, 111, 111),
        Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Color.fromARGB(255, 2, 92, 123),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            right: wid,
          ),
        ),
        Column(
          children: [
            Text(
              text,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Trade Tryst",
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 78, 78, 78),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(
            right: wid1,
          ),
        ),
        /* CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Color.fromARGB(255, 2, 92, 123),
              // size: 30,
              //  color: kTextColor,
            ),
            onPressed: () {},
          ),
        ),*/
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.bell,
              color: Color.fromARGB(255, 2, 92, 123),
              // size: 30,
              //  color: kTextColor,
            ),
            onPressed: () {},
          ),
        ),
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.message,
              color: Color.fromARGB(255, 2, 92, 123),
              // size: 30,
              //  color: kTextColor,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
