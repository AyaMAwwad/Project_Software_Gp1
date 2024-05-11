import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:provider/provider.dart';

class currency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Providercurrency>(
      // Wrap the currency widget with ChangeNotifierProvider
      create: (context) =>
          Providercurrency(), // Provide an instance of Providercurrency
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 95, 150, 168),
          elevation: 40,
          title: Text(
            'Select Currency',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Choose the currency you want to deal with',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    CurrencyButton(
                      label: 'USD',
                      onPressed: () => setCurrency(context, 'USD'),
                    ),
                    SizedBox(height: 20),
                    CurrencyButton(
                      label: 'DIN',
                      onPressed: () => setCurrency(context, 'DIN'),
                    ),
                    SizedBox(height: 20),
                    CurrencyButton(
                      label: 'ILS',
                      onPressed: () => setCurrency(context, 'ILS'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void setCurrency(BuildContext context, String currencyCode) {
    Provider.of<Providercurrency>(context, listen: false)
        .setCurrency(currencyCode);

    // Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomePage()), // Replace HomePage with your actual home page widget
    );
  }
}

class CurrencyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CurrencyButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 41, 70, 80),
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
