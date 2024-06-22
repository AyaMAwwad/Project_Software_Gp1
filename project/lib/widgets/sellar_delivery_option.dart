import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/add_product_2.dart';
import 'package:project/widgets/button_2.dart';

class DeliveryOptionsModalContent extends StatefulWidget {
  @override
  DeliveryOptionsModalContentState createState() =>
      DeliveryOptionsModalContentState();
}

class DeliveryOptionsModalContentState
    extends State<DeliveryOptionsModalContent> {
  static late String selectedOption;
  static String? name1;
  static String? category1;
  static String? state1;
  static String? description1;
  static String? price1;
  static int? quantity1;
  static List<File>? imageA1;
  static String? details1;
  static String? typeOfCategory1;
  static String? productFreeCon1;
  static void addProductToDatabase(
      String name,
      String category,
      String state,
      String description,
      String price,
      int quantity,
      List<File> imageA,
      String? details,
      String typeOfCategory,
      String? productFreeCond) {
    name1 = name;
    category1 = category;
    state1 = state;
    description1 = description;
    price1 = price;
    quantity1 = quantity;
    imageA1 = imageA;
    details1 = details;
    typeOfCategory1 = typeOfCategory;
    productFreeCon1 = productFreeCond;
  }

  @override
  void initState() {
    super.initState();
    selectedOption = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Text(
              "145".tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '146'.tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 40, 39, 39),
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            RadioListTile(
              selectedTileColor: Color.fromARGB(255, 2, 92, 123),
              activeColor: Color.fromARGB(255, 2, 92, 123),
              title: Text(
                '147'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 40, 39, 39),
                    fontSize: 16,
                  ),
                ),
              ),
              value: 'seller_delivery',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString();
                });
              },
            ),
            RadioListTile(
              activeColor: Color.fromARGB(255, 2, 92, 123),
              selectedTileColor: Color.fromARGB(255, 2, 92, 123),
              title: Text(
                (state1 == 'Free' || state1 == 'free' || state1 == 'مجاني')
                    ? '148'.tr
                    : '149'.tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 40, 39, 39),
                    fontSize: 16,
                  ),
                ),
              ),
              value: 'system_delivery',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString();
                  print('************ selectedOption : $selectedOption');
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: CustomeButton2(
                text: "125".tr,
                onPressed: () {
                  String deliverOption = (selectedOption == 'system_delivery')
                      ? 'Our Service'
                      : 'Free';
                  print('*********** deliverOption: $deliverOption');
                  AddProductState.uploadAyosh(
                      name1!,
                      category1!,
                      state1!,
                      description1!,
                      price1!,
                      quantity1!,
                      imageA1!,
                      details1,
                      typeOfCategory1!,
                      productFreeCon1,
                      deliverOption);
                  // Navigate to the next page when IconButton is pressed

                  Navigator.pop(context, selectedOption);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccessDialog(message: "105".tr);
                    },
                  );
                },
              ), /*ElevatedButton(
                onPressed: () {
                  // Handle confirmation
                  Navigator.pop(context,
                      _selectedOption); // Close the bottom sheet with selected option
                },
                child: Text('Confirm'),
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}
