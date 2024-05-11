import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/list_for_add.dart';

class custemFieldforProductPage extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final double width;
  //final String Function()? validator;
  //final String? Function(String?)? validator;

  custemFieldforProductPage(
      {super.key,
      required this.hintText,
      required this.controller,
      // required this.validator,
      required this.text,
      required this.validator,
      required this.width});

  @override
  State<custemFieldforProductPage> createState() =>
      custemFieldforProductPageState();
}

class custemFieldforProductPageState extends State<custemFieldforProductPage> {
  List<String> listCurrecncy = [
    "141".tr,
    "142".tr,
    "143".tr,
  ];

  static String? Currecncy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          widget.text,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 2, 92, 123),
              fontSize: 20,

              // decoration: TextDecoration.underline,
              decorationThickness: 1,
              fontWeight: FontWeight.bold,
              //padding: 10,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              width: widget.width, //350,
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  filled: true, // Set to true to enable filling
                  fillColor: const Color.fromARGB(255, 239, 240, 245),

                  //  fillColor: Color.fromARGB(82, 209, 224, 223),
                  // nice
                  // fillColor: Color.fromARGB(255, 2, 92, 123),

                  // labelText: 'Username'),
                  //  border: OutlineInputBorder(),
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                      fontSize: 15,
                    ),
                  ),

                  // hintStyle:  TextStyle(color: Colors.black, fontSize: 16
                  //google_fonts.hashCode(GoogleFonts()),
                  //  GoogleFonts.aBeeZee,
                  // ),

                  //borderRadius:
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF107086),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 95, 150, 168),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 16), // Adjust the vertical padding
                  //
                ),
                validator: widget.validator,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Visibility(
              visible: widget.text == "price" || widget.text == "110".tr,
              child: ListStateAndCat(
                width1: 120,
                width2: 115,
                item: listCurrecncy
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 92, 123),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                hintText: "140".tr,
                value: Currecncy,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "115".tr;
                  }
                  return null;
                },
                onChanged: (newVal) {
                  setState(() {
                    Currecncy = newVal;
                    //conditionOfFreeProduct = newVal;
                    //selectedType = categoryTypes[valueChoose]![0];
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
/*   ListStateAndCat(
                width1: 80,
                width2: 70,
                item: listProductCondition2
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 92, 123),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                hintText: "114".tr,
                value: productCondition,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "115".tr;
                  }
                  return null;
                },
                onChanged: (newVal) {
                  setState(() {
                    productCondition = newVal;
                    conditionOfFreeProduct = newVal;
                    //selectedType = categoryTypes[valueChoose]![0];
                  });
                },
              ), */