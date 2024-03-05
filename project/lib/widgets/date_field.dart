// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  final DateTime? selectedDate;
  DateField({
    required this.controller,
    required this.onTap,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(82, 209, 224, 223),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Color(0xFF063A4E),
          size: 22,
        ),
        hintText: selectedDate == null
            ? 'Select your birthday'
            : DateFormat('yyyy-MM-dd').format(selectedDate!),
        hintStyle: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: selectedDate == null
                ? Color.fromARGB(255, 78, 78, 78)
                : Colors.black,
            fontSize: 16,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF107086),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2679A3)),
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16,
        ),
      ),
      // validator: validPhone,
      onSaved: (String? val) {
        // ignore: avoid_print
        // phone = val!;
      },
      onTap: onTap,
    );
  }
}
