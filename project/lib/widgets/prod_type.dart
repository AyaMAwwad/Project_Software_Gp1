// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/multiLanguage.dart';
import 'package:project/widgets/enam.dart';
import 'dart:ui';

final LinearGradient activeGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 147, 198, 215),
    Color.fromARGB(255, 95, 150, 168),
    Color.fromARGB(255, 66, 119, 138),
    Color.fromARGB(255, 95, 150, 168),
    Color.fromARGB(255, 147, 198, 215),
  ],
);

final LinearGradient inactiveGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    // Colors.grey.withOpacity(0.9),
    // Colors.grey.withOpacity(0.9),
    Colors.white,
    Colors.grey,
    //  Color.fromARGB(255, 147, 198, 215),

    // Color.fromARGB(255, 95, 150, 168),
    // Color.fromARGB(255, 66, 119, 138),
    // Color.fromARGB(255, 95, 150, 168),

    // Color.fromARGB(255, 147, 198, 215),
    Colors.grey,
    Colors.white,
  ],
);

final BoxDecoration activeBoxDecoration = BoxDecoration(
  gradient: activeGradient,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 30,
    ),
  ],
);

final BoxDecoration inactiveBoxDecoration = BoxDecoration(
  gradient: inactiveGradient,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 30,
    ),
  ],
);

class ProductType extends StatelessWidget {
  final String name;
  final VoidCallback press;
  final TypeProductState selectedType;
  final TypeProductState currentSelectedType;
  final Function(TypeProductState) updateSelectedType;

  const ProductType({
    Key? key,
    required this.name,
    required this.press,
    required this.selectedType,
    required this.currentSelectedType,
    required this.updateSelectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MultiLanguage.isEnglish
          ? EdgeInsets.only(left: 50, right: 10)
          : EdgeInsets.only(left: 10, right: 50),
      child: GestureDetector(
        onTap: () {
          press();
          updateSelectedType(selectedType);
        },
        child: Column(
          children: [
            Text(
              name,
              style: GoogleFonts.abyssinicaSil(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: selectedType == currentSelectedType
                      ? Color.fromARGB(255, 2, 92, 123)
                      : Colors.grey,
                ),
              ),
            ),
            if (selectedType ==
                currentSelectedType) // Add line under the text if selected
              Container(
                height: 2,
                width: 40, // Adjust width of the line according to text length
                color: Color.fromARGB(255, 2, 92, 123),
              ),
          ],
        ),
        /*ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 80,
            decoration: selectedType == currentSelectedType
                ? activeBoxDecoration
                : inactiveBoxDecoration,
            child: Container(
              // color: const Color.fromARGB(0, 103, 66, 66),
              child: Center(
                child: Text(
                  name,
                  style: GoogleFonts.abyssinicaSil(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),*/
      ),
    );
  }
}

/*
final LinearGradient activeGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 147, 198, 215),
    Color.fromARGB(255, 95, 150, 168),
    Color.fromARGB(255, 66, 119, 138),
    Color.fromARGB(255, 95, 150, 168),
    Color.fromARGB(255, 147, 198, 215),
  ],
);

final BoxDecoration activeBoxDecoration = BoxDecoration(
  gradient: activeGradient,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 30,
    ),
  ],
);

class ProductType extends StatelessWidget {
  final String name;
  final VoidCallback press;
  final TypeProductState selectedType;
  final TypeProductState currentSelectedType;
  final Function(TypeProductState) updateSelectedType;

  const ProductType({
    Key? key,
    required this.name,
    required this.press,
    required this.selectedType,
    required this.currentSelectedType,
    required this.updateSelectedType,
  });

  @override
  Widget build(BuildContext context) {
    final Color inactiveColor =
        Color.fromARGB(255, 197, 196, 196).withOpacity(0.9);

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
            decoration: selectedType == currentSelectedType
                ? activeBoxDecoration
                : BoxDecoration(
                    color: inactiveColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 30,
                      ),
                    ],
                  ),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  name,
                  style: GoogleFonts.abyssinicaSil(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
*/
/*
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
        Color.fromARGB(255, 197, 196, 196).withOpacity(0.9);
    final Color activeColor = Color.fromARGB(255, 2, 46, 62).withOpacity(0.6);
    /*final LinearGradient gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.blue,
    Colors.green,
  ],
);*/
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
                        style: GoogleFonts.abyssinicaSil(
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
*/