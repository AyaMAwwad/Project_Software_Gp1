//import 'dart:html';

// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';
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
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/search_app.dart';
import 'package:project/widgets/slider.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/widgets/user_profile.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

String Priceeneww = '';

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
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
          Priceeneww = newPrice;
          print('Priceenew:::: $Priceeneww\n');

          return buildItem(
            context,
            product.name,
            product.imageData,
            'Price: \$${newPrice}',
            product.productId,
          );
        }
      },
    );
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

  Future<String> newproductt(Product product) async {
    String productType = product.product_type;
    // If product is new, fetch price from New_Product table
    if (productType == 'new') {
      return await fetchPriceFromNewProduct(product.productId);
    } else {
      return product.price; // Return original price
    }
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
      //backgroundColor: Colors.transparent,
      drawer: Drawer(
        //child: CustemAppBar(),
        child: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ),
      //appBar: buildAppBar(context),

      body: SafeArea(
        //SingleChildScrollView(
        child: ListView(
          //padding: EdgeInsets.all(8),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustemAppBar(
              text: 'Home',
            ),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
            SearchAppBar(),
            SizedBox(
              height: 10,
              //  child:Carousel(),
            ),
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
            textfunction2(),
            SizedBox(height: 16),
            // productItem(products);
            // ibtisamproduct(),
            // SizedBox(height: 50),
            buildBottom(context), //openSans
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
        context: context,
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
            SizedBox(width: 16),

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

  Widget buildItem(BuildContext context, String itemName,
      Map<String, dynamic> imagePath, String price, int productId) {
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
                price: '30',
                productid: productId
                //'lib/icon/tablet.jpg',
                //'lib/icon/fashion.jpg',
                //  ] ,// dots: [DotInfo(left: 50, top: 100
                ),
//DotInfo(left: 150, top: 200),],),
          ),
        );
      },
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
                child: // Image.asset(
                    // imagePath[0],
                    Image.memory(
                  // Use Image.memory for Uint8List
                  Uint8List.fromList(bytes),
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
        'Displayed goods', //displayed goods
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
                  imageData: data['image'], // Assuming 'image' is a Uint8List
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