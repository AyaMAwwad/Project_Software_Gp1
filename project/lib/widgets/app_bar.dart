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
import 'package:ficonsax/ficonsax.dart';
import 'package:project/src/screen/order_tracking_page.dart';

class CustemAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustemAppBar({super.key, required this.text});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    double wid, wid1;
    double containerWidth = MediaQuery.of(context).size.width;
    double adjustedWidth = containerWidth - 50;
    if (containerWidth > 1000) {
      adjustedWidth = containerWidth - 300;
    }
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
        // 1 Padding(
        //1 padding: const EdgeInsets.only(right: 5.0, left: 5),
        //1  child:
        // Flexible(
        //   flex: 1,
        //   child:
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // center spaceBetween
      children: [
        Container(
          //   margin: EdgeInsets.symmetric(horizontal: 10),
          // child: SizedBox(
          //  width: adjustedWidth,
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
          // ),
        ),
        // ),

        // Container(
        //   padding: EdgeInsets.only(
        //     right: wid,
        //   ),
        // ),

        Column(
          //
          // crossAxisAlignment: CrossAxisAlignment.start,
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
        // ),

        // Container(
        //   padding: EdgeInsets.only(
        //     right: wid1,
        //   ),
        // ),

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

        //        Align(
        // alignment: Alignment.centerRight,
        // child:

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 253, 246, 254),
              child: IconButton(
                icon: Stack(
                  children: [
                    Icon(
                      IconsaxBold.notification,
                      //Icons.notifications,
                      color: Color.fromARGB(255, 2, 92, 123),
                      size: 26,
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: NotificationState().cartCountNotifier,
                      builder: (context, cartCount, child) {
                        if (cartCount > 0) {
                          return Positioned(
                            right: 0,
                            top: -1,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 13,
                                minHeight: 11,
                              ),
                              child: Text(
                                '$cartCount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),

                /*Icon(
                  // FontAwesomeIcons.bell,
                  IconsaxBold.notification,
                  //Icons.notifications,
                  color: Color.fromARGB(255, 2, 92, 123),
                  size: 26,
                ),*/
                onPressed: () {
                  NotificationState.resetNotification();
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
              backgroundColor: Color.fromARGB(255, 253, 246, 254),
              child: IconButton(
                icon: Icon(
                  IconsaxBold.messages,

                  // FontAwesomeIcons.facebookMessenger,
                  color: Color.fromARGB(255, 2, 92, 123),
                  // size: 30,
                  //  color: kTextColor,
                ),
                onPressed: () {
                  //   triggerNotification();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                      //OrderTrackingPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ], // children
    );
    // ],
    // ),

    //  );
  }
}

class NotificationState {
  // Singleton pattern
  static final NotificationState _instance = NotificationState._internal();
  factory NotificationState() => _instance;

  NotificationState._internal();

  static ValueNotifier<int> _NotificationCountNotifier = ValueNotifier<int>(0);

  ValueNotifier<int> get cartCountNotifier => _NotificationCountNotifier;

  int get cartCount => _NotificationCountNotifier.value;

  static void incrementNotification() {
    _NotificationCountNotifier.value++;
  }

  static void resetNotification() {
    _NotificationCountNotifier.value = 0;
  }
}
