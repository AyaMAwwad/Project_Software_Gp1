// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/multiLanguage.dart';
import 'package:project/src/screen/product_page.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';

import 'package:project/widgets/enam.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';
import 'package:project/widgets/user_profile.dart';

class ScreenCategory extends StatefulWidget {
  final Category category;
  ScreenCategory(this.category);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  int selectedIndex = 0;
  var height, width;

  Map<String, List<String>> categoryTypes = {
    'Fashion': [
      'Men',
      'Women',
      'Shoes',
      'Kids',
      'Bags',
      'Clock',
      'Glasses',
    ],
    'Smart devices': [
      'Mobile',
      'Laptop',
      'iPad',
      'AirPods',
      'computer',
      'Watch',
      'TV',
      'speakers',
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
      'Washing ',
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
      'Tables ',
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
      'رفوف الأحذية'
    ],
  };

  Map<String, List<String>> categoryimage = {
    "129".tr: [
      'images/icon/men_back.png',
      'images/icon/wom_back.png',
      'images/icon/shoes_back.png',
      'images/icon/kids_back.png',
      'images/icon/bag_back.png',
      'images/icon/watch_back.png',
      'images/icon/glass1_back.png',
    ],
    "130".tr: [
      'images/icon/iphone_ic.png',
      'images/icon/laptop_ic.png',
      'images/icon/ipad_ic.png',
      'images/icon/airpods_ic.png',
      'images/icon/computer_ic.png',
      'images/icon/appleWat_ic.png',
      'images/icon/tv_ic.png',
      'images/icon/speakers_ic.png',
    ],
    "131".tr: [
      'images/icon/books1.png',
      'images/icon/books6.png',
      'images/icon/books2.png',
      'images/icon/books5.png',
      'images/icon/books3.png',
      'images/icon/books10.png',
      'images/icon/books4.png',
      'images/icon/books7.png',
      'images/icon/books8.png',
      'images/icon/books9.png',
    ],
    "132".tr: [
      'images/icon/games4.png',
      'images/icon/games2.png',
      'images/icon/games3.png',
      'images/icon/games1.png',
      'images/icon/games6.png',
      'images/icon/games5.png',
    ],
    "133".tr: [
      'images/icon/house1.png',
      'images/icon/house2.png',
      'images/icon/house4.png',
      'images/icon/house5.png',
      'images/icon/house6.png',
      'images/icon/house10.png',
      'images/icon/house7.png',
      'images/icon/house8.png',
      'images/icon/house3.png',
      'images/icon/house9.png',
    ],
    "134".tr: [
      'images/icon/vec2.png',
      'images/icon/vec3.png',
      'images/icon/vec4.png',
      'images/icon/vec5.png',
      'images/icon/vec1.png',
    ],
    "135".tr: [
      'images/icon/sofa_ic.png',
      'images/icon/carp_ic.png',
      'images/icon/chair_ic.png',
      'images/icon/table_ic.png',
      'images/icon/bed_ic.png',
      'images/icon/warddr_ic.png',
      'images/icon/cr_ic.png',
      'images/icon/desk_ic.png',
      'images/icon/mir_ic.png',
      'images/icon/lamp_ic.png',
      'images/icon/wall_ic.png',
      'images/icon/shoe_ic.png',
    ],
  };
  late String selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory =
        widget.category.name; // category name need in in parameter
    //selectedType = categoryTypes[selectedCategory]![0];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> categoryTypes2 =
        (MultiLanguage.isEnglish) ? categoryTypes : categoryTypes1;

// ibtisam

    double containerWidth = MediaQuery.of(context).size.width;
    double adjustedWidth = containerWidth - 50;
    if (containerWidth > 1000) {
      adjustedWidth = containerWidth - 300;
    }
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
//////////ibtisam
    int crossAxisCount = 2;
    if (containerWidth > 1000) {
      crossAxisCount = 4;
    }
//////////ibtisam

// ibtisam
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
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustemAppBar(
              text: selectedCategory,
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),

            SearchAppBar(),
            // SizedBox(

            // child:Center(child:SearchAppBar()),
            // ),

