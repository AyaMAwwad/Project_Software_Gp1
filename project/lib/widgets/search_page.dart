/// search page login page
/// search page login page

import 'dart:convert';
import 'dart:typed_data';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/delivery_page.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/detailpage.dart';
import 'package:project/src/screen/home_page.dart';
//import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/widgets/recent_prod.dart';

class SearchPage extends StatelessWidget {
  // price 8

  dynamic yy = '0.00';

  String curr = '';
  dynamic price = '0.00';
  // price 8
  final List<Map<String, dynamic>> allProductDataForSearch;
  final List<Map<String, dynamic>> allProductDetailsForSearch;
  static final List<String> listItem = <String>[];
  SearchPage(
      {required this.allProductDataForSearch,
      required this.allProductDetailsForSearch});

  @override
  Widget build(BuildContext context) {
    print(allProductDataForSearch);
    print(allProductDetailsForSearch);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.5,
          ),
          itemCount: allProductDataForSearch.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final productData = allProductDataForSearch[index];
            final productDetails = allProductDetailsForSearch[index];
            String theState = productData['product_type'];

            String filed = '';
            String theVal = '';
            // dynamic price = '0.00'; price 8

            if (theState == 'New' || theState == 'new' || theState == 'جديد') {
              price = productDetails['price'].toString();
              filed = 'Warranty period';
              theVal = productDetails['warranty_period'].toString();
              //
              curr = productData['currency']; // price 8
              yy = price;
              print('\n \ny: $yy \n');
            } else if (theState == 'Used' ||
                theState == 'used' ||
                theState == 'مستعمل') {
              price = productDetails['price'].toString();
              filed = 'condition';
              theVal = productDetails['product_condition'];
              //ibt
              curr = productData['currency']; // price 8
            } else if (theState == 'Free' ||
                theState == 'free' ||
                theState == 'مجاني') {
              price = 'Free, ' + 'Type: ${productDetails['state_free']}';
              filed = 'condition';
              theVal = productDetails['product_condition'];
              // ibt
              curr = productData['currency']; // price 8
            }
            String updatedPrice = priceprosearch(price, curr); // price 8
            //
            String sympolprice = getsymbol(updatedPrice); // price 8
            //
            final Map<String, dynamic> imageData = productData['image'];
            List<int> bytes = List<int>.from(imageData['data']);
            return SingleChildScrollView(
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          categoryName: productData['name'],
                          imagePaths: imageData,
                          price: price,
                          productid: productData['product_id'],
                          Typeproduct: theState,
                          quantity: productData['quantity'],
                          name: productData['name'],
                          description: productData['description'],
                        ),
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                          child: AspectRatio(
                            aspectRatio: 0.65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              /*BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),*/
                              child: Image.memory(
                                Uint8List.fromList(bytes),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        /* Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.memory(
                              Uint8List.fromList(bytes),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),*/
                        /*  ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.memory(
                            Uint8List.fromList(bytes),
                            fit: BoxFit.cover,
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productData['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 2, 46, 82),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // priceprosearch(),
                              Text(
                                // 'Price: $updatedPrice',  // price 8
                                '$sympolprice', // price 8

                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'State: $theState',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '$filed: $theVal',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      IconsaxBold.messages,
                                      size: 18,
                                      color: Color.fromARGB(255, 2, 92, 123),
                                    ),
                                    onTap: () async {
                                      OpenChatWithSellar.functionForChar(
                                          productData['name'], context);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    child: Icon(
                                      productData['quantity'] == 0
                                          ? Icons.remove_shopping_cart
                                          : (theState == 'Free' ||
                                                  theState == 'free' ||
                                                  theState == 'مجاني')
                                              ? Icons
                                                  .arrow_circle_right_outlined
                                              : Icons.shopping_cart_checkout,
                                      // Icons.shopping_cart_checkout,
                                      size: 14,
                                      color: Color.fromARGB(255, 2, 92, 123),
                                    ),
                                    onTap: () async {
                                      if (productData['quantity'] != 0) {
                                        if (theState == 'Free' ||
                                            theState == 'free' ||
                                            theState == 'مجاني') {
                                          print(
                                              '********* the state:$theState');
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return DeliveryPage(
                                                isFree: true,
                                                deliveryOption: productData[
                                                    'Delivery_option'],
                                                productId:
                                                    productData['product_id'],
                                                onPaymentSuccess: () {},
                                              );
                                            },
                                          );
                                          // DeliveryPage(isFree: true);
                                        } else {
                                          await RecentSingleProdState
                                              .shoppingCartStore(
                                                  '1',
                                                  '',
                                                  productData['name'],
                                                  theState,
                                                  productData['description']);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Product SOLD OUT\nCan not add Item to Shoppimg Card",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

// String theState, Map<String, dynamic> productDetails, String price1
  // price 8
  static String priceprosearch(dynamic price1, String curr1) {
    String currency = curr1;
    double r = 0.3;
    double d = 0.25;
    double i = 3.25;
    double j = 4.9;
    double k = 0.709;
    print('\n hh: $price1\n \n \n curr:: $currency \n \n \n ');

    double parsedPrice = price1 is String
        ? double.tryParse(price1) ?? 0.0
        : (price1 as num).toDouble();
    double convertedPrice;

    if (Providercurrency.selectedCurrency == "USD" && currency == "ILS") {
      convertedPrice = parsedPrice * r;
      print('\n hh: $price1\n oo: $convertedPrice\n \n');
    } else if (Providercurrency.selectedCurrency == "USD" &&
        currency == "USD") {
      convertedPrice = parsedPrice;
    } else if (Providercurrency.selectedCurrency == "USD" &&
        currency == "DIN") {
      convertedPrice = parsedPrice * d;
    }
    // select ILS
    else if (Providercurrency.selectedCurrency == "ILS" && currency == "ILS") {
      convertedPrice = parsedPrice;
    } else if (Providercurrency.selectedCurrency == "ILS" &&
        currency == "USD") {
      convertedPrice = parsedPrice * i;
    } else if (Providercurrency.selectedCurrency == "ILS" &&
        currency == "DIN") {
      convertedPrice = parsedPrice * j;
    }
    // select DIN
    else if (Providercurrency.selectedCurrency == "DIN" && currency == "DIN") {
      convertedPrice = parsedPrice;
    } else if (Providercurrency.selectedCurrency == "DIN" &&
        currency == "ILS") {
      convertedPrice = parsedPrice * d;
    } else if (Providercurrency.selectedCurrency == "DIN" &&
        currency == "USD") {
      convertedPrice = parsedPrice * k;
    } else {
      convertedPrice = parsedPrice;
    }
    print('convertedPrice :$convertedPrice');
    return convertedPrice.toStringAsFixed(2);
  }

  static String getsymbol(String price) {
    String sympol = '';
    switch (Providercurrency.selectedCurrency) {
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
        sympol = ' ';

      //return
    }
    return 'Price: $sympol $price';
  }
// price 8

  static Future<Map<String, dynamic>?> serachGet(String name) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/search/retriveWordOfsearch?name=$name'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        print(responseData);

        print('############################################');
        listItem.clear();
        // Iterate over the response data and extract the relevant information
        responseData.forEach((item) {
          // Extract the product name and category name from each item
          String productName = item['product_name'];
          String categoryName = item['category_name']; //category_type
          String categoryType = item['category_type'];
          String categoryDescription = item['product_description'];

          // Convert strings to lowercase
          String productName1 = productName.toLowerCase();
          String categoryName1 = categoryName.toLowerCase();
          String categoryType1 = categoryType.toLowerCase();
          String categoryDescription1 = categoryDescription.toLowerCase();
          print(productName1);
          print(categoryName1);
          print(categoryType1);
          // Check if lowercase version of strings already exists in listItem
          if (!listItem.contains(productName1)) {
            listItem.add(productName1);
          }
          if (!listItem.contains(categoryName1)) {
            listItem.add(categoryName1);
          }
          if (!listItem.contains(categoryType1) &&
                  productName1 !=
                      categoryType1 // && !(listItem.contains(productName1) !=
              //  listItem.contains(categoryType1)
              // )
              ) {
            listItem.add(categoryType1);
          }
          if (!listItem.contains(categoryDescription1)) {
            listItem.add(categoryDescription1);
          }
        });

        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        //print(listItem);
        // searchRetrive = responseData[0];
        // print(searchRetrive);
      } else {
        print('Failed to fetch cart. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: ${response?.body}');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }
}

/*
import 'dart:convert';
import 'dart:typed_data';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project/src/screen/detailpage.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/widgets/delivery_page.dart';
import 'package:project/widgets/recent_prod.dart';

class SearchPage extends StatelessWidget {
  final List<Map<String, dynamic>> allProductDataForSearch;
  final List<Map<String, dynamic>> allProductDetailsForSearch;
  static final List<String> listItem = <String>[];
  SearchPage(
      {required this.allProductDataForSearch,
      required this.allProductDetailsForSearch});

  @override
  Widget build(BuildContext context) {
    print(allProductDataForSearch);
    print(allProductDetailsForSearch);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.5,
          ),
          itemCount: allProductDataForSearch.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final productData = allProductDataForSearch[index];
            final productDetails = allProductDetailsForSearch[index];
            String theState = productData['product_type'];
            String filed = '';
            String theVal = '';
            dynamic price = '0.00';

            if (theState == 'New' || theState == 'new' || theState == 'جديد') {
              price = productDetails['price'].toString();
              filed = 'Warranty period';
              theVal = productDetails['warranty_period'].toString();
            } else if (theState == 'Used' ||
                theState == 'used' ||
                theState == 'مستعمل') {
              price = productDetails['price'].toString();
              filed = 'condition';
              theVal = productDetails['product_condition'];
            } else if (theState == 'Free' ||
                theState == 'free' ||
                theState == 'مجاني') {
              price = 'Free, ' + 'Type: ${productDetails['state_free']}';
              filed = 'condition';
              theVal = productDetails['product_condition'];
            }
            final Map<String, dynamic> imageData = productData['image'];
            List<int> bytes = List<int>.from(imageData['data']);
            return SingleChildScrollView(
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          categoryName: productData['name'],
                          imagePaths: imageData,
                          price: price,
                          productid: productData['product_id'],
                          Typeproduct: theState,
                          quantity: productData['quantity'],
                          name: productData['name'],
                          description: productData['description'],
                        ),
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                          child: AspectRatio(
                            aspectRatio: 0.65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              /*BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),*/
                              child: Image.memory(
                                Uint8List.fromList(bytes),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        /* Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.memory(
                              Uint8List.fromList(bytes),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),*/
                        /*  ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.memory(
                            Uint8List.fromList(bytes),
                            fit: BoxFit.cover,
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productData['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 2, 46, 82),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Price: $price',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'State: $theState',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '$filed: $theVal',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 66, 66, 66),
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      IconsaxBold.messages,
                                      size: 18,
                                      color: Color.fromARGB(255, 2, 92, 123),
                                    ),
                                    onTap: () async {
                                      OpenChatWithSellar.functionForChar(
                                          productData['name'], context);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    child: Icon(
                                      productData['quantity'] == 0
                                          ? Icons.remove_shopping_cart
                                          : (theState == 'Free' ||
                                                  theState == 'free' ||
                                                  theState == 'مجاني')
                                              ? Icons
                                                  .arrow_circle_right_outlined
                                              : Icons.shopping_cart_checkout,
                                      // Icons.shopping_cart_checkout,
                                      size: 14,
                                      color: Color.fromARGB(255, 2, 92, 123),
                                    ),
                                    onTap: () async {
                                      print('********* on tap ');
                                      if (productData['quantity'] != 0) {
                                        if (theState == 'Free' ||
                                            theState == 'free' ||
                                            theState == 'مجاني') {
                                          print(
                                              '********* the state:$theState');
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return DeliveryPage(
                                                isFree: true,
                                                deliveryOption: productData[
                                                    'Delivery_option'],
                                                productId:
                                                    productData['product_id'],
                                                onPaymentSuccess: () {},
                                              );
                                            },
                                          );
                                          // DeliveryPage(isFree: true);
                                        } else {
                                          await RecentSingleProdState
                                              .shoppingCartStore(
                                                  '1',
                                                  '',
                                                  productData['name'],
                                                  theState,
                                                  productData['description']);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Product SOLD OUT\nCan not add Item to Shoppimg Card",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Future<Map<String, dynamic>?> serachGet(String name) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/search/retriveWordOfsearch?name=$name'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        print(responseData);

        print('############################################');
        listItem.clear();
        // Iterate over the response data and extract the relevant information
        responseData.forEach((item) {
          // Extract the product name and category name from each item
          String productName = item['product_name'];
          String categoryName = item['category_name']; //category_type
          String categoryType = item['category_type'];
          String categoryDescription = item['product_description'];

          // Convert strings to lowercase
          String productName1 = productName.toLowerCase();
          String categoryName1 = categoryName.toLowerCase();
          String categoryType1 = categoryType.toLowerCase();
          String categoryDescription1 = categoryDescription.toLowerCase();
          print(productName1);
          print(categoryName1);
          print(categoryType1);
          // Check if lowercase version of strings already exists in listItem
          if (!listItem.contains(productName1)) {
            listItem.add(productName1);
          }
          if (!listItem.contains(categoryName1)) {
            listItem.add(categoryName1);
          }
          if (!listItem.contains(categoryType1) &&
                  productName1 !=
                      categoryType1 // && !(listItem.contains(productName1) !=
              //  listItem.contains(categoryType1)
              // )
              ) {
            listItem.add(categoryType1);
          }
          if (!listItem.contains(categoryDescription1)) {
            listItem.add(categoryDescription1);
          }
        });

        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        //print(listItem);
        // searchRetrive = responseData[0];
        // print(searchRetrive);
      } else {
        print('Failed to fetch cart. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: ${response?.body}');
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }
}
*/