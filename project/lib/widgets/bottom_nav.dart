import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

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
    print('******* Bottom Nav Selected index:$selectedIndex');
    if (kIsWeb) {
      return SizedBox();
    } else {
      return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color.fromARGB(255, 90, 141, 158),
        buttonBackgroundColor: Color.fromARGB(255, 90, 141, 158),
        animationDuration: Duration(milliseconds: 300),
        onTap: onTabSelected,
        height: 50,
        index: selectedIndex,
        items: [
          Icon(IconsaxBold.home_2, color: Colors.white),
          Icon(IconsaxBold.box_add, color: Colors.white),
          Icon(Icons.favorite_border, color: Colors.white),
          Stack(
            children: [
              Icon(Icons.add_shopping_cart, color: Colors.white),
              ValueListenableBuilder<int>(
                valueListenable: CartState().cartCountNotifier,
                builder: (context, cartCount, child) {
                  if (cartCount > 0) {
                    return Positioned(
                      right: -1,
                      top: -3,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
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
          Icon(IconsaxBold.profile_circle, color: Colors.white),
        ],
        animationCurve: Curves.easeInOutBack,
        letIndexChange: (index) => true,
      );
    }
  }
}

class CartState {
  // Singleton pattern
  static final CartState _instance = CartState._internal();
  factory CartState() => _instance;

  CartState._internal();

  ValueNotifier<int> _cartCountNotifier = ValueNotifier<int>(0);

  ValueNotifier<int> get cartCountNotifier => _cartCountNotifier;

  int get cartCount => _cartCountNotifier.value;

  void incrementCart() {
    _cartCountNotifier.value++;
  }

  void resetCart() {
    _cartCountNotifier.value = 0;
  }
}



/*import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ficonsax/ficonsax.dart';
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
    final cartCount =
        CartState().cartCount; // Get the cart count from CartState

    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Color.fromARGB(255, 90, 141, 158),
      buttonBackgroundColor: Color.fromARGB(255, 90, 141, 158),
      animationDuration: Duration(milliseconds: 300),
      onTap: onTabSelected,
      height: 50,
      index: selectedIndex,
      items: [
        Icon(IconsaxBold.home_2, color: Colors.white),
        Icon(IconsaxBold.box_add, color: Colors.white),
        Stack(
          children: [
            Icon(Icons.add_shopping_cart, color: Colors.white),
            if (cartCount > 0)
              Positioned(
                right: -1,
                top: -3,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
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
              )
          ],
        ),
        Icon(IconsaxBold.profile_circle, color: Colors.white),
      ],
      animationCurve: Curves.easeInOutBack,
      letIndexChange: (index) => true,
    );
  }
}

class CartState {
  // Singleton pattern
  static final CartState _instance = CartState._internal();
  factory CartState() => _instance;

  CartState._internal();

  int _cartCount = 0;

  int get cartCount => _cartCount;

  void incrementCart() {
    _cartCount++;
  }

  void resetCart() {
    _cartCount = 0;
  }
}
*/
/*
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
}*/