// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, use_key_in_widget_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/add_product_2.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/list_for_add.dart';
import 'package:project/widgets/textfield_add_prod.dart';

import 'package:project/widgets/user_profile.dart';

class AddProduct extends StatefulWidget {
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameContr = TextEditingController();
  TextEditingController descContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  int selectedIndex = 1;
  String? valueChoose;

  String? selectedCategory;
  String? selectedType;

  // String valueChoose = 'Select Category';
  List<String> listItem = [
    'Fashion',
    'Smart devices',
    'Books',
    'Games',
    'Houseware',
    'Vehicles',
    'Furniture'
  ];

  final Map<String, List<String>> categoryTypes = {
    'Fashion': ['Men', 'Women', 'Shoes', 'Kids', 'Bags', 'Clock', 'Glasses'],
    'Smart devices': [
      'Mobile',
      'Laptop',
      'iPad',
      'AirPods',
      'Computer',
      'Watch',
      'TV',
      'Speakers'
    ],
    'Books': [
      'Mystery',
      'Religious',
      'Thriller',
      'History',
      'Self-help',
      'Philosophy',
      'Poetry',
      'Drama',
      'Cook',
      'Health',
    ],
    'Games': [
      'PlayStation',
      'XBox',
      'Scooter',
      'Skate Shoes',
      'VR Headsets',
      'Headsets',
    ],
    'Houseware': [
      'Robot cleaner',
      'Vacuum cleaner',
      'Air fryer',
      'Refrigerator',
      'Washing Machine',
      'Dishwasher',
      'Oven',
      'Electrical Tools',
      'Humidifier',
      'Coffee Machine'
    ],
    'Vehicles': ['Car', 'Electric', 'Motorcycles', 'Bicycles', 'Commercial'],
    'Furniture': [
      'Sofas',
      'Carpets',
      'Chairs',
      'Tables',
      'Beds',
      'Wardrobes',
      'Cabinets',
      'Desks',
      'Mirrors',
      'Lamps',
      'Wall art',
      'Shoe Racks'
    ],
  };

  @override
  void initState() {
    super.initState();
    valueChoose = null;
    selectedType = null;
  }

  String? valueState;
  List<String> ListState = [
    'New',
    'Used',
    'Free',
  ];

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).pushReplacementNamed(
                    "homepagee"); // This will pop the current route (Drawer)
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        // child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustemAppBar(
                text: 'Add Product',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
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
                      ListStateAndCat(
                        item: listItem
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 2, 92, 123),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        hintText: 'Select Category',
                        value: valueChoose, // Set initial value to null
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        onChanged: (newVal) {
                          setState(() {
                            valueChoose = newVal;
                            selectedType = categoryTypes[valueChoose]!.first;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Type',
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
                      ListStateAndCat(
                        item: selectedType != null
                            ? categoryTypes[valueChoose!]!
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 2, 92, 123),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList()
                            : [],
                        hintText: 'Select Type',
                        value: selectedType,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a Type';
                          }
                          return null;
                        },
                        onChanged: (newVal) {
                          setState(() {
                            selectedType = newVal;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'State',
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
                      ListStateAndCat(
                        item: ListState.map(
                            (String item) => DropdownMenuItem<String>(
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
                                )).toList(),
                        hintText: 'Select State',
                        value: valueState,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a state of product';
                          }
                          return null;
                        },
                        onChanged: (newVal) {
                          setState(() {
                            valueState = newVal;
                          });
                        },
                      ),
                      custemFieldforProductPage(
                        hintText: 'Enter Name of Product',
                        controller: nameContr,
                        text: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name of Product';
                          }
                          final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Name must contain only alphabetic characters';
                          }
                          return null;
                        },
                      ),
                      custemFieldforProductPage(
                        hintText: 'Enter Description of Product',
                        controller: descContr,
                        text: 'Description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Description ';
                          }
                          final RegExp regex =
                              RegExp(r'^[a-zA-Z0-9\s]*[a-zA-Z][a-zA-Z0-9\s]*$');
                          if (!regex.hasMatch(value)) {
                            return 'Description must contain alphabetic character';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 260, top: 35),
                        child: Row(
                          children: [
                            Text(
                              'Next',
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
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_outlined,
                                color: Color.fromARGB(255, 2, 92, 123),
                                size: 30,
                              ),
                              onPressed: () {
                                // Navigate to the next page when IconButton is pressed
                                if (_formKey.currentState != null) {
                                  //formKey.currentState!.reset();

                                  if (_formKey.currentState!.validate() &&
                                      valueChoose != null &&
                                      valueState != null) {
                                    _formKey.currentState!.save();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddProductPageTwo(
                                          name: nameContr.text,
                                          category: valueChoose!,
                                          state: valueState!,
                                          description: descContr.text,
                                          type: selectedType!,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        //  ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartShop()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
                break;
            }
          });
        },
        //  context: context,
      ),
    );
  }
}
