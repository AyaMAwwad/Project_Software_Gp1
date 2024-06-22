import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ficonsax/ficonsax.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/adminscreen.dart';
import 'package:project/src/screen/cat_screen.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/chat_page.dart';
import 'package:project/src/screen/chat_screen.dart';
import 'package:project/src/screen/currency.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/src/screen/saller_product_page.dart';
import 'package:project/src/screen/security.dart';
import 'package:project/src/screen/settings.dart';
import 'package:project/src/screen/wishlist_page.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';
import 'package:project/widgets/search_page.dart';
import 'package:project/widgets/slider.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/widgets/user_profile.dart';
import 'package:project/widgets/delivery_page.dart';

class menu extends StatefulWidget {
  @override
  State<menu> createState() => menuopagee();
}

class menuopagee extends State<menu> {
  static bool isPressTosearch = false;
  static bool isPressTosearchButton = false;
  String firsttname = Login.first_name;
  String lastttname = Login.last_name;
  String emailbefore = Login.Email;

  String imagepath = 'images/icon/userprofile.png';

  @override
  void initState() {
    super.initState();
    // FirebaseNotification.getDiveceToken();
    //fetchProducts();

    //
    if (PrivacySecurity.Delete == 'delete') {
      setState(() {
        // Update the image path if the condition is met
        imagepath = 'images/icon/nohuman.png'; // New image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theproduct = HomePageState.userDetails[0];
    final imageData = theproduct['profile_image'];
    Uint8List? bytes;
    if (imageData != null) {
      bytes = Uint8List.fromList(List<int>.from(imageData['data']));
    }

    return Drawer(
      //child: CustemAppBar(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('$firsttname $lastttname'),
            accountEmail: Text('$emailbefore'),
            currentAccountPicture:
                (bytes != null && bytes.isNotEmpty && !UserProfileState.isPress)
                    ? CircleAvatar(
                        radius: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                            width: 72,
                            height: 72,
                            child: Image.memory(
                              bytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : (UserProfileState.imagesayyya == null)
                        ? CircleAvatar(
                            radius: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'images/icon/profile.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 72,
                                height: 72,
                                child: Image.file(
                                  UserProfileState.imagesayyya!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),

            /*CircleAvatar(
              radius: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  imagepath,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 92, 123),
            ),
          ),

/*
UserAccountsDrawerHeader(
  accountName: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$firsttname $lastttname',
        style: TextStyle(
          fontSize: 18, // Adjust the font size of the account name
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10), // Adjust the height of the SizedBox
    ],
  ),
  accountEmail: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$emailbefore',
        style: TextStyle(
          fontSize: 18, // Adjust the font size of the account email
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10), // Adjust the height of the SizedBox
    ],
  ),
  currentAccountPicture: Column(
    crossAxisAlignment: CrossAxisAlignment.center, // Adjusted the crossAxisAlignment to center
    children: [
      CircleAvatar(
        radius: 60, // Reduce the radius of the CircleAvatar
        child: ClipOval(
          child: Image.asset(
            'images/icon/userprofile.png',
            fit: BoxFit.cover, // Ensure the image covers the entire circular area
          ),
        ),
      ),
      SizedBox(height: 10), // Adjust the height of the SizedBox
    ],
  ),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 2, 92, 123),
  ),
),
*/
//
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.account_circle,
                size: 30, color: Color.fromARGB(255, 2, 92, 123)),
            title: Text(
              '8'.tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 18,
                  //   color: Color.fromARGB(255, 2, 92, 123),
                ),
              ),
            ),
            onTap: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ), // SettingsPage
          Visibility(
            visible: isPressTosearch || isPressTosearchButton,
            child: ListTile(
                leading: Icon(Icons.arrow_back_ios_new,
                    size: 24, color: Color.fromARGB(255, 2, 92, 123)),
                title: Text(
                  "137".tr,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 18,
                      //  color: Color.fromARGB(255, 2, 92, 123),
                    ),
                  ),
                ),
                onTap: () => {
                      isPressTosearch = false,
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ),
                      // Navigator.pop(context),
                    } //print('Notifications'),
                ),
          ),
          ListTile(
            leading: Icon(Icons.settings,
                size: 30, color: Color.fromARGB(255, 2, 92, 123)),
            title: Text(
              '62'.tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 18,
                  // color: Color.fromARGB(255, 2, 92, 123),
                ),
              ),
            ),
            onTap: () //async
                {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => SettingsPage()),
              // );
              Get.to(() => SettingsPage());
            },
          ),
          ListTile(
            leading: Icon(IconsaxBold.bag,
                size: 30, color: Color.fromARGB(255, 2, 92, 123)),
            title: Text(
              '144'.tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 18,
                  //  color: Color.fromARGB(255, 2, 92, 123),
                ),
              ),
            ),
            onTap: () {
              Get.to(() => SellarPage());
            },
          ),
          //new
          ListTile(
            leading: Icon(Icons.monetization_on,
                size: 30, color: Color.fromARGB(255, 2, 92, 123)),
            title: Text(
              'Select Currency',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 18,
                  // color: Color.fromARGB(255, 2, 92, 123),
                ),
              ),
            ),
            onTap: () //async
                {
              // Navigator.pushReplacement(
              //  context,
              //  MaterialPageRoute(builder: (context) => currency()),
              // );

              Get.to(() => currency());
            },
          ),

          // admin ********************

          if (Login.usertypee == 'Admin')
            ListTile(
              leading: Icon(Icons.admin_panel_settings,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                'Admin Dashboard',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    // color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () //async
                  {
                // Navigator.pushReplacement(
                //  context,
                //  MaterialPageRoute(builder: (context) => currency()),
                // );

                Get.to(() => AdminDashboard());
              },
            ),

          //   },

          // admin ***********************
          ListTile(
            leading: Icon(Icons.logout,
                size: 30, color: Color.fromARGB(255, 2, 92, 123)),
            title: Text(
              '60'.tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 18,
                  //  color: Color.fromARGB(255, 2, 92, 123),
                ),
              ),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),

      /*
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),*/
    );
  }
}
