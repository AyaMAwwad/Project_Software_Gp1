// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, prefer_final_fields, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';

import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/counter_item.dart';

import 'package:project/widgets/list_for_add.dart';
import 'package:project/widgets/textfield_add_prod.dart';

import 'package:project/widgets/user_profile.dart';

class AddProductPageTwo extends StatefulWidget {
  final String name;
  final String category;
  final String state;
  final String description;
  final String type;

  const AddProductPageTwo({
    Key? key,
    required this.name,
    required this.category,
    required this.state,
    required this.description,
    required this.type,
  }) : super(key: key);

  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProductPageTwo> {
  //late File? selectedImage = null;
  late String name;
  late String category;
  late String state;
  late String description;
  late String type;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize state variables with passed data
    name = widget.name;
    category = widget.category;
    state = widget.state;
    description = widget.description;
    type = widget.type;
    Future.delayed(Duration.zero, () {
      if (!_isInitialized) {
        repo.resetCounter(context, 20);
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameContr = TextEditingController();
  TextEditingController descContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  int selectedIndex = 1;
  String? valueChoose;
  String? productCondition;
  String? conditionOfFreeProduct;

  List<File> imagesayyya = [];

  String? valueState;
  String? detailsOfState;

  List listItem = [
    'Fashion',
    'Smart devices',
    'Books',
    'Games',
    'Houseware',
    'Vehicles',
    'Furniture'
  ];

  List ListState = [
    'New',
    'Used',
    'Free',
  ];

  late String text1;
  late String text2;
  late String text3;
  double _minValue = 2; // Minimum warranty period
  double _maxValue = 24; // Maximum warranty period
  double _selectedValue = 6;
  List<String> listProductCondition = [
    'Excellent',
    'Good',
    'Fair',
    'Poor',
  ];
  List<String> listProductCondition1 = [
    'ممتاز',
    'جيد',
    'عادل',
    'فقير',
  ];
  List<String> listProductCondition2 = [];
  double high = 0.0;

  @override
  Widget build(BuildContext context) {
    listProductCondition2 = ("11".tr == 'Add Product')
        ? listProductCondition
        : listProductCondition1;
    if (state == 'New') {
      text1 = 'Warranty period';
      text2 = 'Enter a warranty period';
      text3 = 'Please Enter a warranty period';
      conditionOfFreeProduct = '1';
      high = 10;
    } else if (state == 'Free') {
      text1 = 'State of Free';
      text2 = 'Enter a State [New, Used]';
      text3 = 'Please Enter a State';
      high = 5;
    } else if (state == 'Used') {
      text1 = 'Product condition';
      text2 = 'Entter a product_condition';
      text3 = 'Please Enter a product_condition';
      conditionOfFreeProduct = '1';
      high = 30;
    }
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustemAppBar(
                text: "11".tr,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSecondPageContent(),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "101".tr,
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
                            width: 60,
                          ),
                          CounterItem(
                              count: repo.getCount(context, 20),
                              increment: () {
                                repo.incrementCounter(context, 20);
                              },
                              decrement: () {
                                repo.decrementCounter(context, 20);
                              }),
                          /////////////////////////
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "102".tr,
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
                            width: 50,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 230, 234, 234),
                              minimumSize: Size(90, 40),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            child: Icon(
                              Icons.photo_library,
                              size: 30,
                              color: Color.fromARGB(255, 2, 92, 123),
                            ),
                            onPressed: () {
                              _imagePicker();

                              //  pickImageAyosh();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 350,
                                height: 130, // Specify a fixed height
                                child: imagesayyya.isEmpty
                                    ? Center(
                                        child: Text(
                                          "103".tr,
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 2, 92, 123),
                                              fontSize: 20,
                                              decorationThickness: 1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        padding:
                                            EdgeInsets.zero, // Remove padding
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imagesayyya.length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 2, 92, 123),
                                                    width: 3,
                                                  ),
                                                ),
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                height: 130,
                                                width: 110,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.file(
                                                    imagesayyya[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: -1,
                                                right: 3,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // Delete the image at the current index
                                                    setState(() {
                                                      imagesayyya
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromARGB(
                                                          255, 230, 234, 234),
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Color.fromARGB(
                                                          255, 2, 92, 123),
                                                      size: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: ("11".tr == 'Add Product')
                            ? EdgeInsets.only(left: 260, top: high)
                            : EdgeInsets.only(right: 240, top: high),
                        // padding: EdgeInsets.only(left: 260, top: high),
                        child: Row(
                          children: [
                            Text(
                              "104".tr,
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
                              onPressed: () async {
                                // Navigate to the next page when IconButton is pressed
                                if (_formKey.currentState != null) {
                                  //formKey.currentState!.reset();

                                  if (_formKey.currentState!.validate() &&
                                      imagesayyya
                                          .isNotEmpty && //  images.isNotEmpty
                                      repo.getCount(context, 20) > 0) {
                                    _formKey.currentState!.save();
                                    uploadAyosh(
                                      name,
                                      category,
                                      state,
                                      description,
                                      priceContr.text,
                                      repo.getCount(context, 20),
                                      imagesayyya,
                                      detailsOfState,
                                      type,
                                      conditionOfFreeProduct,
                                    );

                                    /// this true
                                    /* uploadimageAyosh(
                                      name,
                                      category,
                                      state,
                                      description,
                                      priceContr.text,
                                      repo.getCount(context, 20),
                                      imagesayyya,
                                      detailsOfState,
                                      type,
                                      conditionOfFreeProduct,
                                    );
*/
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SuccessDialog(message: "105".tr);
                                      },
                                    );
                                    /* showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BaseDialogWidget(
                                            child: PaymentDialog(
                                              icon: Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromRGBO(
                                                    126, 211, 33, 1),
                                                size: 50,
                                              ),
                                              iconColor: Color.fromRGBO(
                                                  126, 211, 33, 1),
                                              iconSize: 50,
                                              paymentStatus: 'SUCCESSFUL',
                                              message:
                                                  'Thank you for Add Product',
                                              buttonName: 'OK',
                                              onPressButton: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(),
                                                  ),
                                                );
                                                print('On Press!');
                                              },
                                            ),
                                          );
                                        });*/
                                    /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartShop(),
                                      ),
                                    );*/
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                HomePageState.isPressTosearch = false;
                HomePageState.isPressTosearchButton = false;
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
        // context: context,
      ), /*BottomNavBar(
        selectedMenu: MenuState.profile,
      ),*/
    );
  }

  void _imagePicker() async {
    var imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        File imageFile = File(pickedImage
            .path); // Convert the selected image path to a File object
        imagesayyya.add(imageFile);
        // images.add(pickedImage.path); // Add the selected image to the list
      });
    }
  }

  Widget buildSecondPageContent() {
    if (state == 'New' || state == 'جديد') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "106".tr,
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
          SizedBox(height: 10.0),
          Text(
            '${"107".tr} ${_selectedValue.toInt()} ${"108".tr}',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 102, 104, 104),
                fontSize: 18,

                // decoration: TextDecoration.underline,
                decorationThickness: 1,
                //fontWeight: FontWeight.bold,
                //padding: 10,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color.fromARGB(255, 2, 92, 123),
              inactiveTrackColor: Colors.grey,
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0, // Height of the slider track
              thumbColor: Color.fromARGB(255, 2, 92, 123),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayColor:
                  const Color.fromARGB(255, 11, 94, 162).withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Slider(
              value: _selectedValue,
              min: _minValue,
              max: _maxValue,
              divisions: (_maxValue - _minValue).toInt(),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  detailsOfState = value.toString();
                });
              },
            ),
          ),
          Row(
            children: [
              custemFieldforProductPage(
                width: 220,
                hintText: "109".tr,
                controller: priceContr,
                text: "110".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "111".tr;
                  } else if (!isNumeric(value)) {
                    return "112".tr;
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ],
      );
    }

