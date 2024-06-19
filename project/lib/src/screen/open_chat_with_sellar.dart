// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/chat_page.dart';
import 'package:project/src/screen/chat_screen.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/ipaddress.dart';

class OpenChatWithSellar {
  //OpenChatWithSellar.idOfSeller
  //  static String NameSend1 = '';
//  static String NameSend2 = '';
  static String NameRec1 = '';
  static String NameRec2 = '';
  static String EmailProv = '';
  static int idOfSeller = 0;
  static void getChatOfSellar(String productName) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://$ip:3000/tradetryst/user/sellarChat?productName=$productName'));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          // Extract price from the first item in the list

          dynamic user = responseData[0];

          NameRec1 = user['first_name'];
          NameRec2 = user['last_name'];
          EmailProv = user['email'];
          idOfSeller = user['user_id'];
          //

          //
          //  print(NameRec1 + NameRec2);

          //  dynamic userId = responseData[2];

          //print(FirstName + LastName + userId);
        } else {
          throw Exception('Empty or invalid response data format for price');
        }
      } else {
        throw Exception(
            'Failed to fetch price for product . Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e, Response body:'); // ${response?.body}
      throw Exception('Failed to fetch price for product : $e');
    }
  }

  static void functionForChar(String item, BuildContext context) async {
    OpenChatWithSellar.getChatOfSellar(item);
    ChatScreenState c = ChatScreenState();
    await ChatScreenState.getName(Login.Email);
    var snapshot = await FirebaseFirestore.instance
        .collection('Theusers')
        .where('email', isEqualTo: OpenChatWithSellar.EmailProv)
        .get();
    var data;
    if (snapshot.docs.isNotEmpty) {
      data = snapshot.docs.first.data();
      // Extract required fields from data
      var userEmail = data['email'];
      var userID = data['uid'];
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();
        var userEmail = data['email'];
        var userID = data['uid'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userId: userID,
              userEmail: userEmail,
              firstNameSender: ChatpageState.sendN,
              lastNameSender: ChatpageState.sendF,
              firstNameReceiver: OpenChatWithSellar.NameRec1,
              lastNameReceiver: OpenChatWithSellar.NameRec2,
            ),
          ),
        );
      }
    }
  }
}
