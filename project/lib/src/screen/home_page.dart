//import 'dart:html';

// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/cat_screen.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/chat_page.dart';
import 'package:project/src/screen/chat_screen.dart';
import 'package:project/src/screen/currency.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/src/screen/security.dart';
import 'package:project/src/screen/settings.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/delivery_page.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';
import 'package:project/widgets/search_page.dart';
import 'package:project/widgets/slider.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/widgets/user_profile.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

String Priceeneww = '';

class HomePageState extends State<HomePage> {
  String selectedCurr = Providercurrency.selectedCurrency;
  static bool isPressTosearch = false;
  static bool isPressTosearchButton = false;
  String firsttname = Login.first_name;
  String lastttname = Login.last_name;
  String emailbefore = Login.Email;

  String imagepath = 'images/icon/userprofile.png';

  //
  List<Product> products = [];
  static String CategorySelected = '';
  @override
  void initState() {
    super.initState();
    FirebaseNotification.getDiveceToken();
    fetchProducts();

    //
    if (PrivacySecurity.Delete == 'delete') {
      setState(() {
        // Update the image path if the condition is met
        imagepath = 'images/icon/nohuman.png'; // New image path
      });
    }
  }

  Future<void> fetchProducts() async {
    try {
      final List<Product> products = await ProductService().fetchProducts();
      setState(() {
        this.products = products;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
      // Handle error appropriately
    }
  }

  Widget productItem(Product product) {
    print('Product Name: ${product.name}\n');
    print('Product price : ${product.price}\n');

    print('Product id: ${product.productId}\n');
    print('Product id: ${product.product_type}\n');

//product.price = await  newproductt(product);
/*String rrr =  newproductt(product) ;
  
  return buildItem(
          context,
          product.name,
          product.imageData,
          'Price: \$${rrr}',
          product.productId,
        );
      }*/
    return FutureBuilder<String>(
      future: newproductt(product),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else {
          // Use the fetched price
          String newPrice = snapshot.data!;
          // ibtisam
          String sympolprice = getsymbol(newPrice); // ibtisam
          Priceeneww = newPrice;
          print('Priceenew:::: $Priceeneww\n');

          return buildItem(
            context,
            product.name,
            product.imageData,
            // 'Price: \$${newPrice}',  // ibtisam
            sympolprice,
            product.productId,
            product.product_type,
            product.description,
            product.quantity,
            product.delivery,
          );
        }
      },
    );
  }

  String getsymbol(String price) {
    String sympol = '';
    switch (selectedCurr) {
      case 'USD':
        sympol = '\$';
        break;
      case 'DIN':
        sympol = 'JOD';
        break;
      case 'ILS':
        sympol = '₪';
        break;

      default:
        sympol = '';

      //return
    }
    return 'Price: $sympol$price';
  }

  ///
  //product.price = newproductt(product); // Debug print // Debug print// Debug print
  /*
    return buildItem(
      context,
      product.name,
      product.imageData ,
      'Price: \$${product.price}',
      product.productId,
    );
  }

*/

  ibtisamproduct() {
    return Row(
      children: products.map((product) => productItem(product)).toList(),
    );
  }

/*
  Future<String> newproductt(Product product) async {
    String productType = product.product_type;
    // If product is new, fetch price from New_Product table
    if (productType == 'new' || productType == 'New' || productType == 'جديد') {
      return await fetchPriceFromNewProduct(product.productId);
    } else if (productType == 'used' || productType == 'مستعمل') {
      return await fetchPriceFromusedProduct(product.productId);
      //return product.price; // Return original price fetchPriceFromusedProduct
    } else {
      return product.price;
    }
  }*/
  Future<String> newproductt(Product product) async {
    String productType = product.product_type;
    double conversionRate = 0.3;
    //  double price = double.tryParse(priceInILS) ?? 0.0;

    // If product is new, fetch price from New_Product table
    if (productType == 'new' || productType == 'New' || productType == 'جديد') {
      // ibtisam
      print('\n \n currency ibtisam $selectedCurr \n \n ');
      String priceInILS = await fetchPriceFromNewProduct(product.productId);
      double price = double.tryParse(priceInILS) ?? 0.0;
      print('\n \n currency price $priceInILS \n \n ');
      if (selectedCurr == 'USD') {
        if (product.currency == 'ILS') {
          double convertedPrice = price * conversionRate;
          convertedPrice = price * conversionRate;
          return convertedPrice.toStringAsFixed(2);
        } else if (product.currency == 'DIN') {
          double conversionRateDINToUSD = 0.25;
          double convertedPrice = price * conversionRateDINToUSD;
          return convertedPrice.toStringAsFixed(2);
        } else {
          return price.toStringAsFixed(2);
        }
      } else if (selectedCurr == 'DIN') {
        if (product.currency == 'ILS') {
          return convertdin(priceInILS);
        } else if (product.currency == 'USD') {
          ///
          double conversionRateusdtodin = 0.709;
          double convertedPrice = price * conversionRateusdtodin;
          //  return convertedPrice.toStringAsFixed(2);
          print('\n \n  from usd to din hiiii \n \n ');
          return convertedPrice.toStringAsFixed(2);

          // convertUSDToDIN(priceInILS);

          // price.toStringAsFixed(2);
        } else {
          return price.toStringAsFixed(2);
        }
      } else if (selectedCurr == 'ILS') {
        if (product.currency == 'USD') {
          double conversionRateUSDToILS = 3.25;
          double convertedPrice = price * conversionRateUSDToILS;
          return convertedPrice.toStringAsFixed(2);
        } else if (product.currency == 'DIN') {
          double conversionRateDINToILS = 4.9;
          double convertedPrice = price * conversionRateDINToILS;
          return convertedPrice.toStringAsFixed(2);
        } else {
          return price.toStringAsFixed(2);
        }
      }
      // ibtisam
      //  return await fetchPriceFromNewProduct(product.productId);
/*
    else if (selectedCurr == 'DIN' && product.currency == 'ILS'){
       double conversionRatedin = 0.25;
      double convertedPricedin = price * conversionRatedin;
      return convertedPricedin.toStringAsFixed(2);
    }*/
      else {
        return priceInILS;
      }
    } else if (productType == 'used' ||
        productType == 'مستعمل' ||
        productType == 'Used') {
      //  return await fetchPriceFromusedProduct(product.productId);
      //return product.price; // Return original price fetchPriceFromusedProduct
      String priceInILS = await fetchPriceFromusedProduct(product.productId);

// ibtisam
      double price = double.tryParse(priceInILS) ?? 0.0;
      print('\n \n currency price $priceInILS \n \n ');
      if (selectedCurr == 'USD') {
        if (product.currency == 'ILS') {
          //  double convertedPrice = price * conversionRate;
          //  convertedPrice = price * conversionRate;
          // return convertedPrice.toStringAsFixed(2);
          return convertusd(priceInILS);
        } else if (product.currency == 'DIN') {
          double conversionRateDINToUSD = 0.25;
          double convertedPrice = price * conversionRateDINToUSD;
          return convertedPrice.toStringAsFixed(2);
        } else {
          return price.toStringAsFixed(2);
        }
      } else if (selectedCurr == 'DIN') {
        if (product.currency == 'ILS') {
          return convertdin(priceInILS);
        } else if (product.currency == 'USD') {
          ///
          double conversionRateDINToUSD = 0.709;
          double convertedPrice = price * conversionRateDINToUSD;
          //  return convertedPrice.toStringAsFixed(2);
          print('\n \n  from usd to din hiiii \n \n ');
          return convertedPrice.toStringAsFixed(2);

          // convertUSDToDIN(priceInILS);

          // price.toStringAsFixed(2);
        } else {
          return price.toStringAsFixed(2);
        }
      } else if (selectedCurr == 'ILS') {
        if (product.currency == 'USD') {
          double conversionRateUSDToILS = 3.25;
          double convertedPrice = price * conversionRateUSDToILS;
          return convertedPrice.toStringAsFixed(2);
        } else if (product.currency == 'DIN') {
          double conversionRateDINToILS = 4.9;
          double convertedPrice = price * conversionRateDINToILS;
          return convertedPrice.toStringAsFixed(2);
        } else {
          return price.toStringAsFixed(2);
        }
      }
      /*
    //  if(product.currency == 'ILS'){  //}
           if(selectedCurr == 'USD' && product.currency == 'ILS' ){
        // double convertedPrice = price * conversionRate;
      //  convertedPrice = price * conversionRate;
     //   return convertedPrice.toStringAsFixed(2);
           return convertusd(priceInILS);
      }
     // ibtisam 
    //  return await fetchPriceFromNewProduct(product.productId);

    else if (selectedCurr == 'DIN' && product.currency == 'ILS'){
     //  double conversionRatedin = 0.25;
     // double convertedPricedin = price * conversionRatedin;
     // return convertedPricedin.toStringAsFixed(2);
     return convertdin(priceInILS);
    }*/
      else {
        return priceInILS;
      }

      // ibtisam
    } else {
      return product.price;
    }
  }

// ibtisam

  String convertusd(String priceInILS) {
    double price = double.tryParse(priceInILS) ?? 0.0;

    double conversionRate = 0.3;

    double convertedPrice = price * conversionRate;
    return convertedPrice.toStringAsFixed(2);
  }

  String convertdin(String priceInILS) {
    double price = double.tryParse(priceInILS) ?? 0.0;
    double conversionRatedin = 0.25;
    double convertedPricedin = price * conversionRatedin;
    return convertedPricedin.toStringAsFixed(2);
  }

//
  Widget buildItem33(BuildContext context, String itemName,
      Map<String, dynamic> image, String price) {
    List<int> bytes = List<int>.from(image['data']);

    return GestureDetector(
      onTap: () {
        // Do whatever action you want when the item is tapped
        // For example, show a dialog or navigate to another page
      },
      child: Card(
        elevation: 4,
        color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
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
                child: Image.memory(
                  // Use Image.memory for Uint8List
                  Uint8List.fromList(bytes),
                  width: 200,
                  height: 230,
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
      ),
    );
  }

//
  String pricedata = '';
  int selectedIndex = 0;
  // jumbsute baby boy
  String namefashion = 'Jumpsuit boy';

  String pricefashion = 'Price: \$20.00';

  String imagefashion = 'images/icon/fashionbaby.webp';

  // game baby
  String namegame = 'Game';

  String imagegame = 'images/icon/babygame.jpg';
  //
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
    Category(name: '50'.tr, imagePath: 'images/icon/fashion.jpg'),
    Category(name: '51'.tr, imagePath: 'images/icon/books.jpg'),
    Category(name: '52'.tr, imagePath: 'images/icon/game.jpg'),
    Category(name: '53'.tr, imagePath: 'images/icon/vehicles.jpg'),
    Category(name: '54'.tr, imagePath: 'images/icon/furniture.jpg'),
    Category(name: '55'.tr, imagePath: 'images/icon/mobile.jpg'),
    Category(name: '56'.tr, imagePath: 'images/icon/Houseware.jpg'),
  ];

  //
  @override
  Widget build(BuildContext context) {
    print('*************** in Home ');
    print(isPressTosearch);
    print('*************** isPressTosearchButton');
    print(isPressTosearchButton);
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
    // bool isSearching = false;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 246, 254),
      drawer: Drawer(
        //child: CustemAppBar(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('$firsttname $lastttname'),
              accountEmail: Text('$emailbefore'),
              currentAccountPicture: CircleAvatar(
                radius: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    imagepath,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 2, 92, 123),
              ),
            ),

/*
UserAccountsDrawerHeader(
  accountName: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$firsttname $lastttname',
        style: TextStyle(
          fontSize: 18, // Adjust the font size of the account name
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10), // Adjust the height of the SizedBox
    ],
  ),
  accountEmail: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$emailbefore',
        style: TextStyle(
          fontSize: 18, // Adjust the font size of the account email
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10), // Adjust the height of the SizedBox
    ],
  ),
  currentAccountPicture: Column(
    crossAxisAlignment: CrossAxisAlignment.center, // Adjusted the crossAxisAlignment to center
    children: [
      CircleAvatar(
        radius: 60, // Reduce the radius of the CircleAvatar
        child: ClipOval(
          child: Image.asset(
            'images/icon/userprofile.png',
            fit: BoxFit.cover, // Ensure the image covers the entire circular area
          ),
        ),
      ),
      SizedBox(height: 10), // Adjust the height of the SizedBox
    ],
  ),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 2, 92, 123),
  ),
),
*/
//
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.account_circle,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                '8'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    //   color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
            ), // SettingsPage
            Visibility(
              visible: isPressTosearch || isPressTosearchButton,
              child: ListTile(
                  leading: Icon(Icons.arrow_back_ios_new,
                      size: 24, color: Color.fromARGB(255, 2, 92, 123)),
                  title: Text(
                    "137".tr,
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontSize: 18,
                        //  color: Color.fromARGB(255, 2, 92, 123),
                      ),
                    ),
                  ),
                  onTap: () => {
                        isPressTosearch = false,
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                        // Navigator.pop(context),
                      } //print('Notifications'),
                  ),
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                '62'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    // color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () //async
                  {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsPage()),
                // );
                Get.to(() => SettingsPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits_outlined,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                '144'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    //  color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () {
                Get.to(() => NotificationPage());
              },
            ),
            //new
            ListTile(
              leading: Icon(Icons.notifications,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                '61'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    //  color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () {
                Get.to(() => NotificationPage());
              },
            ),
            // new
            ListTile(
              leading: Icon(Icons.monetization_on,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                'Select Currency',
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    // color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () //async
                  {
                // Navigator.pushReplacement(
                //  context,
                //  MaterialPageRoute(builder: (context) => currency()),
                // );

                Get.to(() => currency());
              },
            ),
            ListTile(
              leading: Icon(Icons.logout,
                  size: 30, color: Color.fromARGB(255, 2, 92, 123)),
              title: Text(
                '60'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 18,
                    //  color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),

        /*
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),*/
      ),

      //appBar: buildAppBar(context),

      body: SafeArea(
        //SingleChildScrollView(
        child: ListView(
          //padding: EdgeInsets.all(8),

          children: [
            CustemAppBar(
              text:
                  isPressTosearch || isPressTosearchButton ? '136'.tr : '59'.tr,
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            SearchAppBar(),
            //    SearchAppBar(onSearchPressed: handleSearchPressed),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            Visibility(
              visible: isPressTosearch,
              child: Container(
                //color: const Color.fromARGB(255, 224, 223, 225),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Text(
                        '139'.tr,
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 92, 123),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 2, 92, 123)
                                  .withOpacity(0.05),
                              offset: Offset(1, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            SearchAppBar.ListRecentSearch.map((searchTerm) {
                          return GestureDetector(
                            onTap: () async {
                              await SearchAppBar.searchbyName(
                                  context, searchTerm);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 231, 231),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 2, 92,
                                      123), // Choose your border color
                                  width: 1, // Choose your border width
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    searchTerm,
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                        color: Color.fromARGB(255, 2, 92, 123),
                                        fontSize: 13,

                                        // decoration: TextDecoration.underline,
                                        decorationThickness: 1,
                                        fontWeight: FontWeight.bold,
                                        //padding: 10,
                                      ),
                                    ), /*TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),*/
                                  ),
                                  SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      // Delete the image at the current index
                                      setState(() {
                                        SearchAppBar.ListRecentSearch.remove(
                                            searchTerm);
                                      });
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 232, 231, 231),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Color.fromARGB(255, 2, 92, 123),
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isPressTosearchButton, //&& !isPressTosearch,
              child: Container(
                // padding: EdgeInsets.only(bottom: 10),
                color: const Color.fromARGB(255, 254, 247, 255),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SearchPage(
                  allProductDataForSearch: SearchAppBar.allProductDataForSearch,
                  allProductDetailsForSearch:
                      SearchAppBar.allProductDetailsForSearch,
                ),
              ),
            ),
            Visibility(
              visible: !isPressTosearch && !isPressTosearchButton,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SliderPage(),
                  SizedBox(
                    height: 10,
                    //  child:Carousel(),
                  ),
                  //Expanded(child:
                  SizedBox(
                    height: 180, // Set the height of the category list section
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        // SizedBox(height: 16);

                        return buildCategoryCard(categories[index], context);
                      },
                    ),
                  ),
                  // ),
                  // SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(right: 170),
                    child: textfunction2(),
                  ),

                  SizedBox(height: 16),
                  // productItem(products);
                  // ibtisamproduct(),
                  // SizedBox(height: 50),
                  buildBottom(context), //openSans
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(right: 190),
                    child: textfunction(),
                  ),

                  SizedBox(height: 16),
                  buildNext(namefashion, imagefashion, pricefashion, namegame,
                      imagegame, pricegame),
                  buildNext(nameJumpsuit, imageJumpsuit, priceJumpsuit,
                      nameiphone, imageiphone, pricephone),
                  buildNext(namebluse, imagebluse, pricebluse, nametablet,
                      imagetablet, pricetablet),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                isPressTosearchButton = false;
                isPressTosearch = false;
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
      /* BottomNavBar(
        selectedMenu: MenuState.home,
      ),*/
    );
  }

  AppBar buildAppBar(context) {
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
/*
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
*/
        // SizedBox(width: kDefaultPaddin /2,)
      ],

      //  title: Text('Home Page'),
    );
  }

  // card with catogery
  Widget buildCategoryCard(Category category, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          CategorySelected = category.name;
          // Navigate to a new page when the image is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScreenCategory(category)),
          );
        },
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
      ),
    );
  }

  Widget buildBottomSection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
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
  ///

  Widget buildBottom(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 16,
            ),

            ibtisamproduct(),
            // SizedBox(width: 5),

            // ibtisamproduct(),

            /*
          products.map<Widget>((product) {
         
          return buildItem(
              context,
              product['name'],
              //[Uint8List.fromList(product['image'])], // Assuming 'image' is the key for the image URL
               [ product['image']], 
              'Price: \$${product['price']}',
            );
            }).toList(),
           
           */

            /*
            
            buildItem(
                context, 'shoes', ['images/icon/shoes.jpg'], 'Price: \$80.00'),
            buildItem(context, 'Iphone', ['images/icon/iphone.webp'],
                'Price: \$200.00'),
            buildItem(
                context,
                'CAR',
                [
                  'images/icon/carxv.png',
                  'images/icon/car11.png',
                  'images/icon/car12.png',
                  'images/icon/car13.png',
                ],
                'Price: \$900.00'),
            buildItem(
                context,
                'CLOCK',
                ['images/icon/clockhand.jpeg', 'images/icon/clockhand2.jpeg'],
                'Price: \$200.00'),*/
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
  ///
  ///

  Widget buildItem(
      BuildContext context,
      String itemName,
      Map<String, dynamic> imagePath,
      String price,
      int productId,
      String type,
      String description,
      int quantity,
      String delivery) {
    List<int> bytes = List<int>.from(imagePath['data']);

    return GestureDetector(
      onTap: () {
        // Navigate to the new page here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              categoryName: itemName,
              imagePaths: imagePath,
              price: price,
              productid: productId,
              Typeproduct: type, quantity: quantity, name: itemName,
              description: description,
              //'lib/icon/tablet.jpg',
              //'lib/icon/fashion.jpg',
              //  ] ,// dots: [DotInfo(left: 50, top: 100
            ),
//DotInfo(left: 150, top: 200),],),
          ),
        );
      },
      child: Card(
        elevation: 4,
        color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: // Image.asset(
                    // imagePath[0],
                    Image.memory(
                  // Use Image.memory for Uint8List
                  Uint8List.fromList(bytes),
                  width: 210,
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
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                      ),
                      GestureDetector(
                        child: Icon(
                          IconsaxBold.messages,
                          size: 21,
                          color: Color.fromARGB(255, 2, 92, 123),
                        ),
                        onTap: () async {
                          OpenChatWithSellar.functionForChar(itemName, context);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: Icon(
                          quantity == 0
                              ? Icons.remove_shopping_cart
                              : (type == 'Free' ||
                                      type == 'free' ||
                                      type == 'مجاني')
                                  ? Icons.arrow_circle_right_outlined
                                  : Icons.shopping_cart_checkout,
                          //FontAwesomeIcons.cartShopping,
                          size: 20,
                          color: Color.fromARGB(255, 2, 92, 123),
                        ),
                        onTap: () async {
                          if (quantity != 0) {
                            if (type == 'Free' ||
                                type == 'free' ||
                                type == 'مجاني') {
                              print('********* the state:$type');
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return DeliveryPage(
                                    isFree: true,
                                    deliveryOption: delivery,
                                    productId: productId,
                                    onPaymentSuccess: () {},
                                  );
                                },
                              );
                              // DeliveryPage(isFree: true);
                            } else {
                              RecentSingleProdState.shoppingCartStore(
                                  '1', '', itemName, type, description);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  /*  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      GestureDetector(
                        child: Icon(
                          FontAwesomeIcons.facebookMessenger,
                          size: 18,
                          color: Color.fromARGB(255, 2, 92, 123),
                        ),
                        onTap: () async {
                          OpenChatWithSellar.functionForChar(itemName, context);
                        },
                      ),
                    ],
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // build fixed from tow pictiure in the same row
  Widget fixedbuttom(
    String itemName,
    String imagePath,
    String price, //String type,String description
    // int quantity,
  ) {
    return Card(
      elevation: 4,
      color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
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
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    GestureDetector(
                      child: Icon(
                        IconsaxBold.messages,
                        size: 21,
                        color: Color.fromARGB(255, 2, 92, 123),
                      ),
                      onTap: () async {
                        OpenChatWithSellar.functionForChar(itemName, context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Icon(
                        (RecentProd.thestate == 'Free' ||
                                RecentProd.thestate == 'free' ||
                                RecentProd.thestate == 'مجاني')
                            ? Icons.arrow_circle_right_outlined
                            : Icons.shopping_cart_checkout,
                        // Icons.shopping_cart_checkout,
                        //FontAwesomeIcons.cartShopping,
                        size: 20,
                        color: Color.fromARGB(255, 2, 92, 123),
                      ),
                      onTap: () async {
                        RecentSingleProdState.shoppingCartStore('1', '',
                            itemName, 'New', ''); /////////////// need to update
                      },
                    ),
                  ],
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
        '57'.tr, //displayed goods
        style: GoogleFonts.aBeeZee(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 2, 92, 123),
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Color.fromARGB(255, 69, 123, 141),
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
        '58'.tr, //displayed goods
        style: GoogleFonts.aBeeZee(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 2, 92, 123),
          shadows: [
            Shadow(
              blurRadius: 4.0,
              color: Color.fromARGB(255, 69, 123, 141),
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.0.114:3000/tradetryst/home/products'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        print('Response Body: $jsonResponse'); // Print API response
        //var pricedata;
/*
 List<Product> products = [];
        for (var data in jsonResponse) {
          // Check product type
          String productType = data['product_type'];
          // If product is new, fetch price from New_Product table
          String price = productType == 'new' ? await fetchPriceFromNewProduct(data['product_id']) : data['price'];
          
          products.add(Product(
            productId: data['product_id'],
            name: data['name'],
            description: data['description'],
            price: price,
            quantity: data['quantity'],
            categoryId: data['category_id'],
            userId: data['user_id'],
            imageData: data['image'], // Assuming 'image' is a Uint8List
          ));
        }*/

        List<Product> products = jsonResponse
            .map((data) => Product(
                  productId: data['product_id'],
                  name: data['name'],
                  description: data['description'],
                  price: Priceeneww, //data['price'],
                  // price: pricedata,
                  product_type: data['product_type'],
                  quantity: data['quantity'],
                  categoryId: data['category_id'],
                  userId: data['user_id'],
                  imageData: data['image'],
                  currency: data['currency'],
                  delivery: data['Delivery_option'],
                  //imageData1: data['image1'],
                ))
            .toList();
        return products;
      } else {
        throw Exception(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e'); // Print error message
      throw Exception('Failed to load products: $e');
    }
  }
}

Future<String> fetchPriceFromNewProduct(int productId) async {
  http.Response? response;
  try {
    response = await http.get(Uri.parse(
        'http://192.168.0.114:3000/tradetryst/productnew/pricenew?id=$productId'));
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      if (responseData is List && responseData.isNotEmpty) {
        // Extract price from the first item in the list
        dynamic firstItem = responseData.first;
        if (firstItem is Map<String, dynamic> &&
            firstItem.containsKey('price')) {
          return firstItem['price'].toString();
        } else {
          throw Exception('Invalid response data format for price');
        }
      } else {
        throw Exception('Empty or invalid response data format for price');
      }
    } else {
      throw Exception(
          'Failed to fetch price for product $productId. Status code: ${response?.statusCode}');
    }
  } catch (e) {
    print('Error: $e, Response body: ${response?.body}');
    throw Exception('Failed to fetch price for product $productId: $e');
  }
}
// used product

Future<String> fetchPriceFromusedProduct(int productId) async {
  http.Response? response;
  try {
    response = await http.get(Uri.parse(
        'http://192.168.0.114:3000/tradetryst/productused/usedprice?id=$productId'));
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      if (responseData is List && responseData.isNotEmpty) {
        // Extract price from the first item in the list
        dynamic firstItem = responseData.first;
        if (firstItem is Map<String, dynamic> &&
            firstItem.containsKey('price')) {
          return firstItem['price'].toString();
        } else {
          throw Exception('Invalid response data format for price');
        }
      } else {
        throw Exception('Empty or invalid response data format for price');
      }
    } else {
      throw Exception(
          'Failed to fetch price for product $productId. Status code: ${response?.statusCode}');
    }
  } catch (e) {
    print('Error: $e, Response body: ${response?.body}');
    throw Exception('Failed to fetch price for product $productId: $e');
  }
}

// end used
class Product {
  final int productId;
  final String name;
  final String description;
  String price;
  final int quantity;
  final int categoryId;
  final int userId;
  final String product_type;
  final Map<String, dynamic> imageData;
  final String currency; //delivery
  final String delivery;
  //final Map<String, dynamic> imageData1;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.categoryId,
    required this.userId,
    required this.imageData,
    required this.product_type,
    required this.currency,
    required this.delivery,
  });
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
