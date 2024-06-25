import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/payment.dart';
import 'package:project/src/screen/providercurrency.dart';
import 'package:project/widgets/button_2.dart';
import 'package:http/http.dart' as http;
import 'package:project/widgets/cart_item.dart';
import 'package:project/widgets/recent_prod.dart';
import 'package:project/widgets/search_page.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/widgets/textfield_add_prod.dart';

class DeliveryPage extends StatefulWidget {
  final bool isFree;
  final String deliveryOption;
  final int productId;
  final VoidCallback onPaymentSuccess;

  const DeliveryPage(
      {super.key,
      required this.isFree,
      required this.deliveryOption,
      required this.productId,
      required this.onPaymentSuccess});
  @override
  DeliveryPageState createState() => DeliveryPageState();
}

class DeliveryPageState extends State<DeliveryPage> {
  ///
  String selectedCurr = Providercurrency.selectedCurrency;
  String prevselectedCurr = 'ILS';
  String symbol = CartItemState.getsymbol();
  static late String selectedOption;
  List<Map<String, dynamic>> deliveryService = [];
  List<Map<String, dynamic>> sellarInfo = [];
  static String? firstNameDelivery;
  static String? lastNameDelivery;
  static String? phoneNumber;
  late Future<void> fetchDeliveryFuture;

  @override
  void initState() {
    super.initState();
    selectedOption = 'Not Selected';
    fetchDeliveryFuture = fetchDelivery();
  }

  Future<void> fetchDelivery() async {
    if (widget.deliveryOption != 'Free' &&
        widget.deliveryOption != 'free' &&
        widget.deliveryOption != 'مجاني') {
      print('***********8 in await getdeliveryEmployee(Delivery employee)');
      await getdeliveryEmployee('Delivery employee');
    } else {
      await getdeliveryFromSellar(widget.productId);
    }
  }

