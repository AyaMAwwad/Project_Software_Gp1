// ignore_for_file: prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/chat_screen.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/notification_send_msg.dart';

class CustemAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustemAppBar({super.key, required this.text});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    double wid, wid1;

    if (text == 'Smart devices' ||
        text == 'Shopping Cart' ||
        text == 'Robot cleaner') {
      wid = MediaQuery.of(context).size.width * 0.14;
      wid1 = MediaQuery.of(context).size.width * 0.13;
    } else if (text == 'Add Product' ||
        text == 'PlayStation' ||
        text == 'Skate Shoes' ||
        text == 'Refrigerator') {
      wid = MediaQuery.of(context).size.width * 0.2;
      wid1 = MediaQuery.of(context).size.width * 0.14;
    } else if (text == 'Houseware' ||
        text == 'Wardrobes' ||
        text == 'Shoe Racks' ||
        text == 'Philosophy' ||
        text == 'Humidifier') {
      wid = MediaQuery.of(context).size.width * 0.2;
      wid1 = MediaQuery.of(context).size.width * 0.17;
    } else if (text == 'Self-help' || text == 'computer') {
      wid = MediaQuery.of(context).size.width * 0.27;
      wid1 = MediaQuery.of(context).size.width * 0.13;
    } else if (text == 'VR Headsets' ||
        text == 'Motorcycles' ||
        text == 'Commercial' ||
        text == 'Dishwasher') {
      wid = MediaQuery.of(context).size.width * 0.23;
      wid1 = MediaQuery.of(context).size.width * 0.1;
    } else if (text == 'Vacuum cleaner' ||
        text == 'Electrical Tools' ||
        text == 'Coffee Machine') {
      wid = MediaQuery.of(context).size.width * 0.18;
      wid1 = MediaQuery.of(context).size.width * 0.05;
    } else {
      wid = MediaQuery.of(context).size.width * 0.25;
      wid1 = MediaQuery.of(context).size.width * 0.17;
    }
    return
        // backgroundColor: Color.fromARGB(255, 201, 111, 111),
        Padding(
      padding: const EdgeInsets.only(right: 5.0, left: 5),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.dashboard,
                    color: Color.fromARGB(
                        255, 2, 92, 123), //Color.fromARGB(255, 3, 94, 124),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: wid,
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.start,
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
                  "9".tr,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(
                    255, 254, 247, 255), // Color.fromARGB(255, 255, 251, 254),
                child: IconButton(
                  icon: Icon(
                    // FontAwesomeIcons.bell,
                    Icons.notifications,
                    color: Color.fromARGB(255, 2, 92, 123),
                    size: 26,
                  ),
                  onPressed: () {
                    // triggerNotification();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()));
                    // navigatorKey.currentState!.pushNamed('notification', arguments: msg);
                  },
                ),
              ),
              CircleAvatar(
                backgroundColor: Color.fromARGB(
                    255, 254, 247, 255), //Color.fromARGB(255, 255, 251, 254),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookMessenger,
                    color: Color.fromARGB(255, 2, 92, 123),
                    // size: 30,
                    //  color: kTextColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
