import 'package:flutter/material.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/enam.dart';

class CartShop extends StatefulWidget {
  @override
  CartShopState createState() => CartShopState();
}

class CartShopState extends State<CartShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.cart,
      ),
    );
  }
}
