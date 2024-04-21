// ignore_for_file: use_super_parameters, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountItem extends StatefulWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final String? Function(String?)? validator;
  // final int index;
  const CountItem({
    Key? key,
    required this.count,
    required this.increment,
    required this.decrement,
    // required this.index,
    this.validator,
  });

  @override
  CountItemState createState() => CountItemState();
}

class CountItemState extends State<CountItem> {
  String? _errorText;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 60,
      height: 27,
      //  padding: EdgeInsets.only(right: 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: Color.fromARGB(255, 2, 46, 82)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCounterButton(
            true,
            Icons.remove_outlined,
            widget.decrement,
            widget.count > 0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              widget.count.toString(),
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  //fontWeight: FontWeight.bold,
                  //padding: 10,
                ),
              ),
            ),
          ),
          _buildCounterButton(false, Icons.add_outlined, widget.increment),
          if (_errorText != null) // Show error message if present
            Text(
              _errorText!,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  InkWell _buildCounterButton(bool left, IconData icon, VoidCallback onTap,
      [bool active = true]) {
    double d1, d2;
    if (icon == Icons.add_outlined) {
      d1 = 7.5;
      d2 = 1;
    } else {
      d1 = 1;
      d2 = 7.5;
    }
    return InkWell(
      onTap: !active
          ? null
          : () {
              // Call validator function if provided
              if (widget.validator != null) {
                final String? error =
                    widget.validator!(widget.count.toString());
                setState(() {
                  _errorText = error; // Set error message
                });
              }
              // Call onTap callback if no error or no validator provided
              if (_errorText == null || widget.validator == null) {
                onTap();
              }
            },
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 4),
        height: 30,
        width: 20,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: Color.fromARGB(255, 2, 46, 82),
                width: 1.0), // Adjust width as needed
            right: BorderSide(
                color: Color.fromARGB(255, 2, 46, 82),
                width: 1.0), // Adjust width as needed
          ),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(d2),
            right: Radius.circular(d1),
          ),
        ),
        child: Icon(
          icon,
          size: 19,
          color: /*active
              ? Color.fromARGB(255, 255, 255, 255)
              :*/
              Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}

CounterRepo repos = CounterRepo();

class CounterRepo {
  int getCount(context, index) {
    return SharedAppData.getValue(context, "count-$index", () => 0);
  }

  incrementCounter(context, index) {
    SharedAppData.setValue(
        context, "count-$index", getCount(context, index) + 1);
  }

  decrementCounter(context, index) {
    SharedAppData.setValue(
        context, "count-$index", getCount(context, index) - 1);
  }
}
