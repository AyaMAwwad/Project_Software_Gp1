// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/ipaddress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/categorylist.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/recent_prod.dart';

class DetailPage extends StatefulWidget {
  final String categoryName;
  final Map<String, dynamic> imagePaths;
  final String price;
  final int productid;
  final String Typeproduct;
  final int quantity;
  final String name;
  final String description;

  DetailPage(
      {required this.categoryName,
      required this.imagePaths,
      required this.price,
      required this.productid,
      required this.Typeproduct,
      required this.quantity,
      required this.name,
      required this.description});
  //Category.name = categoryName;
  String get catoryname => categoryName;
  String get pricename => price;
  int get productid1 => productid;
  String get Typeproduct1 => Typeproduct;

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  int selectedDotIndex = 0;
  int selectedDotIndex1 = 0;

//String name = DetailPage.getname() ;
  late Future<List<Map<String, dynamic>>> _imageDataFuture;
  late String _price;
  late List<Map<String, dynamic>> _imagePaths = []; // Store fetched image paths

  late String _categoryName;

  @override
  void initState() {
    super.initState();
    _price = widget.price;
    _categoryName = widget.categoryName;
    _imageDataFuture = fetchImageData(widget.productid);
    // _imageDataFuture = fetchImageData(widget.productId);
  }

  /////
  Future<List<Map<String, dynamic>>> fetchImageData(int productId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/product/productImages?productId=$productId'));
//?productId=$productId
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> imageList =
            responseData.cast<Map<String, dynamic>>();
        setState(() {
          _imagePaths = imageList;
        });
        //  print({imageList});
        return imageList;
      } else {
        throw Exception('Failed to load product images');
      }
    } catch (e) {
      throw Exception('Failed to fetch product images: $e');
    }
  }

  void selectImage(int index) {
    setState(() {
      selectedDotIndex = index;
    });
  }

  void selectImage1(int index) {
    setState(() {
      selectedDotIndex1 = index;
    });
  }

  ////
  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    List<int> bytes = List<int>.from(
        widget.imagePaths['data']); // Access image data from the map
    List<int> bytes1 = _imagePaths.isNotEmpty
        ? List<int>.from(_imagePaths[selectedDotIndex]['image_data']['data'])
        : [];

