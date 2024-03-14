// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/user_profile.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedMenu,
  });
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inactivecolor = Colors.grey;
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDADADA),
            // color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
            // spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: MenuState.home == selectedMenu
                  ? Color.fromARGB(255, 2, 92, 123)
                  : inactivecolor,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: MenuState.cart == selectedMenu
                  ? Color.fromARGB(255, 2, 92, 123)
                  : inactivecolor,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartShop()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person_outline_outlined,
              color: MenuState.profile == selectedMenu
                  ? Color.fromARGB(255, 2, 92, 123)
                  : inactivecolor,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
        ],
      )),
    );
  }
}
