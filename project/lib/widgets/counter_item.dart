import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterItem extends StatefulWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final String? Function(String?)? validator;
  const CounterItem({
    Key? key,
    required this.count,
    required this.increment,
    required this.decrement,
    this.validator,
  });

  @override
  CounterItemState createState() => CounterItemState();
}

class CounterItemState extends State<CounterItem> {
  String? _errorText;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
        width: 60,
        decoration: BoxDecoration(
          color: active
              ? Color.fromARGB(255, 95, 150, 168)
              : const Color.fromARGB(255, 211, 211, 211),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
        child: Icon(
          icon,
          color: active
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}

CounterRepo repo = CounterRepo();

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

  resetCounter(BuildContext context, int index) {
    SharedAppData.setValue(context, "count-$index", 0);
  }
}
