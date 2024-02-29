//import 'dart:html';

// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/categorylist.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  // jumbsute baby boy
  String namefashion = 'Jumpsuit boy';
  String pricefashion = 'Price: \$20.00';
  String imagefashion = 'images/icon/fashionbaby.webp';
  // game baby
  String namegame = 'Game';
  String imagegame = 'images/icon/babygame.jpg'; //
  String pricegame = 'Price: \$20.00';
  // phone mobile
  String nameiphone = 'Iphone';
  String imageiphone = 'images/icon/iphone.webp';
  String pricephone = 'Price: \$50.00';
  // baby bajama
  String nameJumpsuit = 'Jumpsuit ';
  String imageJumpsuit = 'images/icon/sweetb.jpg';
  String priceJumpsuit = 'Price: \$20.00';
  // Sweatshirt  tablet.jpg
  String namebluse = 'Sweatshirt ';
  String imagebluse = 'images/icon/blusebaby.webp';
  String pricebluse = 'Price: \$30.00';
  // tablet
  String nametablet = 'Tablet ';
  String imagetablet = 'images/icon/galaxy.webp';
  String pricetablet = 'Price: \$100.00';
  final List<Category> categories = [
    Category(name: 'Fashion', imagePath: 'images/icon/fashion.jpg'),
    Category(name: 'Books', imagePath: 'images/icon/books.jpg'),
    Category(name: 'Games', imagePath: 'images/icon/game.jpg'),
    Category(name: 'Vehicles', imagePath: 'images/icon/vehicles.jpg'),
    Category(name: 'Furniture', imagePath: 'images/icon/furniture.jpg'),
    Category(name: 'Smart devices', imagePath: 'images/icon/mobile.jpg'),
    Category(name: 'Houseware', imagePath: 'images/icon/Houseware.jpg'),
  ];

  //
  @override
  Widget build(BuildContext context) {
    /*
     return Scaffold(
    appBar: buildAppBar(
    //  title: Text('Home Page'),
    // body: 
    ),
    body: SingleChildScrollView(
    //  itemCount: categories.length,
     // itemBuilder: (context, index) {
        //return buildCategoryCard(categories[index]);
       // return buildCategoryCard(categories[index]);

      //} ,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) => buildCategoryCard(category)).toList(),
        ),
         
      ),
      

 // body: buildBottomSection(),

      );
     */

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Expanded(child:
            SizedBox(
              height: 180, // Set the height of the category list section
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  // SizedBox(height: 16);

                  return buildCategoryCard(categories[index]);
                },
              ),
            ),
            // ),
            // SizedBox(height: 16),
            textfunction2(),
            SizedBox(height: 16),
            buildBottom(), //openSans
            SizedBox(height: 16),

            textfunction(),
            SizedBox(height: 16),
            buildNext(namefashion, imagefashion, pricefashion, namegame,
                imagegame, pricegame),
            buildNext(nameJumpsuit, imageJumpsuit, priceJumpsuit, nameiphone,
                imageiphone, pricephone),
            buildNext(namebluse, imagebluse, pricebluse, nametablet,
                imagetablet, pricetablet),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // title: Text('Home Page'),
      backgroundColor: Color.fromARGB(255, 230, 240, 243),
      //iconTheme: IconThemeData(color: Colors.white),

      actions: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            //color: Color.fromARGB(255, 2, 92, 123),
            // size: 30,
            //  color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.bell,
            //color: Color.fromARGB(255, 2, 92, 123),
            // size: 30,
            //  color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.message,
            //color: Color.fromARGB(255, 2, 92, 123),
            // size: 30,
            //  color: kTextColor,
          ),
          onPressed: () {},
        ),
        // SizedBox(width: kDefaultPaddin /2,)
      ],

      //  title: Text('Home Page'),
    );
  }

  // card with catogery
  Widget buildCategoryCard(Category category) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ClipRRect
          ClipOval(
            // borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              category.imagePath,
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(category.name),
        ],
      ),
    );
  }

  Widget buildBottomSection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'images/icon/fashion.jpg', // Replace with the actual image path
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Blouse',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Price: \$50.00',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/////////////////////////
  Widget buildBottom() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            buildItem('Jacket', 'images/icon/goat.jpg', 'Price: \$50.00'),
            SizedBox(width: 16),
            buildItem('shoes', 'images/icon/shoes.jpg', 'Price: \$80.00'),
            buildItem('Iphone', 'images/icon/iphone.webp', 'Price: \$200.00'),
          ],
        ),
      ),
    );
  }

  /// for next step
  Widget buildNext(String name1, String image1, String price1, String name2,
      String image2, String price2) {
    return SingleChildScrollView(
      //  physics: NeverScrollableScrollPhysics(),
      // Disable scrolling for this SingleChildScrollView
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            fixedbuttom(name1, image1, price1),
            SizedBox(height: 16),
            fixedbuttom(name2, image2, price2),
            // SizedBox(height: 16),
            // fixedbuttom('shoes', 'lib/assest/shoes.jpg', 'Price: \$80.00'),
            // Add more items...
          ],
        ),
      ),
    );
  }

  ///
  Widget buildItem(String itemName, String imagePath, String price) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imagePath,
                width: 200,
                height: 230, // 200
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // build fixed from tow pictiure in the same row
  Widget fixedbuttom(String itemName, String imagePath, String price) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imagePath,
                width: 150,
                height: 200, // 200
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// function text
  textfunction() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0), // Adjust the left padding as needed
      child: Text(
        'Popular goods', //displayed goods
        style: GoogleFonts.aBeeZee(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 33, 85, 78),
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Color.fromARGB(255, 41, 104, 83),
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  textfunction2() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0), // Adjust the left padding as needed
      child: Text(
        'Displayed goods', //displayed goods
        style: GoogleFonts.aBeeZee(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 8, 86, 75),
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Color.fromARGB(255, 41, 104, 83),
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }
}

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  CoverStateThreeSec createState() => CoverStateThreeSec();
}

class CoverStateThreeSec extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home ',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 2, 92, 123),
              fontSize: 20,

              // decoration: TextDecoration.underline,
              decorationThickness: 1,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('hello'),
        ),
      ),
    );
  }
}
*/
