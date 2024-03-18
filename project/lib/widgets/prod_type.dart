// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/enam.dart';
import 'dart:ui';

class ProductType extends StatelessWidget {
  final String name;
  final VoidCallback press;
  final TypeProductState selectedType;
  final TypeProductState currentSelectedType;
  final Function(TypeProductState) updateSelectedType;
  //final TypeState selectedtype;

  const ProductType({
    super.key,
    required this.name,
    required this.press,
    required this.selectedType,
    required this.currentSelectedType,
    required this.updateSelectedType,
    // required this.selectedtype,
  });
  @override
  Widget build(BuildContext context) {
    final Color inactivecolor =
        Color.fromARGB(255, 157, 156, 156).withOpacity(0.9);
    final Color activeColor = Color.fromARGB(255, 59, 83, 92).withOpacity(0.6);
    // final Color inactivecolor = Colors.grey;
    // final Color activecolor = Color.fromARGB(255, 2, 92, 123);
    //Color containerColor = inactivecolor;

    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 10),
      child: GestureDetector(
        onTap: () {
          press();
          updateSelectedType(selectedType);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              color: selectedType == currentSelectedType
                  ? activeColor
                  : inactivecolor, // Color.fromARGB(
              // 255, 134, 135, 134), // Color.fromARGB(255, 95, 150, 168),
              // borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 30,
                ),
              ],
            ),
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05),
                          ]),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255,
                                255), // Color.fromARGB(255, 4, 51, 67),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