    if (state == 'Used' || state == 'مستعمل') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "113".tr,
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
          SizedBox(height: 10.0),
          ListStateAndCat(
            width1: 350,
            width2: 340,
            item: listProductCondition2
                .map((String item) => DropdownMenuItem<String>(
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
                    ))
                .toList(),
            hintText: "114".tr,
            value: productCondition,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "115".tr;
              }
              return null;
            },
            onChanged: (newVal) {
              setState(() {
                productCondition = newVal;
                detailsOfState = newVal;
                //selectedType = categoryTypes[valueChoose]![0];
              });
            },
          ),
          Row(
            children: [
              custemFieldforProductPage(
                hintText: "109".tr,
                controller: priceContr,
                text: "110".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "111".tr;
                  } else if (!isNumeric(value)) {
                    return "112".tr;
                  } else {
                    return null;
                  }
                },
                width: 220,
              ),
            ],
          ),
        ],
      );
    }

    if (state == 'Free' || state == 'مجاني') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "113".tr,
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
          SizedBox(height: 10.0),
          ListStateAndCat(
            width1: 350,
            width2: 340,
            item: listProductCondition2
                .map((String item) => DropdownMenuItem<String>(
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
                    ))
                .toList(),
            hintText: "114".tr,
            value: productCondition,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "115".tr;
              }
              return null;
            },
            onChanged: (newVal) {
              setState(() {
                productCondition = newVal;
                conditionOfFreeProduct = newVal;
                //selectedType = categoryTypes[valueChoose]![0];
              });
            },
          ),
          SizedBox(height: 20.0),
          Text(
            "116".tr,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                    value: 'New',
                    groupValue: valueState,
                    onChanged: (value) {
                      setState(() {
                        valueState = value.toString();
                        detailsOfState = valueState;
                      });
                    },
                  ),
                  Text(
                    "117".tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'Used',
                    groupValue: valueState,
                    onChanged: (value) {
                      setState(() {
                        valueState = value.toString();
                        detailsOfState = valueState;
                      });
                    },
                  ),
                  Text(
                    "118".tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
    return Container();
  }

