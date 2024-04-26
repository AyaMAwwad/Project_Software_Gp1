import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project/widgets/search_app.dart';

class SearchPage extends StatelessWidget {
  final String text;
  static List<Map<String, dynamic>> searchRetrive = [];

  const SearchPage({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    serachGet(text);
    return Scaffold(
        //  body: SearchAppBar(),
        );
  }

  Future<Map<String, dynamic>?> serachGet(String name) async {
    http.Response? response;

    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/search/retriveWordOfsearch?name=$name'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        dynamic user = responseData[0];
        print(user);
        print('############################################');
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
