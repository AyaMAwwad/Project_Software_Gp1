import 'dart:typed_data';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/open_chat_with_sellar.dart';
import 'package:project/src/screen/wishlist_page.dart';
import 'package:project/widgets/delivery_page.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_page.dart';

class FindSimilarPage extends StatefulWidget {
  final String price;
  final String name;
  final Map<String, dynamic> image;
  final String currency;

  final List<Map<String, dynamic>> similarProducts;
  final List<Map<String, dynamic>> similarProductDetails;

  FindSimilarPage({
    required this.similarProducts,
    required this.similarProductDetails,
    required this.price,
    required this.name,
    required this.image,
    required this.currency,
  });

  @override
  _FindSimilarPageState createState() => _FindSimilarPageState();
}

class _FindSimilarPageState extends State<FindSimilarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String price = widget.price;
    String curr = widget.currency;
    String Uprice = SearchPage.priceprosearch(price, curr); // price 8
    //
    String sympolP = SearchPage.getsymbol(Uprice);
    List<int> bytes = List<int>.from(widget.image['data']);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Color.fromARGB(255, 2, 46, 82),
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 65.0),
          child: Text(
            'Find Similar',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 2, 46, 82),
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
      /* appBar: AppBar(
        title: Text('Find Similar'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.memory(
                    Uint8List.fromList(bytes),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 46, 82),
                        ),
                      ),
                      Text(
                        '${sympolP.split(":")[1]}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.6,
                ),
                itemCount: widget.similarProducts.length,
                itemBuilder: (context, index) {
                  var similarProduct = widget.similarProducts[index];
                  var similarDetails = widget.similarProductDetails[index];
                  return SimilarProductCard(
                    product: similarProduct,
                    details: similarDetails,
                    onTap: () {
                      HomePageState.InteractionOfUser(
                          Login.idd, similarProduct['product_id'], 1, 0, 0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            categoryName: similarProduct['name'],
                            imagePaths: similarProduct['image'],
                            price: similarDetails['price'],
                            productid: similarProduct['product_id'],
                            Typeproduct: similarProduct['product_type'],
                            quantity: similarProduct['quantity'],
                            name: similarProduct['name'],
                            description: similarProduct['description'],
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
    );
  }
}

class SimilarProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> details;
  final VoidCallback onTap;

  SimilarProductCard({
    required this.product,
    required this.details,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    dynamic yy = '0.00';

    String curr = '';
    dynamic price = '0.00';
    final Map<String, dynamic> imageData = product['image'];
    List<int> bytes = List<int>.from(imageData['data']);
    String theState = product['product_type'];
    String filed = '';
    String theVal = '';

    if (theState == 'New' || theState == 'new' || theState == 'جديد') {
      price = details['price'].toString();
      filed = 'Warranty period';
      theVal = details['warranty_period'].toString();
      //
      curr = product['currency']; // price 8
      yy = price;
      print('\n \ny: $yy \n');
    } else if (theState == 'Used' ||
        theState == 'used' ||
        theState == 'مستعمل') {
      price = details['price'].toString();
      filed = 'condition';
      theVal = details['product_condition'];
      //ibt
      curr = product['currency']; // price 8
    } else if (theState == 'Free' ||
        theState == 'free' ||
        theState == 'مجاني') {
      price = 'Free, ' + 'Type: ${details['state_free']}';
      filed = 'condition';
      theVal = details['product_condition'];
      // ibt
      curr = product['currency']; // price 8
    }
    String updatedPrice = SearchPage.priceprosearch(price, curr); // price 8
    //
    String sympolprice = SearchPage.getsymbol(updatedPrice);
    final isSelfProduct = Login.idd == product['user_id'];
    ValueNotifier<bool> isInWishlist = ValueNotifier<bool>(false);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.memory(
                Uint8List.fromList(bytes),
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 2, 46, 82),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: isInWishlist,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              if (value) {
                                await WishlistPageState.deleteFromWishList(
                                    product['product_id'], context);
                              } else {
                                await WishlistPageState.addToWishList(
                                    product['product_id'], context);
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
                    '$sympolprice', // price 8

                    style: TextStyle(
                      color: Colors.green,
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
                  SizedBox(height: 3.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: Visibility(
                              visible: !(product['average_rating'] == '0.00'),
                              child: Icon(
                                Icons.star,
                                size: 21,
                                color: Color.fromARGB(255, 244, 203, 20),
                              ),
                            ),
                            onTap: () async {},
                          ),
                          Text(
                            product['average_rating'] == '0.00'
                                ? ''
                                : product['average_rating'],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// aya
                          Visibility(
                            visible: !isSelfProduct,
                            //////
                            child: GestureDetector(
                              child: Icon(
                                IconsaxBold.messages,
                                size: 18,
                                color: Color.fromARGB(255, 2, 92, 123),
                              ),
                              onTap: () async {
                                OpenChatWithSellar.functionForChar(
                                    product['name'], context);
                              },
                            ),
                          ),
                          SizedBox(width: 10),

                          /// aya
                          Visibility(
                            visible: !isSelfProduct,

                            ///
                            child: GestureDetector(
                              child: Icon(
                                product['quantity'] == 0
                                    ? Icons.remove_shopping_cart
                                    : (theState == 'Free' ||
                                            theState == 'free' ||
                                            theState == 'مجاني')
                                        ? Icons.arrow_circle_right_outlined
                                        : Icons.shopping_cart_checkout,
                                // Icons.shopping_cart_checkout,
                                size: 14,
                                color: Color.fromARGB(255, 2, 92, 123),
                              ),
                              onTap: () async {
                                if (product['quantity'] != 0) {
                                  if (theState == 'Free' ||
                                      theState == 'free' ||
                                      theState == 'مجاني') {
                                    print('********* the state:$theState');
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return DeliveryPage(
                                          isFree: true,
                                          deliveryOption:
                                              product['Delivery_option'],
                                          productId: product['product_id'],
                                          onPaymentSuccess: () {},
                                        );
                                      },
                                    );
                                    // DeliveryPage(isFree: true);
                                  } else {
                                    HomePageState.InteractionOfUser(Login.idd,
                                        product['product_id'], 0, 1, 0);
                                    await RecentSingleProdState
                                        .shoppingCartStore(
                                            '1',
                                            '',
                                            product['name'],
                                            theState,
                                            product['description'],
                                            context);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Product SOLD OUT\nCan not add Item to Shoppimg Card",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.redAccent,
                                  ));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
