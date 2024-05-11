/// search page login page

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:project/src/screen/detailpage.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
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
                                      FontAwesomeIcons.facebookMessenger,
                                      size: 14,
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
                                          : Icons.shopping_cart_checkout,
                                      // Icons.shopping_cart_checkout,
                                      size: 14,
                                      color: Color.fromARGB(255, 2, 92, 123),
                                    ),
                                    onTap: () async {
                                      if (productData['quantity'] != 0) {
                                        await RecentSingleProdState
                                            .shoppingCartStore(
                                                '1',
                                                '',
                                                productData['name'],
                                                theState,
                                                productData['description']);
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