//List<int> bytes1 = _imagePaths.isNotEmpty ? List<int>.from((_imagePaths[selectedDotIndex]['image_data']['data'] as List)) : [];
//List<int> bytes1 = _imagePaths.isNotEmpty ? List<int>.from((_imagePaths[selectedDotIndex]['image_data']['data'] as List<dynamic>).cast<int>()) : [];

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
                Navigator.of(context).pushReplacementNamed("homepagee");
              },
            ),
          ],
        ),
      ),
      /*
       appBar: AppBar(
        title: Text(widget.categoryName),
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustemAppBar(
                  text: widget.categoryName,
                ),
                SizedBox(
                  height: 10,
                  //  child:Carousel(),
                ),
                // SearchAppBar(),
                //if (_imagePaths != null && _imagePaths.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child:
                        // Image.asset(
                        //  widget.imagePaths[selectedDotIndex]!,
                        // print('$selectedDotIndex');
                        Image.memory(
                      selectedDotIndex == 0
                          ? Uint8List.fromList(bytes)
                          : Uint8List.fromList(bytes1),
                      // selectedDotIndex == 0 ? Uint8List.fromList(bytes) : (selectedDotIndex1 == 0 ? Uint8List.fromList(bytes1) : Uint8List.fromList(bytes1)),

                      // selectedDotIndex1 == 0 ? Uint8List.fromList(bytes1) : Uint8List.fromList(bytes1),

                      //  selectedDotIndex == 0 ? Uint8List.fromList(bytes) : (selectedDotIndex1 == 0 ? Uint8List.fromList(bytes1) : null),
                      //selectedDotIndex == 0 ? Uint8List.fromList(bytes) : (selectedDotIndex1 == 0 ? Uint8List.fromList(bytes1) : Uint8List(0)),

                      fit: BoxFit.cover,
                      height: 400,
                    ),
                    /*

                      bytes1.isNotEmpty
                        ?   Image.memory( // Use Image.memory for Uint8List
                        // Uint8List.fromList(bytes),// bytes
                      Uint8List.fromList(bytes1),// bytes
                      fit: BoxFit.cover,
                      height: 400,
                    ) : CircularProgressIndicator(),

                      */
                  ),
                ),
                SizedBox(height: 5),
                // Text('hiiiiiiiii'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    //
                    for (int i = 0; i < _imagePaths.length; i++)
                      DotWidget(
                        dotIndex: i,

                        isSelected: selectedDotIndex ==
                            (i == 0
                                ? 0
                                : i), // Adjust isSelected condition based on i

                        onTap: () {
                          selectImage(i);
                        },
                      ),
                  ],

                  /*neww
                  children:[
                     DotWidget(

                       dotIndex: 0,
                      isSelected: true,
                     onTap: () {
                        setState(() {
                       //   selectedDotIndex = index;
                        });
                      },
                     ),


                  ],*/ // neww
                  /* main
                   List.generate(
                    widget.imagePaths.length,
                    (index) => DotWidget(
                      dotIndex: index,
                      isSelected: index == selectedDotIndex,
                      onTap: () {
                        setState(() {
                          selectedDotIndex = index;
                        });
                      },
                    ),
                  ),

                  */
                ),
                SizedBox(height: 5),
                // Row(mainAxisAlignment: MainAxisAlignment.start,
                // children: [

                // textjacket(),

                //   ],

                //Text('hghgghghh'),
                //   ),

                // ***************
                Center(child: textjacket()),
              ],
            ),
          ),
          //Text(),
        ),
      ),
    );
  }

  ///
  textjacket() {
    String rr = widget.catoryname;
    String Price = widget.price;
    int idproduct = widget.productid1;
    String Typeproduct = widget.Typeproduct1;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0), //5
                child: Text(
                  '$rr',
                  style: TextStyle(
                    color: Color.fromARGB(255, 101, 27, 27),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0), //5
                child: Text(
                  'Color same as picture',
                  style: GoogleFonts.aBeeZee(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The $rr is light and sweet',
                  style: GoogleFonts.aBeeZee(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'The $Price ',
                  style: GoogleFonts.aBeeZee(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          buildDetailsRow(" Condition", "$Typeproduct", FontAwesomeIcons.grip),
          buildDetailsRow(
              " Item ID", "$idproduct", FontAwesomeIcons.circleInfo),
          SizedBox(height: 20),
          buybutton(Typeproduct),
          /*
        // Center the button

        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle the button press (buy the item, for example)
            },
            child: Text(
              'Buy Now',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        */
          //
        ],
      ),
    );
  }

  Widget buildDetailsRow(String label, String value, IconData icon) {
    return Container(
      width: 320,
      height: 50,

      ///
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 49, 126, 143)),
        borderRadius: BorderRadius.circular(8),
        // filled: true,
        color: Color.fromARGB(82, 175, 201, 199),
      ),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(icon, color: Color.fromARGB(255, 7, 28, 45)),
          SizedBox(width: 5),
          Text(
            '$label: $value',
            // style: TextStyle(fontSize: 16),
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// buy button
  buybutton(String state) {
    return Center(
      child: CustomeButton(
        onPressed: () async {
          if (widget.quantity != 0) {
            await RecentSingleProdState.shoppingCartStore(
                '1',
                '',
                widget.name,
                state, // theState,
                widget.description,
                context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Product SOLD OUT\nCan not add Item to Shoppimg Card",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
            ));
          }
        },

        // Text('Buy Now'
        //style: Color.white,
        //),
        text: widget.quantity == 0
            ? 'SOLD OUT'
            : (widget.Typeproduct == "Free" ||
                    widget.Typeproduct == "free" ||
                    widget.Typeproduct == "مجاني")
                ? 'Order'
                : 'ADD TO CART',
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}

//
class DotWidget extends StatelessWidget {
  final int dotIndex;
  final bool isSelected;
  final VoidCallback onTap;
  //final List<int> imageData;
  DotWidget({
    required this.dotIndex,
    required this.isSelected,
    required this.onTap,
    // required this.imageData,
  });
  //bool isSelected1 = isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(255, 21, 101, 117) : Colors.grey,
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
        //   child: isSelected && dotIndex == 0 ? Image.memory(Uint8List.fromList(bytes)) : null,
        //  child: isSelected1 = isSelected,
      ),
    );
  }
}
