import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/statisticpage.dart'; // for making HTTP requests

class rolemanagement extends StatefulWidget {
  @override
  _RoleManagementState createState() => _RoleManagementState();
}

class _RoleManagementState extends State<rolemanagement> {
  List<Order> orders = [];
  List<Order> filteredOrders = [];
  TextEditingController _filterController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String _filterType = 'category'; // Default filter type
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String? selectedMonth;
  String? selectedYear;
  List<String> years =
      List.generate(50, (index) => (DateTime.now().year - index).toString());

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
          filteredOrders =
              List.from(orders); // Initialize with all orders // ibtisam
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
              IconButton(
                icon: Icon(Icons.bar_chart, size: 28), // Add this icon
                onPressed: () {
                  Get.to(() =>
                      StatisticsPage()); // Navigate to the statistics page
                },
              ),
              IconButton(
                icon: Icon(Icons.filter_list, size: 28),
                onPressed: () {
                  filtershowwww();
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
          itemCount: filteredOrders.length, // orders
          itemBuilder: (context, index) {
            final order = filteredOrders[index]; // orders
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
                      child: Text('Show'),
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

  // hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
  /*void _filterOrders(String category) {
  setState(() {
    if (category.isEmpty) {
      filteredOrders = List.from(orders);
    } else {
     // filteredOrders = orders.where((order) => order.productname.toLowerCase().contains(category.toLowerCase())).toList();
          filteredOrders = orders.where((order) => order.categoryName.toLowerCase().contains(category.toLowerCase())).toList();

    }
  });
}*/
/*void _filterOrders(String category) {
  DateTime now = DateTime.now();
  DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
  _filterOrdersByDate(category, oneMonthAgo);
}*/
  void _filterOrders(String category) {
    setState(() {
      if (category.isEmpty) {
        filteredOrders = List.from(orders);
      } else {
        filteredOrders = orders
            .where((order) => order.categoryName
                .toLowerCase()
                .contains(category.toLowerCase()))
            .toList(); // by capital and smalllll normal
        // filteredOrders = orders.where((order) => order.productname.toLowerCase().contains(category.toLowerCase())).toList();
      }
    });
  }

  void filterordermonthhhh(DateTime? startDate) {
    setState(() {
      if (startDate == null) {
        filteredOrders = List.from(orders);
      } else {
        //  filteredOrders = orders.where((order) => DateTime.parse(order.paymentDate).isAfter(startDate)).toList();
        final filteredDate = DateTime(startDate.year, startDate.month);
        filteredOrders = orders.where((order) {
          final orderDateee = DateTime.parse(order.paymentDate);
          return orderDateee.year == filteredDate.year &&
              orderDateee.month == filteredDate.month;
        }).toList();
      }
    });
  }

  /*  void _filterOrdersByDate(String category, DateTime? startDate) {
  setState(() {
    if (category.isEmpty && startDate == null) {
      filteredOrders = List.from(orders);
    } else {
      filteredOrders = orders.where((order) {
        bool matchesCategory = category.isEmpty || order.categoryName.toLowerCase().contains(category.toLowerCase());
        bool matchesDate = startDate == null || DateTime.parse(order.paymentDate).isAfter(startDate);
        return matchesCategory && matchesDate;
      }).toList();
    }
  });
}*/

/*
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Orders'),
          content: TextField(
            controller: _filterController,
            decoration: InputDecoration(
              hintText: 'Enter category name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _filterOrders(_filterController.text); // Use input value for filtering
                Navigator.of(context).pop();
              },
              child: Text('Filter'),
            ),
          ],
        );
      },
    );
  }*/

  //
  void filtershowwww() {
    DateTime now = DateTime.now();
    selectedYear = now.year.toString();
    selectedMonth = months[now.month - 1];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 10.0,
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Orders', // filter orderrrrrr
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 36, 80, 95),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ListTile(
                      title: Text(
                        'By Category',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      leading: Radio(
                        value: 'category',
                        groupValue: _filterType,
                        onChanged: (String? value) {
                          setState(() {
                            _filterType = value!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 36, 80, 95),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'By Months',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      leading: Radio(
                        value: 'date',
                        groupValue: _filterType,
                        onChanged: (String? value) {
                          setState(() {
                            _filterType = value!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 36, 80, 95),
                      ),
                    ),
                    if (_filterType == 'category')
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: _filterController,
                          decoration: InputDecoration(
                            hintText: 'Enter category name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                          ),
                        ),
                      ),
                    if (_filterType == 'date')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Month and Year',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedMonth,
                                    isExpanded: true,
                                    hint: Text('Select Month'),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                    ),
                                    items: months.map((month) {
                                      return DropdownMenuItem<String>(
                                        value: month,
                                        child: Container(
                                          height: 30,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            month,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedMonth = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 60,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedYear,
                                    isExpanded: true,
                                    hint: Text('Select Year'),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                    ),
                                    items: years.map((year) {
                                      return DropdownMenuItem<String>(
                                        value: year,
                                        child: Container(
                                          height: 30,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            year,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedYear = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          child: Text('Apply'),
                          onPressed: () {
                            if (_filterType == 'category') {
                              _filterOrders(_filterController.text);
                            } else if (_filterType == 'date') {
                              int? monthIndex = selectedMonth != null
                                  ? months.indexOf(selectedMonth!) + 1
                                  : null;
                              int? year = selectedYear != null
                                  ? int.tryParse(selectedYear!)
                                  : null;
                              if (monthIndex != null && year != null) {
                                filterordermonthhhh(DateTime(
                                    year, monthIndex)); // filterbymonthhh
                              }
                            }
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 36, 80, 95),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
//  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 36, 80, 95),

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
  final String categoryName;

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
    required this.categoryName,
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
      categoryName: map['category_name'] ?? '',
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
      'category_name': categoryName,
    };
  }

  //
  String get formattedDate {
    final DateTime dateTime = DateTime.parse(paymentDate);
    // final DateFormat formatter = DateFormat('yyyy-MM');

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