            SizedBox(
              height: 30,
              //  child:Carousel(),
            ),
            Center(
                // Center the child
                // alignment: WrapAlignment.center,
                // children: categoryTypes2[selectedCategory]!.map((type) {
                child: Container(
                    /////////////ibtisam
                    alignment: Alignment.center,
                    width: containerWidth > 1000
                        ? containerWidth - 300
                        : containerWidth, //////////ibtisam
                    padding: EdgeInsets.only(bottom: 20),
                    // decoration:
                    //  BoxDecoration(
                    //   color: const Color.fromARGB(255, 254, 247, 255),
                    // ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount, //////////ibtisam
                              childAspectRatio: containerWidth > 1000
                                  ? 1.6
                                  : 1.1, //////////ibtisam
                              mainAxisSpacing: 25,
                            ),
                            shrinkWrap: true,

                            physics: NeverScrollableScrollPhysics(),
                            itemCount: categoryTypes2[selectedCategory]
                                    ?.length ??
                                0, //categoryTypes2[selectedCategory]!.length,
                            itemBuilder: (context, index) {
                              String type = categoryTypes2[selectedCategory]![
                                  index]; //type selected need it
                              String image =
                                  categoryimage[selectedCategory]![index];
                              /* String type = '';
                  String image = '';
                  if (selectedCategory != null &&
                      categoryTypes2[selectedCategory] != null) {
                    type = categoryTypes2[selectedCategory]![index];
                    image = categoryimage[selectedCategory]![index];
                    // Your remaining code for itemBuilder goes here
                  }*/

                              return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                              type, widget.category)),
                                    );
                                  },
                                  child:
                                      // Container(child: Column(
                                      //     mainAxisAlignment: MainAxisAlignment.center,
                                      //     children: [
                                      Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                          //  blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    /* child: Container(
                        width: 50,
                        height: 50,
                        //margin:
                        //  EdgeInsets.symmetric(vertical: 40, horizontal: 38),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color:
                              Color.fromARGB(255, 2, 92, 123).withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),*/

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            width:
                                                80, // Set the desired size of the circle
                                            height:
                                                80, // Set the desired size of the circle
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                colors: [
                                                  // Color.fromARGB(255, 95, 150, 168),
                                                  Color.fromARGB(
                                                      255, 147, 198, 215),
                                                  Color.fromARGB(
                                                      255, 95, 150, 168),
                                                  Color.fromARGB(
                                                      255, 66, 119, 138),
                                                  Color.fromARGB(
                                                      255, 95, 150, 168),
                                                  Color.fromARGB(
                                                      255, 147, 198, 215),
                                                  /* Color.fromARGB(255, 147, 198, 215),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 66, 119, 138),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 147, 198, 215),*/
                                                  // Color.fromARGB(255, 95, 150, 168),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.all(10.0),
                                              //margin: EdgeInsets.symmetric(horizontal: 10),
                                              child: Image.asset(
                                                image,
                                                width: 140, // ibtisam
                                                // width: adjustedWidth,
                                                //height: 30,
                                              ),
                                            ),
                                          ),
                                        ),

                                        /*  ClipOval(
                            child: Container(
                              width: 80, // Set the desired size of the circle
                              height:
                                  80, // Set the desired size of the circle Color.fromARGB(255, 95, 150, 168),
                              color: Color.fromARGB(255, 95, 149, 164),

                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  image,
                                  width: 50,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),*/
                                        Text(
                                          type,
                                          style: GoogleFonts.aDLaMDisplay(
                                            textStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 78, 130, 147),
                                              // Color.fromARGB(255, 4, 51, 67),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // ),
                                    // ),
                                    // )])),
                                  ));
                              // );
                            },
                          )
                        ])))

            // })))),
            //  ),
            //  ] ),/

            /* Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 251, 254),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryTypes[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  String type = categoryTypes[selectedCategory]![index];
                  String image = categoryimage[selectedCategory]![index];

                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(type, widget.category)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 1,
                            //  blurRadius: 6,
                          ),
                        ],
                      ),
                      /* child: Container(
                        width: 50,
                        height: 50,
                        //margin:
                        //  EdgeInsets.symmetric(vertical: 40, horizontal: 38),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color:
                              Color.fromARGB(255, 2, 92, 123).withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),*/

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 80, // Set the desired size of the circle
                              height: 80, // Set the desired size of the circle
                              color: Color.fromARGB(255, 95, 150, 168),

                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  image,
                                  width: 50,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            type,
                            style: GoogleFonts.aDLaMDisplay(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 95, 150, 168),
                                // Color.fromARGB(255, 4, 51, 67),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ),
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      )),
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
      ), /*BottomNavBar(
        selectedMenu: MenuState.home,
      ),*/
    );
  }
}
/*
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/multiLanguage.dart';
import 'package:project/src/screen/product_page.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';

import 'package:project/widgets/enam.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';
import 'package:project/widgets/user_profile.dart';

class ScreenCategory extends StatefulWidget {
  final Category category;
  ScreenCategory(this.category);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  int selectedIndex = 0;
  var height, width;

  Map<String, List<String>> categoryTypes = {
    'Fashion': [
      'Men',
      'Women',
      'Shoes',
      'Kids',
      'Bags',
      'Clock',
      'Glasses',
    ],
    'Smart devices': [
      'Mobile',
      'Laptop',
      'iPad',
      'AirPods',
      'computer',
      'Watch',
      'TV',
      'speakers',
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
      'Washing ',
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
      'Tables ',
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
      'رفوف الأحذية'
    ],
  };

  Map<String, List<String>> categoryimage = {
    "129".tr: [
      'images/icon/men_back.png',
      'images/icon/wom_back.png',
      'images/icon/shoes_back.png',
      'images/icon/kids_back.png',
      'images/icon/bag_back.png',
      'images/icon/watch_back.png',
      'images/icon/glass1_back.png',
    ],
    "130".tr: [
      'images/icon/iphone_ic.png',
      'images/icon/laptop_ic.png',
      'images/icon/ipad_ic.png',
      'images/icon/airpods_ic.png',
      'images/icon/computer_ic.png',
      'images/icon/appleWat_ic.png',
      'images/icon/tv_ic.png',
      'images/icon/speakers_ic.png',
    ],
    "131".tr: [
      'images/icon/books1.png',
      'images/icon/books6.png',
      'images/icon/books2.png',
      'images/icon/books5.png',
      'images/icon/books3.png',
      'images/icon/books10.png',
      'images/icon/books4.png',
      'images/icon/books7.png',
      'images/icon/books8.png',
      'images/icon/books9.png',
    ],
    "132".tr: [
      'images/icon/games4.png',
      'images/icon/games2.png',
      'images/icon/games3.png',
      'images/icon/games1.png',
      'images/icon/games6.png',
      'images/icon/games5.png',
    ],
    "133".tr: [
      'images/icon/house1.png',
      'images/icon/house2.png',
      'images/icon/house4.png',
      'images/icon/house5.png',
      'images/icon/house6.png',
      'images/icon/house10.png',
      'images/icon/house7.png',
      'images/icon/house8.png',
      'images/icon/house3.png',
      'images/icon/house9.png',
    ],
    "134".tr: [
      'images/icon/vec2.png',
      'images/icon/vec3.png',
      'images/icon/vec4.png',
      'images/icon/vec5.png',
      'images/icon/vec1.png',
    ],
    "135".tr: [
      'images/icon/sofa_ic.png',
      'images/icon/carp_ic.png',
      'images/icon/chair_ic.png',
      'images/icon/table_ic.png',
      'images/icon/bed_ic.png',
      'images/icon/warddr_ic.png',
      'images/icon/cr_ic.png',
      'images/icon/desk_ic.png',
      'images/icon/mir_ic.png',
      'images/icon/lamp_ic.png',
      'images/icon/wall_ic.png',
      'images/icon/shoe_ic.png',
    ],
  };
  late String selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory =
        widget.category.name; // category name need in in parameter
    //selectedType = categoryTypes[selectedCategory]![0];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> categoryTypes2 =
        (MultiLanguage.isEnglish) ? categoryTypes : categoryTypes1;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
          child: SingleChildScrollView(
        child: Column(
          children: [
            CustemAppBar(
              text: selectedCategory,
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            SearchAppBar(),
            SizedBox(
              height: 30,
              //  child:Carousel(),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 254, 247, 255),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryTypes2[selectedCategory]?.length ??
                    0, //categoryTypes2[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  String type = categoryTypes2[selectedCategory]![
                      index]; //type selected need it
                  String image = categoryimage[selectedCategory]![index];
                  /* String type = '';
                  String image = '';
                  if (selectedCategory != null &&
                      categoryTypes2[selectedCategory] != null) {
                    type = categoryTypes2[selectedCategory]![index];
                    image = categoryimage[selectedCategory]![index];
                    // Your remaining code for itemBuilder goes here
                  }*/

                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(type, widget.category)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 1,
                            //  blurRadius: 6,
                          ),
                        ],
                      ),
                      /* child: Container(
                        width: 50,
                        height: 50,
                        //margin:
                        //  EdgeInsets.symmetric(vertical: 40, horizontal: 38),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color:
                              Color.fromARGB(255, 2, 92, 123).withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),*/

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 80, // Set the desired size of the circle
                              height: 80, // Set the desired size of the circle
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    // Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 147, 198, 215),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 66, 119, 138),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 147, 198, 215),
                                    /* Color.fromARGB(255, 147, 198, 215),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 66, 119, 138),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 147, 198, 215),*/
                                    // Color.fromARGB(255, 95, 150, 168),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  image,
                                  width: 50,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),

                          /*  ClipOval(
                            child: Container(
                              width: 80, // Set the desired size of the circle
                              height:
                                  80, // Set the desired size of the circle Color.fromARGB(255, 95, 150, 168),
                              color: Color.fromARGB(255, 95, 149, 164),

                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  image,
                                  width: 50,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),*/
                          Text(
                            type,
                            style: GoogleFonts.aDLaMDisplay(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 78, 130, 147),
                                // Color.fromARGB(255, 4, 51, 67),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ),
                    ),
                  );
                },
              ),
            ),

            /* Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 251, 254),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryTypes[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  String type = categoryTypes[selectedCategory]![index];
                  String image = categoryimage[selectedCategory]![index];

                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(type, widget.category)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 1,
                            //  blurRadius: 6,
                          ),
                        ],
                      ),
                      /* child: Container(
                        width: 50,
                        height: 50,
                        //margin:
                        //  EdgeInsets.symmetric(vertical: 40, horizontal: 38),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color:
                              Color.fromARGB(255, 2, 92, 123).withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),*/

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 80, // Set the desired size of the circle
                              height: 80, // Set the desired size of the circle
                              color: Color.fromARGB(255, 95, 150, 168),

                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  image,
                                  width: 50,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            type,
                            style: GoogleFonts.aDLaMDisplay(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 95, 150, 168),
                                // Color.fromARGB(255, 4, 51, 67),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ),
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      )),
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
      ), /*BottomNavBar(
        selectedMenu: MenuState.home,
      ),*/
    );
  }
}
*/
