// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_declarations
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/user_profile.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final BuildContext context;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.white.withOpacity(0.0003),
      color: Color.fromARGB(255, 95, 150, 168),
      animationDuration: Duration(microseconds: 300),
      onTap: (index) {
        onTabSelected(
            index); // Call the callback function to update selected index
      },
      height: 50,
      index: selectedIndex, // Set the selected index
      items: [
        Icon(Icons.home_outlined, color: Colors.white),
        Icon(Icons.add_circle_outline_rounded, color: Colors.white),
        Icon(Icons.shopping_cart_outlined, color: Colors.white),
        Icon(Icons.person_outline_outlined, color: Colors.white),
      ],
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/widgets/add_product.dart';
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
              Icons.add_circle_outline_rounded,
              color: MenuState.addprod == selectedMenu
                  ? Color.fromARGB(255, 2, 92, 123)
                  : inactivecolor,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()));
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
*/