/*
  Future<void> uploadimageAyosh(
    String name,
    String category,s
    String state,
    String description,
    String price,
    int quantity,
    List<File> imageA,
    String? details,
    String typeOfCategory,
    String? productFreeCond,
  ) async {
    List<String> imagesName = [];
    List<List<int>> imagesData = [];

    for (File imageFile in imageA) {
      if (imageFile == null) continue;

      //String base64 = base64Encode(imageFile.readAsBytesSync());
      String imageName = imageFile.path.split('/').last;
      List<int> imageData =
          await imageFile.readAsBytes(); // Read binary data of image
      String base64 = base64Encode(imageData);
      imagesData.add(imageData);

      imagesName.add(imageName);
      print(Login.Email);
      print(imageFile);
      // print(base64);
      // print(imageName);
      print(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyya');
      print(imageA);
      print(imagesName);
    }
    print(productFreeCond);
    final url = Uri.parse(
        'http://192.168.0.114:3000/tradetryst/Product/AddProduct'); // Update with your server IP

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<dynamic, dynamic>{
          'email': Login.Email,
          'name': name,
          'category': category,
          'state': state,
          'description': description,
          'price': price,
          'quantity': quantity,
          'image': imagesName,
          'imagedata': imagesData,
          'numberofimage': imageA.length,
          'detailsOfState': details,
          'typeOfCategory': typeOfCategory,
          'productFreeCond': productFreeCond,
          //'phone_number': phone_number,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('upload successful');
        // Navigate to the home page or perform any other actions
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("not upload"),
        ));
        // Invalid email or password
        print('not upload');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to upload.'),
        ));
        // Other error occurred
        print('Failed to upload. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
*/
  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  //////////////////////////////////////////////

  Future<void> uploadAyosh(
    String name,
    String category,
    String state,
    String description,
    String price,
    int quantity,
    List<File> imageA,
    String? details,
    String typeOfCategory,
    String? productFreeCond,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.0.114:3000/tradetryst/Product/AddProduct'),
    );
    /* print('Number of files: ${imageA.length}');
    for (int i = 0; i < imageA.length; i++) {
      print('File $i path: ${imageA[i].path}');
    }*/

    request.fields['email'] = Login.Email;
    request.fields['name'] = name;
    request.fields['category'] = category;
    request.fields['state'] = state;
    request.fields['description'] = description;
    request.fields['price'] = price;
    request.fields['quantity'] = quantity.toString();
    request.fields['numberofimage'] = imageA.length.toString();
    request.fields['detailsOfState'] = details ?? '';
    request.fields['typeOfCategory'] = typeOfCategory;
    request.fields['productFreeCond'] = productFreeCond ?? '';
    request.fields['currency'] = custemFieldforProductPageState.Currecncy!;

    for (int i = 0; i < imageA.length; i++) {
      var stream = http.ByteStream(
          imageA[i].openRead().cast()); // Convert image to bytes
      var length = await imageA[i].length(); // Get image file length
      var multipartFile = http.MultipartFile(
        'image', // Consider using 'image' here, depends on your server-side implementation
        stream,
        length,
        filename: imageA[i].path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Upload successful');
        // Handle success
      } else {
        print('Upload failed with status: ${response.statusCode}');
        // Handle error
      }
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }
}

class SuccessDialog extends StatelessWidget {
  final String message;

  const SuccessDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Color.fromRGBO(126, 211, 33, 1),
            size: 50,
          ),
          SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Text(
              'OK',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
