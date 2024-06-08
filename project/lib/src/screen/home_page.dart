//import 'dart:html';

// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings

//import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ficonsax/ficonsax.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/adminscreen.dart';
import 'package:project/src/screen/cat_screen.dart';
import 'package:project/src/screen/category_screen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/chat_page.dart';
import 'package:project/src/screen/chat_screen.dart';
import 'package:project/src/screen/currency.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/src/screen/saller_product_page.dart';
import 'package:project/src/screen/security.dart';
import 'package:project/src/screen/settings.dart';
import 'package:project/src/screen/wishlist_page.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_app.dart';
import 'package:project/widgets/search_page.dart';
import 'package:project/widgets/slider.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/widgets/user_profile.dart';
import 'package:project/widgets/delivery_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

String Priceeneww = '';

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  //int _selectedIndex = 0;
  // int _cartCount = 0;

  String selectedCurr = Providercurrency.selectedCurrency;
  static bool isPressTosearch = false;
  static bool isPressTosearchButton = false;
  String firsttname = Login.first_name;
  String lastttname = Login.last_name;
  String emailbefore = Login.Email;

  String imagepath = 'images/icon/userprofile.png';

  //
  List<Product> products = [];
  List<Product> allProducts = [];
  List<Product> productsThisMonth = [];
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
      final List<Product> products = await fetchProductsForAI(Login.idd);
      //commant the fetch of product
      final List<Product> allProducts = await ProductService().fetchProducts();
      //fetchProductsThisMonth
      final List<Product> fetchProductsThisMonth =
          await fetchProductsThisMonthBack();
      setState(() {
        this.products = products;
        this.productsThisMonth = fetchProductsThisMonth;
        this.allProducts = allProducts;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
      // Handle error appropriately
    }
  }

