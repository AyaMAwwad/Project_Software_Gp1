// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/button.dart';

class DetailPage extends StatefulWidget {
  final String categoryName;
  final List<String> imagePaths;
  final String price;
  DetailPage(
      {required this.categoryName,
      required this.imagePaths,
      required this.price});
  //Category.name = categoryName;
  String get catoryname => categoryName;
  String get pricename => price;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedDotIndex = 0;
//String name = DetailPage.getname() ;

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        //child: CustemAppBar(),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("homepagee");
              },
            ),
          ],
        ),
      ),
      /*
       appBar: AppBar(
        title: Text(widget.categoryName),
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustemAppBar(
                  text: widget.categoryName,
                ),
                SizedBox(
                  height: 10,
                  //  child:Carousel(),
                ),
                // SearchAppBar(),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      widget.imagePaths[selectedDotIndex],
                      fit: BoxFit.cover,
                      height: 400,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                // Text('hiiiiiiiii'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imagePaths.length,
                    (index) => DotWidget(
                      dotIndex: index,
                      isSelected: index == selectedDotIndex,
                      onTap: () {
                        setState(() {
                          selectedDotIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5),
                // Row(mainAxisAlignment: MainAxisAlignment.start,
                // children: [

                // textjacket(),

                //   ],

                //Text('hghgghghh'),
                //   ),

                // ***************
                Center(child: textjacket()),
              ],
            ),
          ),
          //Text(),
        ),
      ),
    );
  }

  ///
  textjacket() {
    String rr = widget.catoryname;
    String Price = widget.price;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0), //5
                child: Text(
                  '$rr',
                  style: TextStyle(
                    color: Color.fromARGB(255, 101, 27, 27),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0), //5
                child: Text(
                  'Color same as picture',
                  style: GoogleFonts.aBeeZee(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The $rr is light and sweet',
                  style: GoogleFonts.aBeeZee(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The price is::  $Price ',
                  style: GoogleFonts.aBeeZee(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          buildDetailsRow(" Condition", "used", FontAwesomeIcons.grip),
          buildDetailsRow(" Item ID", "7333", FontAwesomeIcons.circleInfo),
          SizedBox(height: 20),
          buybutton(),
          /*
        // Center the button

        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle the button press (buy the item, for example)
            },
            child: Text(
              'Buy Now',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        */
          //
        ],
      ),
    );
  }

  Widget buildDetailsRow(String label, String value, IconData icon) {
    return Container(
      width: 320,
      height: 50,

      ///
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 49, 126, 143)),
        borderRadius: BorderRadius.circular(8),
        // filled: true,
        color: Color.fromARGB(82, 175, 201, 199),
      ),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(icon, color: Color.fromARGB(255, 7, 28, 45)),
          SizedBox(width: 5),
          Text(
            '$label: $value',
            // style: TextStyle(fontSize: 16),
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// buy button
  buybutton() {
    return Center(
      child: CustomeButton(
        onPressed: () {
          //backgroundColor  foregroundColor Handle the button press (buy the item, for example)
        },

        // Text('Buy Now'
        //style: Color.white,
        //),
        text: 'Buy Now', borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}

//
class DotWidget extends StatelessWidget {
  final int dotIndex;
  final bool isSelected;
  final VoidCallback onTap;

  DotWidget({
    required this.dotIndex,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(255, 21, 101, 117) : Colors.grey,
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }
}
/*
buybutton(){
  return  Center(
  child: ElevatedButton(
    onPressed: () {
      //backgroundColor  foregroundColor Handle the button press (buy the item, for example)
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(108, 82, 173, 166),
      foregroundColor: Color.fromARGB(255, 21, 101, 117), // Text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      textStyle: TextStyle(
        //color: color.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    child: Text('Buy Now'
    //style: Color.white,
    ),
  ),
);
}
*/

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/search_app.dart';

class DetailPage extends StatefulWidget {
  final String categoryName;
  final List<String> imagePaths;

  DetailPage({required this.categoryName, required this.imagePaths});
  //Category.name = categoryName;
  String get catoryname => categoryName;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedDotIndex = 0;
//String name = DetailPage.getname() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text(widget.categoryName),
      ),*/
      drawer: Drawer(
        //child: CustemAppBar(),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("homepagee");
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CustemAppBar(
                text: widget.categoryName,
              ),
              SizedBox(
                height: 10,
                //  child:Carousel(),
              ),
              // SearchAppBar(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    widget.imagePaths[selectedDotIndex],
                    fit: BoxFit.cover,
                    height: 400,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Text('hiiiiiiiii'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imagePaths.length,
                  (index) => DotWidget(
                    dotIndex: index,
                    isSelected: index == selectedDotIndex,
                    onTap: () {
                      setState(() {
                        selectedDotIndex = index;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // child: Padding(padding: padding)
                  // Text(''),
                  // Padding(padding: EdgeInsets.all(10),
                  // Text(''),

                  textjacket(),

                  // ),
                ],

                //Text('hghgghghh'),
              ),
            ],
          ),
        ),
      ),
      //Text(),
    );
  }

  ///

  textjacket() {
    String rr = widget.catoryname;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Padding(
          //   padding: EdgeInsets.all(18.0),
          // child: ClipRRect(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '$rr',
                  style: TextStyle(
                    color: Color.fromARGB(255, 101, 27, 27),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'Color same as picture',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'The jacket is light and sweet',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),

          //),
        ],
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final int dotIndex;
  final bool isSelected;
  final VoidCallback onTap;

  DotWidget({
    required this.dotIndex,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey,
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }
}

*/
