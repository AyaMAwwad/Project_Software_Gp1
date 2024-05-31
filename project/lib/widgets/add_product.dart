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
import 'package:get/get.dart';
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
    'Furniture',
    'Vehicles',
    'Houseware',
  ];
  List<String> listItem1 = [
    'الموضة',
    'الأجهزة الذكية',
    'كتب',
    'ألعاب',
    'أثاث',
    'مركبات',
    'أدوات منزلية',
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
  final Map<String, List<String>> categoryTypes1 = {
    /*'الموضة',
    'الأجهزة الذكية',
    'كتب',
    'ألعاب',
    'أدوات منزلية',
    'مركبات',
    'أثاث'*/
    'الموضة': ['رجال', 'نساء', 'أحذية', 'أطفال', 'حقائب', 'ساعات', 'نظارات'],
    'الأجهزة الذكية': [
      'هاتف',
      'حاسوب محمول',
      'ايباد',
      'سماعات',
      'حاسوب',
      'ساعات ذكية',
      'تلفاز',
      'مكبر صوت'
    ],
    'كتب': [
      'ألغاز',
      'دينية',
      'إثارة وتشويق',
      'تاريخ',
      'مساعدة ذاتية',
      'فلسفة',
      'شعر',
      'دراما',
      'طبخ',
      'صحة',
    ],
    'ألعاب': [
      'بلايستيشن',
      'إكس بوكس',
      'سكوتر',
      'أحذية تزلج',
      'نظارات الواقع الإفتراضي',
      'سماعات الراس',
    ],
    'أدوات منزلية': [
      'روبوت التنظيف',
      'مكنسة كهربائية',
      'مقلاة هوائية',
      'ثلاجة',
      'غسالة',
      'جلاية',
      'فرن',
      'أدوات كهربائية',
      'مرطب الجو ',
      'ألة القهوة'
    ],
    'مركبات': [
      'سيارات',
      'سيارات كهربائية',
      'دراجات نارية',
      'دراجات',
      'سيارة تجارية'
    ],
    'أثاث': [
      'الأرائك',
      'سجاد',
      'كراسي',
      'طاولة',
      'سرير',
      'خزانة',
      'خزائن المطبح',
      'مكاتب',
      'مرايا',
      'مصابيح',
      'جداريات',
      'رفوف الأحذية',
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
  List<String> ListState1 = [
    'جديد',
    'مستعمل',
    'مجاني',
  ];

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> listItem2 = ("11".tr == 'Add Product') ? listItem : listItem1;
    Map<String, List<String>> categoryTypes2 =
        ("11".tr == 'Add Product') ? categoryTypes : categoryTypes1;
    List<String> ListState2 = "11".tr == 'Add Product' ? ListState : ListState1;
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
              CustemAppBar(text: "11".tr //'Add Product',
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
                        "12".tr,
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
                        item: listItem2
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
                        hintText: "13".tr,
                        value: valueChoose, // Set initial value to null
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "14".tr;
                          }
                          return null;
                        },
                        onChanged: (newVal) {
                          setState(() {
                            valueChoose = newVal;
                            selectedType = categoryTypes2[valueChoose]!.first;
                          });
                        },
                        width1: 350,
                        width2: 340,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "15".tr,
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
                        width1: 350,
                        width2: 340,
                        item: selectedType != null
                            ? categoryTypes2[valueChoose!]!
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
                        hintText: "16".tr,
                        value: selectedType,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "17".tr;
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
                        "18".tr,
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
                        width1: 350,
                        width2: 340,
                        item: ListState2.map(
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
                        hintText: "19".tr,
                        value: valueState,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "20".tr;
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
                        hintText: "21".tr,
                        controller: nameContr,
                        text: "22".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "23".tr;
                          }
                          final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
                          /* if (!regex.hasMatch(value)) {
                            return "24".tr;
                          }
                          return null;*/
                        },
                        width: 342,
                      ),
                      custemFieldforProductPage(
                        width: 342,
                        hintText: "25".tr,
                        controller: descContr,
                        text: "26".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "27".tr;
                          }
                          final RegExp regex =
                              RegExp(r'^[a-zA-Z0-9\s]*[a-zA-Z][a-zA-Z0-9\s]*$');
                          /* if (!regex.hasMatch(value)) {
                            return "28".tr;
                          }
                          return null;*/
                        },
                      ),
                      Padding(
                        padding: ("11".tr == 'Add Product')
                            ? const EdgeInsets.only(left: 260, top: 35)
                            : const EdgeInsets.only(right: 260, top: 35),
                        child: Row(
                          children: [
                            Text(
                              "29".tr,
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
                HomePageState.isPressTosearch = false;
                HomePageState.isPressTosearchButton = false;
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
                CartState().resetCart();
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
