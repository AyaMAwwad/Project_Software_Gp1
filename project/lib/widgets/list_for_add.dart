// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:custom_dropdown/ExpandedListAnimationWidget.dart'
class ListStateAndCat extends StatelessWidget {
  final List<DropdownMenuItem<String>>? item;
  final String hintText;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final double width1;
  final double width2;

  const ListStateAndCat({
    Key? key,
    required this.item,
    required this.hintText,
    required this.value,
    required this.validator,
    required this.onChanged,
    required this.width1,
    required this.width2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                hintText,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    //color: Color.fromARGB(255, 78, 78, 78),
                    fontSize: 15,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: item,
        value: value,
        onChanged: onChanged,
        /*(String? value) {
          setState(() {
            selectedValue = value;
          });
        },*/
        buttonStyleData: ButtonStyleData(
          height: 45,
          width: width1, //350,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            //  fillColor: Color.fromARGB(82, 209, 224, 223),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Color.fromARGB(255, 95, 150, 168),
            ),
            color: const Color.fromARGB(255, 239, 240, 245),
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_circle,
          ),
          iconSize: 23,
          iconEnabledColor: Color.fromARGB(255, 95, 150, 168),
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 160,
          width: width2, //340,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color.fromARGB(255, 239, 240, 245),
          ),
          offset: const Offset(5, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}



/* return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // Apply border radius
        border: Border.all(
            color: Color.fromARGB(255, 95, 150, 168)), // Set border color
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none, // Hide the default border
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            // Change focused border color
            borderRadius: BorderRadius.circular(15), // Apply border radius
          ),
          contentPadding: EdgeInsets.zero,
          // prefixIcon: Icon(Icons.arrow_drop_down_circle_sharp),
        ),
        // Remove the default dropdown icon
        style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 2, 92, 123), // Change text color
            fontSize: 15,
          ),
        ),
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: item,
        validator: validator,
        icon: Icon(
          Icons.arrow_drop_down_circle_sharp,
          color: Color.fromARGB(255, 95, 150, 168),
        ),
      ),
    );*/
 
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListStateAndCat extends StatelessWidget {
  final List<DropdownMenuItem<String>>? item;
  final String hintText;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  ListStateAndCat({
    Key? key,
    required this.item,
    required this.hintText,
    required this.value,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 95, 150, 168),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        hint: Text(hintText),
        dropdownColor: Color.fromARGB(255, 255, 255, 255),
        icon: Icon(
          Icons.arrow_drop_down_circle_sharp,
          color: Color.fromARGB(255, 95, 150, 168),
        ),
        iconSize: 27,
        underline: SizedBox(),
        style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 2, 92, 123),
            fontSize: 15,
          ),
        ),
        isExpanded: true,
        value: value,
        onChanged: (newValue) {
          // Call onChanged callback with the new value
          onChanged?.call(newValue);

          // Validate the new value using the provided validator function
          final error = validator?.call(newValue);

          // If there is an error returned by the validator, handle it accordingly
          if (error != null) {
            // Handle the validation error, such as displaying a message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
            ));
          }
        },
        items: item,
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListStateAndCat extends StatelessWidget {
  final List<DropdownMenuItem<String>>? item;
  final String hintText;
  final String value;
  //final String Function()? validator;
  final String? Function(String?)? validator;
  final void Function(Object?)? onChanged;

  ListStateAndCat({
    super.key,
    //super.key,
    required this.item,
    required this.hintText,
    required this.value,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 95, 150, 168),
          ),
          borderRadius: BorderRadius.circular(15)),
      child: DropdownButton(
        hint: Text(hintText),
        dropdownColor: Color.fromARGB(255, 255, 255, 255),
        icon: Icon(
          Icons.arrow_drop_down_circle_sharp,
          color: Color.fromARGB(255, 95, 150, 168),
        ),
        iconSize: 27,
        underline: SizedBox(),
        style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 2, 92, 123),
            fontSize: 15,
            //fontWeight: FontWeight.bold,

            // decoration: TextDecoration.underline,
            // decorationThickness: 1,
            // fontWeight: FontWeight.bold,
            //padding: 10,
          ),
        ),
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: item,
      ),
    );
  }
}
*/