  double totalAmount = CartItemState.amount;
  @override
  Widget build(BuildContext context) {
    print("*****isFree: ${widget.isFree} ");
    print("*****deliveryOption: ${widget.deliveryOption} ");
    print("*****productId: ${widget.productId} ");
    String delivery = SearchPage.priceprosearch(20, prevselectedCurr);
    String Totaldelivery = SearchPage.getsymbol(delivery);
    String priceWithoutDelivery =
        SearchPage.priceprosearch(CartItemState.amount, prevselectedCurr);
    String TotalpriceWithoutDelivery =
        SearchPage.getsymbol(priceWithoutDelivery);
    String priceWithDelivery = SearchPage.priceprosearch(
        CartItemState.amount! + 20.0, prevselectedCurr);
    String TotalpriceWithDelivery = SearchPage.getsymbol(priceWithDelivery);
    TextEditingController nameContr = TextEditingController();

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
              padding: const EdgeInsets.only(bottom: 10),
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
            /* TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.streetAddress,
            ),
            SizedBox(height: 16.0),*/
            /* 
           Row(
              children: [
                Text(
                  'Phone',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 40, 39, 39),
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                custemFieldforProductPage(
                  hintText: 'Enter Phone Number',
                  controller: nameContr,
                  text: '',
                  validator: (value) {},
                  width: 12,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Address',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 40, 39, 39),
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                custemFieldforProductPage(
                  hintText: 'Enter Address',
                  controller: nameContr,
                  text: '',
                  validator: (value) {},
                  width: 12,
                ),
              ],
            ),*/
            Text(
              widget.isFree ||
                      (!widget.isFree &&
                          (widget.deliveryOption == 'Free' ||
                              widget.deliveryOption == 'free' ||
                              widget.deliveryOption == 'مجاني'))
                  ? (widget.deliveryOption == 'Free' ||
                          widget.deliveryOption == 'free' ||
                          widget.deliveryOption == 'مجاني')
                      ? '153'.tr
                      : '154'.tr
                  : '151'.tr,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 40, 39, 39),
                  fontSize: 16,
                ),
              ),
            ),
            Visibility(
              visible: widget.isFree ||
                  (!widget.isFree &&
                      (widget.deliveryOption == 'Free' ||
                          widget.deliveryOption == 'free' ||
                          widget.deliveryOption == 'مجاني')),
              child: Column(
                children: [
                  SizedBox(
                      height: (widget.deliveryOption == 'Free' ||
                              widget.deliveryOption == 'free' ||
                              widget.deliveryOption == 'مجاني')
                          ? 10
                          : 0),
                  Text(
                    (widget.deliveryOption == 'Free' ||
                            widget.deliveryOption == 'free' ||
                            widget.deliveryOption == 'مجاني')
                        ? '155'.tr
                        : '',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 40, 39, 39),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    (widget.deliveryOption == 'Free' ||
                            widget.deliveryOption == 'free' ||
                            widget.deliveryOption == 'مجاني')
                        ? '\n${"157".tr}: $firstNameDelivery $lastNameDelivery: ${"158".tr} $phoneNumber'
                        : "${"159".tr} $firstNameDelivery $lastNameDelivery: ${"158".tr} $phoneNumber. ${"160".tr}", // '${deliveryService[0]['first_name']} ${deliveryService[0]['last_name']} : ${deliveryService[0]['phone_number']}",
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 40, 39, 39),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !widget.isFree &&
                  !(widget.deliveryOption == 'Free' ||
                      widget.deliveryOption == 'free' ||
                      widget.deliveryOption == 'مجاني'),
              child: Column(
                children: [
                  RadioListTile(
                    activeColor: Color.fromARGB(255, 2, 92, 123),
                    selectedTileColor: Color.fromARGB(255, 2, 92, 123),
                    title: Text(
                      '152'.tr,
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 40, 39, 39),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    value: 'seller_delivery',
                    groupValue: selectedOption,
                    onChanged: (value) async {
                      await getdeliveryEmployee(
                          'Service employee'); //Service employee
                      setState(() {
                        selectedOption = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: Color.fromARGB(255, 2, 92, 123),
                    selectedTileColor: Color.fromARGB(255, 2, 92, 123),
                    title: Text(
                      '149'.tr,
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 40, 39, 39),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    value: 'system_delivery',
                    groupValue: selectedOption,
                    onChanged: (value) async {
                      await getdeliveryEmployee('Delivery employee');
                      setState(() {
                        delivery =
                            SearchPage.priceprosearch(20, prevselectedCurr);
                        Totaldelivery = SearchPage.getsymbol(delivery);
                        priceWithoutDelivery = SearchPage.priceprosearch(
                            CartItemState.amount, prevselectedCurr);
                        TotalpriceWithoutDelivery =
                            SearchPage.getsymbol(priceWithoutDelivery);
                        priceWithDelivery = SearchPage.priceprosearch(
                            CartItemState.amount! + 20.0, prevselectedCurr);
                        TotalpriceWithDelivery =
                            SearchPage.getsymbol(priceWithDelivery);

                        selectedOption = value.toString();
                      });
                    },
                  ),
                  Text(
                    selectedOption == 'Not Selected'
                        ? ''
                        : selectedOption == 'system_delivery'
                            ? "${"159".tr} $firstNameDelivery $lastNameDelivery: ${"158".tr} $phoneNumber. ${"160".tr}\n\n${"161".tr}: ${Totaldelivery.split(":")[1]}  \n${"162".tr}: ${TotalpriceWithoutDelivery.split(":")[1]}\n${"162".tr}: ${TotalpriceWithDelivery.split(":")[1]}"
                            : '${"164".tr}: $phoneNumber ${"165".tr}',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 40, 39, 39),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: CustomeButton2(
                text: widget.isFree ? "124".tr : "121".tr,
                onPressed: () {
                  fetchDelivery();
                  if (!widget.isFree) {
                    try {
                      Navigator.pop(context);
                      print(
                          'out if TotalpriceWithDelivery ; ${TotalpriceWithDelivery.split(" ")[2]}');
                      if (selectedOption == 'system_delivery') {
                        double total =
                            double.parse(TotalpriceWithDelivery.split(" ")[2]);
                        totalAmount = total + 0;
                        print('in if TotalpriceWithDelivery ; $total');
                      }
                      Payment.onPaymentSuccess = widget.onPaymentSuccess;
                      Payment.makePayment(
                          context, totalAmount, widget.productId);

                      print('Payment sheet initialized successfully.');
                    } catch (e) {
                      print('Error initializing payment sheet: $e');
                    }
                  }
                  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                  if (widget.isFree) {
                    Duration delay = Duration(minutes: 10);

                    Timer(delay, () async {
                      triggerNotificationFromPages('Rating Products',
                          "We'd Love Your Feedback on Your Recent Order On The Free Product!");
                    });
                    Flushbar(
                      message: "Order Done",
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                      margin: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(8),
                    ).show(context);
                    // Get.to(() => HomePage());
                    //   Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          title: Text(
                            'Thank you',
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
                          content: Text(
                            'You can Track your Order after start the delivery process, we will send notifications to you',
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 1, 3, 4),
                                fontSize: 14,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            CustomeButton2(
                              text: "Done",
                              onPressed: () {
                                Get.to(() => HomePage());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  //Navigator.pop(context, selectedOption);

/*
                  RecentSingleProdState.showRatingDialog(
                      RecentSingleProdState.id,
                      RecentSingleProdState.image,
                      RecentSingleProdState.name);*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> getdeliveryEmployee(String type) async {
    http.Response? response;
    print('****************** in getdeliveryEmployee');
    print('****************** type: $type');
    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/user/deliveryEmployee?type=$type'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('results')) {
          setState(() {
            deliveryService =
                List<Map<String, dynamic>>.from(responseData['results']);
            firstNameDelivery = deliveryService[0]['first_name'];
            lastNameDelivery = deliveryService[0]['last_name'];
            phoneNumber = deliveryService[0]['phone_number'];
          });
          print(deliveryService[0]['first_name']);
          print(deliveryService[0]['last_name']);
          print(deliveryService[0]['phone_number']);
        } else {
          print('Failed to retrive delivery');
        }
      } else {
        print(
            'Failed to retrive delivery. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: '); //${response?.body}
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }

  //
  Future<Map<String, dynamic>?> getdeliveryFromSellar(int productId) async {
    http.Response? response;
    print('****************** in getdeliveryFromSellar');
    print('****************** productId: $productId');
    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/user/deliveryFromSellar?productId=$productId'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('results')) {
          setState(() {
            sellarInfo =
                List<Map<String, dynamic>>.from(responseData['results']);
            firstNameDelivery = sellarInfo[0]['first_name'];
            lastNameDelivery = sellarInfo[0]['last_name'];
            phoneNumber = sellarInfo[0]['phone_number'];
          });
          print(sellarInfo[0]['first_name']);
          print(sellarInfo[0]['last_name']);
          print(sellarInfo[0]['phone_number']);
        } else {
          print('Failed to retrive delivery');
        }
      } else {
        print(
            'Failed to retrive delivery. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(' Response body: '); //${response?.body}
      // throw Exception('Failed to fetch data: $e');
    }
    return null;
  }
}
