// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_declarations, use_super_parameters

// the my code
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  //final BuildContext context;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    // required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Color.fromARGB(255, 90, 141, 158),
      buttonBackgroundColor: Color.fromARGB(
          255, 90, 141, 158), // Color.fromARGB(255, 10, 83, 107),
      animationDuration: Duration(milliseconds: 300),
      onTap: onTabSelected,
      height: 50,
      index: selectedIndex,
      items: [
        Icon(IconsaxBold.home_2, color: Colors.white),
        Icon(IconsaxBold.box_add, //Icons.add_circle_outline_rounded,
            color: Colors.white),
        Icon(Icons.add_shopping_cart,
            color: Colors.white), //shopping_cart_outlined
        Icon(IconsaxBold.profile_circle, //Icons.person_outline_outlined,
            color: Colors.white),
      ],
      animationCurve: Curves.easeInOutBack, //easeInQuart,
      letIndexChange: (index) => true,
    );
  }
}
/*
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 147, 198, 215),
            Color.fromARGB(255, 95, 150, 168),
            Color.fromARGB(255, 66, 119, 138),
            Color.fromARGB(255, 95, 150, 168),
            Color.fromARGB(255, 147, 198, 215),
          ],
        ),
      ),
      child: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.transparent,
        buttonBackgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        onTap: onTabSelected,
        height: 50,
        index: selectedIndex,
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.add_circle_outline_rounded, color: Colors.white),
          Icon(Icons.shopping_cart_outlined, color: Colors.white),
          Icon(Icons.person_outline_outlined, color: Colors.white),
        ],
        animationCurve: Curves.easeInOutBack,
        letIndexChange: (index) => true,
      ),
    );
  }
}*/

/*
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

*/
