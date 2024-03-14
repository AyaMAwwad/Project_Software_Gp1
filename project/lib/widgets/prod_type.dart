// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/enam.dart';

class ProductType extends StatelessWidget {
  final String name;
  final VoidCallback press;
  //final TypeState selectedtype;

  const ProductType({
    super.key,
    required this.name,
    required this.press,
    // required this.selectedtype,
  });
  @override
  Widget build(BuildContext context) {
    // final Color inactivecolor = Colors.grey;
    // final Color activecolor = Color.fromARGB(255, 2, 92, 123);
    //Color containerColor = inactivecolor;

    return Padding(
      padding: EdgeInsets.all(13),
      child: GestureDetector(
        onTap: press,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 92, 123), // Color.fromARGB(
              // 255, 134, 135, 134), // Color.fromARGB(255, 95, 150, 168),
              // borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Color.fromARGB(255, 4, 51, 67),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