//productItemForVirtical
  Widget productItemForVirtical(Product product) {
    print('productItemForThisMonth Product : ${product}');
    return FutureBuilder<String>(
      future: newproductt(product),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 2, 92, 123)),
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else {
          // Use the fetched price
          String newPrice = snapshot.data!;
          // ibtisam
          String sympolprice = getsymbol(newPrice); // ibtisam
          Priceeneww = newPrice;

          return buildItemForForVirtical(
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
            product.avgRate,
            product.userId,
          );
        }
      },
    );
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
          return CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 2, 92, 123)),
          );
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

          return Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: buildItem(
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
              product.avgRate,

              /// aya
              product.userId,
            ),
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

  functionProductForThisMonth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          productsThisMonth.map((product) => productItem(product)).toList(),
    );
  }

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

  static String convertusd(String priceInILS) {
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
    /* Category(name: '50'.tr, imagePath: 'images/icon/fashion.jpg'),
    Category(name: '51'.tr, imagePath: 'images/icon/books.jpg'),
    Category(name: '52'.tr, imagePath: 'images/icon/game.jpg'),
    Category(name: '53'.tr, imagePath: 'images/icon/vehicles.jpg'),
    Category(name: '54'.tr, imagePath: 'images/icon/furniture.jpg'),
    Category(name: '55'.tr, imagePath: 'images/icon/mobile.jpg'),
    Category(name: '56'.tr, imagePath: 'images/icon/Houseware.jpg'),*/
    Category(
        name: '50'.tr,
        imagePath:
            'images/icon/fasNN.jpg'), //fasNN.jpeg //fasA.jpg //fashionN.jpeg
    Category(name: '51'.tr, imagePath: 'images/icon/booksN.jpeg'), //booksN.jpeg
    Category(name: '52'.tr, imagePath: 'images/icon/xbox.jpeg'), //xbox
    Category(name: '53'.tr, imagePath: 'images/icon/GT.jpg'),
    Category(name: '54'.tr, imagePath: 'images/icon/furNN.jpg'),
    Category(name: '55'.tr, imagePath: 'images/icon/iphN.jpeg'), //smartNew.jpg
    Category(name: '56'.tr, imagePath: 'images/icon/houseN.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(' \n $screenWidth \n \n \n hiiiii');
    double categoryCardWidth = 120.0;
    int maxCategoriesPerRow = (screenWidth / categoryCardWidth).floor();
    print('maxCategoriesPerRow: $maxCategoriesPerRow');
    double containerWidth = MediaQuery.of(context).size.width;

    //
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
              leading: Icon(IconsaxBold.bag,
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
                Get.to(() => SellarPage());
              },
            ),
            //new
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

            // admin ********************

            if (Login.usertypee == 'Admin')
              ListTile(
                leading: Icon(Icons.admin_panel_settings,
                    size: 30, color: Color.fromARGB(255, 2, 92, 123)),
                title: Text(
                  'Admin Dashboard',
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

                  Get.to(() => AdminDashboard());
                },
              ),

            //   },

            // admin ***********************
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SliderPage(), // ********************** slider

                    //  if(kIsWeb)

                    if (containerWidth > 1000)
                      SizedBox(
                        // width: 180,
                        // Row(
                        //        mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        height: 180, // Adjust the height as needed
                        child: buildCategoryRow(categories, context), //],),
                      ),

                    SizedBox(
                      height: 20,
                      //  child:Carousel(),
                    ),
                    //Expanded(child:
                    if (containerWidth < 500)
                      SizedBox(
                        height:
                            180, // Set the height of the category list section
                        // child: Center(  final Map<String, IconData> categoryIcons
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            // SizedBox(height: 16);

                            return buildCategoryCard(
                                categories[index], context);
                            // return Align(alignment: Alignment.center, child:  buildCategoryCard(categories[index], context),);
                          },
                        ),
                        //  ),
                      ),
                    // ibtisam web **************
                    // SizedBox(height: 16),
                    // this month
                    if (MediaQuery.of(context).size.width > 1000)
                      Padding(
                        padding: EdgeInsets.only(right: 1090), //220
                        child: textfunctionThisMonth(),
                      ),
                    if (MediaQuery.of(context).size.width < 700)
                      Padding(
                        padding: EdgeInsets.only(right: 220), //220
                        child: textfunctionThisMonth(),
                      ),
                    SizedBox(height: 16),
                    // productItem(products);
                    // ibtisamproduct(),
                    // SizedBox(height: 50),
                    Center(
                      child: buildBottomForThisMonth(context),
                    ), //openSans
                    SizedBox(height: 16),

                    /////////////////
                    if (MediaQuery.of(context).size.width > 1000)
                      Padding(
                        padding: EdgeInsets.only(right: 530), //190
                        child: textfunction2(),
                      ),
                    // mobile
                    if (MediaQuery.of(context).size.width < 700)
                      Padding(
                        padding: EdgeInsets.only(right: 190), //190
                        child: textfunction2(),
                      ),

                    SizedBox(height: 16),
                    // productItem(products);
                    // ibtisamproduct(),
                    // SizedBox(height: 50),
                    buildBottom(context), //openSans
                    SizedBox(height: 16),
                    if (MediaQuery.of(context).size.width > 1000)
                      Padding(
                        padding: EdgeInsets.only(right: 540), // 190
                        child: textfunction(),
                      ),
                    if (MediaQuery.of(context).size.width < 700)
                      Padding(
                        padding: EdgeInsets.only(right: 190), // 190
                        child: textfunction(),
                      ),
                    SizedBox(height: 16),

                    buildVerticalProduct(context),
                    /*buildNext(namefashion, imagefashion, pricefashion, namegame,
                        imagegame, pricegame),
                    buildNext(nameJumpsuit, imageJumpsuit, priceJumpsuit,
                        nameiphone, imageiphone, pricephone),
                    buildNext(namebluse, imagebluse, pricebluse, nametablet,
                        imagetablet, pricetablet),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ibtisam web ************
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: _onTabSelected,
        // cartCount: _cartCount,
        /* onTabSelected: (index) {
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
        },*/
        //  context: context,
      ),
      /* BottomNavBar(
        selectedMenu: MenuState.home,
      ),*/
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
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
          MaterialPageRoute(builder: (context) => WishlistPage()),
        );
        break;
      case 3:
        CartState().resetCart();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartShop()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserProfile()),
        );
        break;
    }
  }

  static void addItemToCart() {
    CartState().incrementCart();
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
    double containerWidth = MediaQuery.of(context).size.width;

    if (containerWidth < 500) {
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
              Text(
                category.name,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 72, 81, 81),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ibt
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ), //,
      ); // ibt
    } else {
      return // Padding(

          //  padding: const EdgeInsets.all(10.0),
          //  child:
          GestureDetector(
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
            Text(
              category.name,
              // ibt
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ); //,
      // );/

      // end else
    }
  }

