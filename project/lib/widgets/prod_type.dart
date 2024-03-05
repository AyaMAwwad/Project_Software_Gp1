import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductType extends StatelessWidget {
  final String name;
  final VoidCallback press;
  const ProductType({
    super.key,
    required this.name,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: press,
        child: Container(
          child: Chip(
            backgroundColor: Color.fromARGB(255, 215, 215, 215),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 2, 92, 123),
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
