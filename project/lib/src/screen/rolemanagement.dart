import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/notification_page.dart'; // for making HTTP requests

class rolemanagement extends StatefulWidget {
  @override
  _RoleManagementState createState() => _RoleManagementState();
}

class _RoleManagementState extends State<rolemanagement> {
  List<Order> orders = [];
  //List<Map<Order, dynamic>> orders = [];
  @override
  void initState() {
    super.initState();
    getproductdrompay();
  }

  //

  Future<void> sendNotification(Order order, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(order.email)
          .collection('userNotifications')
          .add({
        'title': 'Order Accepted',
        'body': 'Your order for ${order.productname} has been accepted.',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Notification sent successfully... and the order accepted .');

      await deletepaymentid(order);
      //
      setState(() {
        orders.removeAt(index);
      });
      //
    } catch (e) {
      print('Failed to send notification: $e');
    }
  }

// delete from database payment
  Future<void> deletepaymentid(Order order) async {
    final url = Uri.parse(
        'http://$ip:3000/tradetryst/deletepayorder/paydelete/${order.paymentId}');

/* final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );*/
    //print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      /* body: jsonEncode(<String, String>{
      //  'userId': userId,
      'patymentId': order.paymentId;
      }),*/
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Order deleted successfully from database');
    } else {
      print('Failed to delete order from database');
    }
  }

// payment id for order

  //
  Future<void> getproductdrompay() async {
    //final String ip = 'YOUR_IP_ADDRESS'; // replace with your IP address

    final url = Uri.parse(
        'http://$ip:3000/tradetryst/orderproduct/productlistt'); // replace with your API endpoint
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        Map<String, dynamic> responseBody = json.decode(response.body);
        List<dynamic> orderData = responseBody['message'];
        setState(() {
          orders = orderData.map((order) => Order.fromMap(order)).toList();
        });
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 36, 80, 95), // Background color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, // Change your color here
            ),
            title: Text(
              'ORDERS',
              style: TextStyle(
                fontSize: 22,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // add
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 28,
                ),
                onPressed: () {
                  Get.to(() => NotificationPage());
                  //   get.
                  // Navigator.push(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => NotificationsScreen()),
                  //   );
                },
              ),
            ],

            // add icon notification
            backgroundColor: Colors
                .transparent, // Make AppBar transparent to show Container's decoration
            elevation: 0, // Remove AppBar shadow

            //centerTitle: true,
          ),
        ),
      ),
      /*  appBar: AppBar(
        title: Text('ORDERS'),
        backgroundColor: Color.fromARGB(255, 36, 80, 95),
      ),*/

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 36, 80, 95),
                  child: Icon(
                    // Icons.shopping_cart,
                    Icons.payment,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  //  order.paymentId ,
                  // 'Payment ID: ${order.paymentId}',
                  '${order.productname}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  // 'Quantity: ${order.amount}',
                  'The Buyer: ${order.firstname} ${order.lastname}\nDate: ${order.formattedDate}\nAmount: \$${order.amount}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  Text(
                      '${order.paymentMethod}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    //  SizedBox(height: 8),
                    // if (order.status != 'accepted')
                    ElevatedButton(
                      onPressed: () {
                        sendNotification(order, index);
                      },
                      child: Text('Accept'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 36, 80, 95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    // if (order.status == 'accepted')
                    /*  Text(
                        'Accepted',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Order {
  final int paymentId;
  final int userId;
  final double amount;
  final String paymentDate;
  final String paymentMethod;
  final String email;
  final String firstname;
  final String lastname;
  final String productname;

  Order({
    required this.paymentId,
    required this.userId,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.productname,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      paymentId: map['payment_id'] ?? 0,
      userId: map['user_id'] ?? 0,
      // amount: double.parse(map['amount']),
      amount: double.tryParse(map['amount']?.toString() ?? '0.0') ?? 0.0,
      paymentDate: map['payment_date'] ?? '',
      paymentMethod: map['payment_method'] ?? 'Unknown',
      email: map['email'] ?? '',
      firstname: map['first_name'] ?? '',
      lastname: map['last_name'] ?? '',
      productname: map['name'] ?? '',
    );
  }
  //
  Map<String, dynamic> toMap() {
    return {
      'payment_id': paymentId,
      'user_id': userId,
      'amount': amount,
      'payment_date': paymentDate,
      'payment_method': paymentMethod,
      'email': email,
      'first_name': firstname,
      'last_name': lastname,
      'name': productname,
    };
  }

  //
  String get formattedDate {
    final DateTime dateTime = DateTime.parse(paymentDate);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