// new

  Widget buildCategoryRow(List<Category> categories, BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double categoryCardWidth = 120.0;
          int maxCategoriesPerRow =
              (constraints.maxWidth / categoryCardWidth).floor();
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories.map((category) {
                return Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.symmetric(
                      horizontal: 10), // Adjust the horizontal margin as needed

                  child: buildCategoryCard(category, context),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

// new
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

  // ibtisam web *******

////buildBottomForThisMonth
  Widget buildBottomForThisMonth(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double adjustedWidth = containerWidth; //- 40;
    if (containerWidth > 1000) {
      adjustedWidth = containerWidth - 300;
    }
    //if(MediaQuery.of(context).size.width < 700 )
    return Container(
      width: adjustedWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[functionProductForThisMonth()],
          ),
        ),
      ),
    );
    // else{

    // }
  }
/*Widget buildBottomForThisMonth(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(5.0),
      //  child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              functionProductForThisMonth(),
            ],
          ),
       // ),
      ),
    ),
  );
}*/
/*
  Widget buildBottomForThisMonth(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 16,
            ),
            functionProductForThisMonth(),
          ],
        ),
      ),
    );
  }
*/
/////////////////////////
  ///
// ibtisam web **********

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

  // ibtisam webb ************
  List<Widget> productALL(BuildContext context) {
    List<Widget> rows = [];
    int itemsPerRow = MediaQuery.of(context).size.width > 1000 ? 4 : 2;

    for (int i = 0; i < allProducts.length; i += itemsPerRow) {
      List<Widget> rowChildren = [];

      for (int j = 0; j < itemsPerRow; j++) {
        if (i + j < allProducts.length) {
          rowChildren.add(productItemForVirtical(allProducts[i + j]));
        }
      }

      if (rowChildren.length < itemsPerRow) {
        int emptySlots = itemsPerRow - rowChildren.length;
        List<Widget> centeredRowChildren = [];

        for (int k = 0; k < emptySlots / 2; k++) {
          centeredRowChildren.add(Spacer());
        }

        centeredRowChildren.addAll(rowChildren);

        for (int k = 0; k < emptySlots / 2; k++) {
          centeredRowChildren.add(Spacer());
        }

        // If there's an odd number of empty slots, add one more Spacer at the end
        //   if (emptySlots % 2 != 0) {
        //    centeredRowChildren.add(Spacer());
        //  }

        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: centeredRowChildren,
        ));
      } else {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ));
      }
    }

    return rows;
  }

  /* List<Widget> productALL(BuildContext context) {
    List<Widget> rows = [];
     int itemsPerRow = MediaQuery.of(context).size.width > 1000 ? 3 : 2; 

    for (int i = 0; i < allProducts.length; i += itemsPerRow) { ///2
      List<Widget> rowChildren = [];
      rowChildren.add(productItemForVirtical(allProducts[i]));
      if (i + 1 < allProducts.length) {
        rowChildren.add(productItemForVirtical(allProducts[i + 1]));
      } else {
        rowChildren.add(Expanded(child: Container())); // To balance the row
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center, // spaceEvenly
        children: rowChildren,
      ));
    }
    return rows;
  }
*/

// ibtisam webb ********************

