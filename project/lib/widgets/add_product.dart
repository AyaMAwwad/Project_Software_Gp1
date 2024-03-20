import 'package:flutter/material.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/enam.dart';

class AddProduct extends StatefulWidget {
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.addprod,
      ),
    );
  }
}
