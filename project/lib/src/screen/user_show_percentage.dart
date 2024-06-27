import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';

class UserShowPercentage extends StatefulWidget {
  @override
  _UserShowPercentageState createState() => _UserShowPercentageState();
}

class _UserShowPercentageState extends State<UserShowPercentage> {
  List<UserData> userDataList = [];

  @override
  void initState() {
    super.initState();
    fetchUserPercentages();
  }

  Future<void> fetchUserPercentages() async {
    final url = Uri.parse('http://$ip:3000/tradetryst/product/userPercentages');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userDataList = (data['users'] as List).map((user) {
          try {
            return UserData.fromJson(user);
          } catch (e) {
            print('Error creating UserData: $e, User data: $user');
            return UserData(
              name: '',
              soldPercentage: 0.0,
              totalProductsSold: 0,
              totalProductsAvailable: 0,
              totalProductsPaid: 0,
            );
          }
        }).toList();
      });
    } else {
      print('Failed to load user percentages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Sold Percentages'),
        backgroundColor: Color(0xFF0D6775),
      ),
      body: ListView.builder(
        itemCount: userDataList.length,
        itemBuilder: (context, index) {
          final user = userDataList[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListTile(
              title: Text(
                user.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.soldPercentage.toStringAsFixed(2)}% Sold',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    '${user.totalProductsSold} Products Sold',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '${user.totalProductsAvailable} Products Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    '${user.totalProductsPaid} Products Paid',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserData {
  final String name;
  final double soldPercentage;
  final int totalProductsSold;
  final int totalProductsAvailable;
  final int totalProductsPaid;

  UserData({
    required this.name,
    required this.soldPercentage,
    required this.totalProductsSold,
    required this.totalProductsAvailable,
    required this.totalProductsPaid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    try {
      return UserData(
        name: json['name'] ?? '',
        soldPercentage: json['soldPercentage'] != null
            ? double.parse(json['soldPercentage'].toString())
            : 0.0,
        totalProductsSold: json['totalProductsSold'] != null
            ? int.parse(json['totalProductsSold'].toString())
            : 0,
        totalProductsAvailable: json['totalProductsAvailable'] != null
            ? int.parse(json['totalProductsAvailable'].toString())
            : 0,
        totalProductsPaid: json['totalProductsPaid'] != null
            ? int.parse(json['totalProductsPaid'].toString())
            : 0,
      );
    } catch (e) {
      print('Error parsing UserData: $e');
      return UserData(
        name: '',
        soldPercentage: 0.0,
        totalProductsSold: 0,
        totalProductsAvailable: 0,
        totalProductsPaid: 0,
      );
    }
  }
}
