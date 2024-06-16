import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/src/screen/find_simialer.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/search_page.dart';
import 'package:project/widgets/user_profile.dart';

class WishlistPage extends StatefulWidget {
  @override
  State<WishlistPage> createState() => WishlistPageState();
}

class WishlistPageState extends State<WishlistPage> {
  static List<Map<String, dynamic>> ProductDataWishList = [];
  static List<Map<String, dynamic>> ProductDetails = [];
  static List<Map<String, dynamic>> productSimilar = [];
  static List<Map<String, dynamic>> productSimilarDetails = [];

  int selectedIndex = 2;
  String selectedCategory = 'Recently added'; // Track selected category

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    await retriveFromWishList();
    setState(() {});
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<List<Map<String, dynamic>>> getFilteredProducts() {
    List<Map<String, dynamic>> filteredProducts = [];
    List<Map<String, dynamic>> filteredDetails = [];

    for (int i = 0; i < ProductDataWishList.length; i++) {
      var product = ProductDataWishList[i];
      var details = ProductDetails[i];

      if (selectedCategory == '168'.tr ||
          product['category_name'] == selectedCategory) {
        filteredProducts.add(product);
        filteredDetails.add(details);
      }
    }

    return [filteredProducts, filteredDetails];
  }

  @override
  Widget build(BuildContext context) {
    List<List<Map<String, dynamic>>> filteredData = getFilteredProducts();
    List<Map<String, dynamic>> filteredProducts = filteredData[0];
    List<Map<String, dynamic>> filteredDetails = filteredData[1];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustemAppBar(
              text: '167'.tr,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...[
                            '168'.tr,
                            '129'.tr,
                            '130'.tr,
                            '131'.tr,
                            '132'.tr,
                            '133'.tr,
                            '134'.tr,
                            '135'.tr,
                          ].map((category) => ListTile(
                                title: Text(
                                  category,
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      color: selectedCategory == category
                                          ? Color.fromARGB(255, 2, 92, 123)
                                          : Color.fromARGB(255, 128, 128, 128),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                tileColor: selectedCategory == category
                                    ? Colors.black.withOpacity(0.1)
                                    : Colors.transparent,
                                onTap: () {
                                  onCategorySelected(category);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  // Main content
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 1,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        var product = filteredProducts[index];
                        var details = filteredDetails[index];
                        return ProductCard(
                          product: product,
                          details: details,
                          onDelete: () async {
                            await WishlistPageState.deleteFromWishList(
                                product['product_id'], context);
                            setState(() {
                              filteredProducts.removeAt(index);
                              filteredDetails.removeAt(index);
                            });
                          },
                          onFindSimilar: () async {
                            await findSimilar(product['product_id'],
                                product['category_type']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindSimilarPage(
                                  similarProducts: productSimilar,
                                  similarProductDetails: productSimilarDetails,
                                  price: details['price'],
                                  name: product['category_type'],
                                  image: product['image'],
                                  currency: product['currency'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
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
          });
        },
      ),
    );
  }

  /* List<Map<String, dynamic>> getFilteredProducts() {
    if (selectedCategory == '168'.tr) {
      return ProductDataWishList;
    } else {
      return ProductDataWishList.where(
          (product) => product['category_name'] == selectedCategory).toList();
    }
  }*/

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustemAppBar(
              text: '167'.tr,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...[
                            '168'.tr,
                            '129'.tr,
                            '130'.tr,
                            '131'.tr,
                            '132'.tr,
                            '133'.tr,
                            '134'.tr,
                            '135'.tr,
                          ].map((category) => ListTile(
                                title: Text(
                                  category,
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      color: selectedCategory == category
                                          ? Color.fromARGB(255, 2, 92, 123)
                                          : Color.fromARGB(255, 128, 128, 128),
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                tileColor: selectedCategory == category
                                    ? Colors.black.withOpacity(0.1)
                                    : Colors.transparent,
                                onTap: () {
                                  onCategorySelected(category);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  // Main content
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 1,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: getFilteredProducts().length,
                      itemBuilder: (context, index) {
                        var product = getFilteredProducts()[index];
                        var details = ProductDetails[index];
                        return ProductCard(
                          product: product,
                          details: details,
                          onDelete: () async {
                            await WishlistPageState.deleteFromWishList(
                                product['product_id'], context);
                            setState(() {
                              ProductDataWishList.removeAt(index);
                              ProductDetails.removeAt(index);
                            });
                          },
                          onFindSimilar: () async {
                            await findSimilar(product['product_id'],
                                product['category_type']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindSimilarPage(
                                  similarProducts: productSimilar,
                                  similarProductDetails: productSimilarDetails,
                                  price: details['price'],
                                  name: product['category_type'],
                                  image: product['image'],
                                  currency: product['currency'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
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
          });
        },
      ),
    );
  }
*/
  static Future<void> addToWishList(
    int peoductId,
    BuildContext context,
  ) async {
    final url = Uri.parse('http://$ip:3000/tradetryst/product/addToWishList');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<dynamic, int>{
          'userId': Login.idd,
          'productId': peoductId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Flushbar(
          message: "This product added to WishList.",
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
        ).show(context);
        print('store to cart  successful');
      } else if (response.statusCode == 401) {
        Flushbar(
          message:
              "This product is already in your WishList and cannot be added again.",
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
        ).show(context);
        print('not store');
      } else {
        Flushbar(
          message:
              "This product is already in your WishList and cannot be added again.",
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
        ).show(context);

        print('failed to store Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<Map<String, dynamic>?> retriveFromWishList() async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/product/retriveFromWishList?userId=${Login.idd}'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('ProductDataWishList') &&
            responseData.containsKey('ProductDetails')) {
          ProductDataWishList = List<Map<String, dynamic>>.from(
              responseData['ProductDataWishList']);
          ProductDetails =
              List<Map<String, dynamic>>.from(responseData['ProductDetails']);
          print(ProductDataWishList);
          print(ProductDetails);
        } else {
          print('Failed to fetch data. ');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: '); //${response?.body}
    }
    return null;
  }

  static Future<Map<String, dynamic>?> deleteFromWishList(
      int productId, BuildContext context) async {
    http.Response? response;

    try {
      response = await http.delete(Uri.parse(
          'http://$ip:3000/tradetryst/product/deleteFromWishList?productId=$productId&userId=${Login.idd}'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Flushbar(
          message: "Deleted from WishList.",
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
        ).show(context);
        print('deleted cart item');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body:');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> findSimilar(
      int productId, String productType) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/product/findSimilar?productId=$productId&productType=$productType'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('productSimilar') &&
            responseData.containsKey('ProductDetails')) {
          productSimilar =
              List<Map<String, dynamic>>.from(responseData['productSimilar']);
          productSimilarDetails =
              List<Map<String, dynamic>>.from(responseData['ProductDetails']);
          print(productSimilar);
          print(productSimilarDetails);
        } else {
          print('Failed to fetch data. ');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: '); //${response?.body}
    }
    return null;
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> details;
  final VoidCallback onDelete;
  final VoidCallback onFindSimilar;

  ProductCard({
    required this.product,
    required this.details,
    required this.onDelete,
    required this.onFindSimilar,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _showOverlay = false;

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product);
    print(widget.details);
    //   print('in _ProductCardState :  ${ widget.product['category_name']}');
    String curr = widget.product['currency'];
    String currprice = (widget.product['product_type'] == 'new' ||
            widget.product['product_type'] == 'used' ||
            widget.product['product_type'] == 'New' ||
            widget.product['product_type'] == 'Used' ||
            widget.product['product_type'] == 'مستعمل' ||
            widget.product['product_type'] == 'جديد')
        ? SearchPage.priceprosearch(widget.details['price'], curr)
        : ' ';

    String thepriceOfProd = (widget.product['product_type'] == 'new' ||
            widget.product['product_type'] == 'used' ||
            widget.product['product_type'] == 'New' ||
            widget.product['product_type'] == 'Used' ||
            widget.product['product_type'] == 'مستعمل' ||
            widget.product['product_type'] == 'جديد')
        ? SearchPage.getsymbol(currprice)
        : ': ${'169'.tr}';
    List<int> bytes = List<int>.from(widget.product['image']['data']);
    return GestureDetector(
      onTap: () {
        setState(() {
          _showOverlay = !_showOverlay;
        });
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.memory(
                    Uint8List.fromList(bytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //${thepriceOfProd.split(":")[1]}
                      "${thepriceOfProd.split(":")[1]}",
                      //    "${widget.details['price']}",
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleOverlay,
                      child: Icon(Icons.more_vert, size: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_showOverlay)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        HomePageState.InteractionOfUser(
                            Login.idd, widget.product['product_id'], 1, 0, 0);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              categoryName: widget.product['name'],
                              imagePaths: widget.product['image'],
                              price:
                                  (widget.product['product_type'] == 'Free' ||
                                          widget.product['product_type'] ==
                                              'free' ||
                                          widget.product['product_type'] ==
                                              'مجاني ')
                                      ? widget.details['product_condition']
                                      : widget.details['price'],
                              productid: widget.product['product_id'],
                              Typeproduct: widget.product['product_type'],
                              quantity: widget.product['quantity'],
                              name: widget.product['name'],
                              description: widget.product['description'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 25),
                        backgroundColor: Color.fromARGB(255, 2, 92, 123),
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0,
                          vertical: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                      ),
                      child: Text(
                        "170".tr,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onFindSimilar();
                        _toggleOverlay();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 25),
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.0,
                          vertical: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                      ),
                      child: Text(
                        "171".tr,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onDelete();
                        _toggleOverlay();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 25),
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                      ),
                      child: Text(
                        "128".tr,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
