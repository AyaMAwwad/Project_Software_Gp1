// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/menu.dart';
import 'package:project/src/screen/wishlist_page.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_item.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/user_profile.dart';

class CartShop extends StatefulWidget {
  @override
  CartShopState createState() => CartShopState();
}

class CartShopState extends State<CartShop> {
  int selectedIndex = 3;
  static String lang = "119".tr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: menu(),
      body: SafeArea(
        child: Column(
          children: [
            CustemAppBar(
              text: "119".tr,
            ),
            Expanded(
              child: Container(
                //height: 1500,
                padding: EdgeInsets.only(
                  top: 20,
                ),

                child: CartItem(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                HomePageState.isPressTosearch = false;
                HomePageState.isPressTosearchButton = false;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WishlistPage()),
                );
                break;
              case 3:
                CartState().resetCart();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartShop()),
                );
                break;
              case 4:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
                break;
            }
          });
        },
        //  context: context,
      ), /*BottomNavBar(
        selectedMenu: MenuState.profile,
      ),*/
    );
  }
}