//productItemForVirtical
  Widget buildVerticalProduct(BuildContext context) {
    print('**** in buildVerticalProduct ');
    print(allProducts);
    List<Widget> rows = productALL(context);
    return Column(
      children: rows,
    );
    /* return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: (allProducts.length / 2).ceil(),
        itemBuilder: (context, index) {
          int firstIndex = index * 2;
          int secondIndex = firstIndex + 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (firstIndex < allProducts.length)
                Expanded(
                    child: buildCategoryCard(categories[firstIndex], context)),
              if (secondIndex < allProducts.length)
                Expanded(
                    child: buildCategoryCard(categories[secondIndex], context)),
            ],
          );
        },
      ),
    );*/
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
////buildItemForThisMonth
  Widget buildItemForForVirtical(
      BuildContext context,
      String itemName,
      Map<String, dynamic> imagePath,
      String price,
      int productId,
      String type,
      String description,
      int quantity,
      String delivery,
      String avgRate,

      ///aya
      int userId) {
    List<int> bytes = List<int>.from(imagePath['data']);

    /// aya
    final isSelfProduct = Login.idd == userId;
    ValueNotifier<bool> isInWishlist = ValueNotifier<bool>(false);
    return GestureDetector(
      onTap:

          ///aya
          isSelfProduct
              ? null
              :

              ///
              () {
                  InteractionOfUser(Login.idd, productId, 1, 0, 0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        categoryName: itemName,
                        imagePaths: imagePath,
                        price: price,
                        productid: productId,
                        Typeproduct: type,
                        quantity: quantity,
                        name: itemName,
                        description: description,
                      ),
                    ),
                  );
                },
      child: Card(
        elevation: 1,
        color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          width: 180, // Fixed width
          height: 350, // Fixed height
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.memory(
                  Uint8List.fromList(bytes),
                  width: 170,
                  height: 210,
                  fit: BoxFit.cover,
                ),
              ),
              /*  Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.memory(
                      Uint8List.fromList(bytes),
                      width: 170,
                      height: 210,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: ValueListenableBuilder(
                      valueListenable: isInWishlist,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () async {
                            if (value) {
                              await WishlistPageState.deleteFromWishList(
                                  productId, context);
                            } else {
                              await WishlistPageState.addToWishList(
                                  productId, context);
                            }
                            isInWishlist.value = !isInWishlist.value;
                          },
                          child: Icon(
                            value ? Icons.favorite : Icons.favorite_border,
                            color: value ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),*/
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 2, 46, 82),
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isInWishlist,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () async {
                          if (value) {
                            await WishlistPageState.deleteFromWishList(
                                productId, context);
                          } else {
                            await WishlistPageState.addToWishList(
                                productId, context);
                          }
                          isInWishlist.value = !isInWishlist.value;
                        },
                        child: Icon(
                          value ? Icons.favorite : Icons.favorite_border,
                          color: value
                              ? Colors.red
                              : Color.fromARGB(255, 2, 46, 82),
                          size: 20,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Text(
                price,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Color.fromARGB(255, 66, 66, 66),
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'State: $type',
                style: TextStyle(
                  color: Color.fromARGB(255, 66, 66, 66),
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    child: Visibility(
                      visible: !(avgRate == '0.00'),
                      child: Icon(
                        Icons.star,
                        size: 21,
                        color: Color.fromARGB(255, 244, 203, 20),
                      ),
                    ),
                    onTap: () async {
                      //   OpenChatWithSellar.functionForChar(itemName, context);
                    },
                  ),
                  Text(
                    avgRate == '0.00' ? '' : '$avgRate',
                  ),
                  Spacer(),

                  /// aya
                  Visibility(
                    visible: !isSelfProduct,
                    ////
                    child: GestureDetector(
                      child: Icon(
                        IconsaxBold.messages,
                        size: 21,
                        color: Color.fromARGB(255, 2, 46, 82),
                      ),
                      onTap: () async {
                        OpenChatWithSellar.functionForChar(itemName, context);
                      },
                    ),
                  ),
                  SizedBox(width: 10),

                  Visibility(
                    visible: !isSelfProduct,
                    ////
                    child: GestureDetector(
                      child: Icon(
                        quantity == 0
                            ? Icons.remove_shopping_cart
                            : (type == 'Free' ||
                                    type == 'free' ||
                                    type == 'مجاني')
                                ? Icons.arrow_circle_right_outlined
                                : Icons.shopping_cart_checkout,
                        size: 20,
                        color: Color.fromARGB(255, 2, 46, 82),
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
                                  deliveryOption: delivery!,
                                  productId: productId!,
                                  onPaymentSuccess: () {},
                                );
                              },
                            );
                          } else {
                            //print(_cartCount);

                            HomePageState.InteractionOfUser(
                                Login.idd, productId, 0, 1, 0);
                            RecentSingleProdState.shoppingCartStore(
                                '1', '', itemName, type, description, context);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
      BuildContext context,
      String itemName,
      Map<String, dynamic> imagePath,
      String price,
      int productId,
      String type,
      String description,
      int quantity,
      String delivery,
      String avgRate,
      int userId) {
    List<int> bytes = List<int>.from(imagePath['data']);
    final isSelfProduct = Login.idd == userId;
    ValueNotifier<bool> isInWishlist = ValueNotifier<bool>(false);

    return GestureDetector(
      onTap: isSelfProduct
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    categoryName: itemName,
                    imagePaths: imagePath,
                    price: price,
                    productid: productId,
                    Typeproduct: type,
                    quantity: quantity,
                    name: itemName,
                    description: description,
                  ),
                ),
              );
            },
      child: Container(
        width: 230,
        height: 392,
        child: Card(
          elevation: 4,
          color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.memory(
                        Uint8List.fromList(bytes),
                        width: 210,
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: ValueListenableBuilder(
                        valueListenable: isInWishlist,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              if (value) {
                                await WishlistPageState.deleteFromWishList(
                                    productId, context);
                              } else {
                                await WishlistPageState.addToWishList(
                                    productId, context);
                              }
                              isInWishlist.value = !isInWishlist.value;
                            },
                            child: Icon(
                              value ? Icons.favorite : Icons.favorite_border,
                              color: value ? Colors.red : Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),*/
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.memory(
                    Uint8List.fromList(bytes),
                    width: 210,
                    height: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemName,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 2, 46, 82),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isInWishlist,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () async {
                            if (value) {
                              await WishlistPageState.deleteFromWishList(
                                  productId, context);
                            } else {
                              await WishlistPageState.addToWishList(
                                  productId, context);
                            }
                            isInWishlist.value = !isInWishlist.value;
                          },
                          child: Icon(
                            value ? Icons.favorite : Icons.favorite_border,
                            color: value
                                ? Colors.red
                                : Color.fromARGB(255, 2, 46, 82),
                            size: 20,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'State: $type',
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      child: Visibility(
                        visible: !(avgRate == '0.00'),
                        child: Icon(
                          Icons.star,
                          size: 21,
                          color: Color.fromARGB(255, 244, 203, 20),
                        ),
                      ),
                      onTap: () async {
                        // Rating action
                      },
                    ),
                    Text(
                      avgRate == '0.00' ? '' : '$avgRate',
                    ),
                    Spacer(),
                    Visibility(
                      visible: !isSelfProduct,
                      child: GestureDetector(
                        child: Icon(
                          IconsaxBold.messages,
                          size: 21,
                          color: Color.fromARGB(255, 2, 46, 82),
                        ),
                        onTap: () async {
                          OpenChatWithSellar.functionForChar(itemName, context);
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Visibility(
                      visible: !isSelfProduct,
                      child: GestureDetector(
                        child: Icon(
                          quantity == 0
                              ? Icons.remove_shopping_cart
                              : (type == 'Free' ||
                                      type == 'free' ||
                                      type == 'مجاني')
                                  ? Icons.arrow_circle_right_outlined
                                  : Icons.shopping_cart_checkout,
                          size: 20,
                          color: Color.fromARGB(255, 2, 46, 82),
                        ),
                        onTap: () async {
                          if (quantity != 0) {
                            if (type == 'Free' ||
                                type == 'free' ||
                                type == 'مجاني') {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return DeliveryPage(
                                    isFree: true,
                                    deliveryOption: delivery!,
                                    productId: productId!,
                                    onPaymentSuccess: () {},
                                  );
                                },
                              );
                            } else {
                              HomePageState.InteractionOfUser(
                                  Login.idd, productId, 0, 1, 0);
                              RecentSingleProdState.shoppingCartStore('1', '',
                                  itemName, type, description, context);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*
  Widget buildItem(
      BuildContext context,
      String itemName,
      Map<String, dynamic> imagePath,
      String price,
      int productId,
      String type,
      String description,
      int quantity,
      String delivery,
      String avgRate,

      /// aya
      int userId) {
    List<int> bytes = List<int>.from(imagePath['data']);

    /// aya
    final isSelfProduct = Login.idd == userId;

    /// aya
    return GestureDetector(
      onTap:

          ///aya
          isSelfProduct
              ? null
              :
              ////
              () {
                  // Interaction logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        categoryName: itemName,
                        imagePaths: imagePath,
                        price: price,
                        productid: productId,
                        Typeproduct: type,
                        quantity: quantity,
                        name: itemName,
                        description: description,
                      ),
                    ),
                  );
                },
      child: Container(
        width: 230,
        height: 392,
        child: Card(
          elevation: 4,
          color: Color.fromARGB(255, 244, 242, 245).withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.memory(
                    Uint8List.fromList(bytes),
                    width: 210,
                    height: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 2, 46, 82),
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'State: $type',
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      child: Visibility(
                        visible: !(avgRate == '0.00'),
                        child: Icon(
                          Icons.star,
                          size: 21,
                          color: Color.fromARGB(255, 244, 203, 20),
                        ),
                      ),
                      onTap: () async {
                        // Rating action
                      },
                    ),
                    Text(
                      avgRate == '0.00' ? '' : '$avgRate',
                    ),
                    Spacer(),

                    /// aya
                    Visibility(
                      visible: !isSelfProduct,

                      ///
                      child: GestureDetector(
                        child: Icon(
                          IconsaxBold.messages,
                          size: 21,
                          color: Color.fromARGB(255, 2, 46, 82),
                        ),
                        onTap: () async {
                          OpenChatWithSellar.functionForChar(itemName, context);
                        },
                      ),
                    ),
                    SizedBox(width: 10),

                    /// aya
                    Visibility(
                      visible: !isSelfProduct,
                      /////
                      child: GestureDetector(
                        child: Icon(
                          quantity == 0
                              ? Icons.remove_shopping_cart
                              : (type == 'Free' ||
                                      type == 'free' ||
                                      type == 'مجاني')
                                  ? Icons.arrow_circle_right_outlined
                                  : Icons.shopping_cart_checkout,
                          size: 20,
                          color: Color.fromARGB(255, 2, 46, 82),
                        ),
                        onTap: () async {
                          if (quantity != 0) {
                            if (type == 'Free' ||
                                type == 'free' ||
                                type == 'مجاني') {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return DeliveryPage(
                                    isFree: true,
                                    deliveryOption: delivery!,
                                    productId: productId!,
                                    onPaymentSuccess: () {},
                                  );
                                },
                              );
                            } else {
                              HomePageState.InteractionOfUser(
                                  Login.idd, productId, 0, 1, 0);
                              RecentSingleProdState.shoppingCartStore('1', '',
                                  itemName, type, description, context);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }*/

/*
  Widget buildItem(
      BuildContext context,
      String itemName,
      Map<String, dynamic> imagePath,
      String price,
      int productId,
      String type,
      String description,
      int quantity,
      String delivery,
      String avgRate) {
    List<int> bytes = List<int>.from(imagePath['data']);

    return GestureDetector(
      onTap: () {
        InteractionOfUser(Login.idd, productId, 1, 0, 0);
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
          padding: const EdgeInsets.all(8),
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
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 2, 46, 82),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.green, // Color.fromARGB(255, 66, 66, 66),
                      fontSize: 14,
                    ),
                    //  style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Color.fromARGB(255, 66, 66, 66),
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    'State: $type',
                    style: TextStyle(
                      color: Color.fromARGB(255, 66, 66, 66),
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.star,
                          size: 21,
                          color: Color.fromARGB(255, 244, 203, 20),
                        ),
                        onTap: () async {
                          //   OpenChatWithSellar.functionForChar(itemName, context);
                        },
                      ),
                      Text(
                        avgRate == '0.00' ? '' : '$avgRate',
                      ),
                      SizedBox(
                        width: avgRate == '0.00' ? 140 : 110,
                      ),
                      GestureDetector(
                        child: Icon(
                          IconsaxBold.messages,
                          size: 21,
                          color: Color.fromARGB(255, 2, 46, 82),
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
                          color: Color.fromARGB(255, 2, 46, 82),
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
                              // print(_cartCount);

                              HomePageState.InteractionOfUser(
                                  Login.idd, productId, 0, 1, 0);
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
*/
  // build fixed from tow pictiure in the same row
  Widget fixedbuttom(
    String itemName,
    String imagePath,
    String price, //String type,String description
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
                        // Icons.shopping_cart_checkout,
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
                        // print(_cartCount);

                        // HomePageState.InteractionOfUser(
                        //  Login.idd, productId, 0, 1, 0);
                        RecentSingleProdState.shoppingCartStore(
                            '1',
                            '',
                            itemName,
                            'New',
                            '',
                            context); /////////////// need to update
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

  textfunctionThisMonth() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0), // Adjust the left padding as needed
      child: Text(
        '166'.tr, //displayed goods
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

  ///////////// new  view, addToCart, purchased
  static Future<void> InteractionOfUser(
      int userId, int productId, int view, int addToCart, int purchased) async {
    print(productId);
    final response = await http.put(
      Uri.parse('http://$ip:3000/tradetryst/user/Interaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'userId': userId,
        'productId': productId,
        'view': view,
        'addToCart': addToCart,
        'purchased': purchased,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('interaction of user saved');
    } else {
      print('Failed to save interaction of user');
    }
  }
}

class ProductService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://$ip:3000/tradetryst/home/products'));
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
                  avgRate: data['average_rating'],
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

Future<List<Product>> fetchProductsForAI(int userId) async {
  print('IN fetchProductsForAI ');
  try {
    final response = await http.get(Uri.parse(
        'http://$ip:3000/tradetryst/product/retriveProductHomeRecomendedSystem?userId=$userId'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      print('Response Body: $jsonResponse'); // Print API response

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
                avgRate: data['average_rating'],
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
//for this month

Future<List<Product>> fetchProductsThisMonthBack() async {
  print('IN fetchProductsThisMonth ');
  try {
    final response = await http
        .get(Uri.parse('http://$ip:3000/tradetryst/product/productThisMonth'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      print('Response Body: $jsonResponse'); // Print API response

      List<Product> productThisMonth = jsonResponse
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
                avgRate: data['average_rating'],
                //imageData1: data['image1'],
              ))
          .toList();
      return productThisMonth;
    } else {
      throw Exception(
          'Failed to load products. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching products: $e'); // Print error message
    throw Exception('Failed to load products: $e');
  }
}

Future<String> fetchPriceFromNewProduct(int productId) async {
  http.Response? response;
  try {
    response = await http.get(Uri.parse(
        'http://$ip:3000/tradetryst/productnew/pricenew?id=$productId'));
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
        'http://$ip:3000/tradetryst/productused/usedprice?id=$productId'));
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
  final String currency;
  final String delivery;
  final String avgRate;
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
    required this.avgRate,
  });
}
