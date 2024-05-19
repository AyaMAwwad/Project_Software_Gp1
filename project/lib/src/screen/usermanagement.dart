import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:project/src/screen/adminscreen.dart';
import 'package:project/src/screen/ipaddress.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  /*final List<Map<String, String>> users = [
    {"username": "john_doe", "email": "john@example.com", "role": "User", "status": "Active"},
    {"username": "jane_doe", "email": "jane@example.com", "role": "Admin", "status": "Inactive"},
    // Add more users as needed
  ]; */
  List<Map<String, dynamic>> userss = [];
  @override
  void initState() {
    super.initState();
    getuserss();
  }

  void editdialoggg(Map<String, dynamic> user) {
    // ibtisam
    /*  TextEditingController namefirst = new TextEditingController(text: user['first_name']);
    TextEditingController namelast = new TextEditingController(text: user['last_name']);
    TextEditingController email = new TextEditingController(text: user['email']);
    TextEditingController type = new TextEditingController(text: user['user_type']);
*/
    // ibtisam
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: boxxx(context, user),
        );
      },
    );
  }

  Widget boxxx(BuildContext context, Map<String, dynamic> user) {
    // ibtisam
    TextEditingController namefirst =
        new TextEditingController(text: user['first_name']);
    TextEditingController namelast =
        new TextEditingController(text: user['last_name']);
    TextEditingController email =
        new TextEditingController(text: user['email']);
    TextEditingController type =
        new TextEditingController(text: user['user_type']);
// ibtisam
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(97, 1, 43, 56),
                offset: Offset(0, 10),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit User",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller:
                    namefirst, //TextEditingController(text: user['first_name'], ),
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: TextStyle(
                    fontFamily: 'GoogleFont',
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              TextField(
                controller:
                    namelast, //TextEditingController(text: user['last_name']),
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: TextStyle(
                    fontFamily: 'GoogleFont',
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              TextField(
                controller: email, //TextEditingController(text: user['email']),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontFamily: 'GoogleFont',
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              TextField(
                controller:
                    type, //TextEditingController(text: user['user_type']),
                decoration: InputDecoration(
                  labelText: "User Type",
                  labelStyle: TextStyle(
                    fontFamily: 'GoogleFont',
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 2, 92, 123),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Save user changes
                      // Map()

                      Map<String, dynamic> useruupdatee = {
                        'first_name': namefirst.text,
                        'last_name': namelast.text,
                        'email': email.text,
                        'user_type': type.text,
                      };

                      updateuserfromadmin(useruupdatee);
                      getuserss();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 2, 92,
                          123), // Color.fromARGB(255, 94, 117, 125),
                      padding: EdgeInsets.symmetric(horizontal: 22.0),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  /*TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },/*style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 2, 92, 123),// Color.fromARGB(255, 94, 117, 125),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),*/
                  child: Text("Cancel", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
// ibtisammmmm

  void deleteefuncc(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete User"),
          content: Text(
              "Are you sure you want to delete ${user['first_name']} ${user['last_name']} ${user['user_id']}?"),
          actions: [
            TextButton(
              onPressed: () {
                // Delete user
                deletuserfromadmin(user);
                getuserss();
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.dashboard,
                color: const Color.fromARGB(255, 2, 92, 123),
              ),
              onPressed: () {
                Get.to(() => AdminDashboard());
              },
            ),
            Spacer(),
            Center(
              child: Text(
                'User Management',
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Container(width: 48), // Ensures the text stays centered
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: userss.length,
                itemBuilder: (context, index) {
                  final user = userss[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // black 26
                          // color: Color.fromARGB(99, 1, 73, 97),
                          blurRadius: 3,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(
                        vertical: 8), // Add margin between cards
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        user['first_name']! + ' ' + user['last_name']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${user['email']}\n${user['user_type']}",
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 107, 106, 106),
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              //  color: Color.fromARGB(99, 1, 73, 97),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: PopupMenuButton<String>(
                            onSelected: (String value) {
                              if (value == 'edit') {
                                editdialoggg(user);
                              } else if (value == 'delete') {
                                deleteefuncc(user);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: 'edit',
                                //   child: Container(
                                /*   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color.fromARGB(255, 230, 230, 230),
                                  ),*/
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,
                                        color: const Color.fromARGB(
                                            255, 2, 92, 123)),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                                //  ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                //       child:    CircleAvatar(
                                //  backgroundColor: Colors.white,
                                //  radius: 20,
                                //
                                //   child: Container(
                                /*  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color.fromARGB(255, 230, 230, 230),
                                  ),*/
                                child: Row(
                                  children: [
                                    Icon(Icons.delete,
                                        color: const Color.fromARGB(
                                            255, 2, 92, 123)),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                                //  ),
                              ),
                            ],
                            icon: Icon(Icons.more_vert,
                                color: const Color.fromARGB(255, 2, 92, 123)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            /*ElevatedButton(
              onPressed: () {
                // Show add user dialog
              },
              child: Text("Add New User"),
            ),*/
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show add user dialog
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 2, 92, 123),
      ),
      /* floatingActionButton: Container(
        width: 60.0, // Set your desired width
        height: 60.0, // Set your desired height
        child: FloatingActionButton(
          onPressed: () {
            // Show add user dialog
          },
          child: Icon(Icons.add, size: 30.0), // Adjust the icon size if needed
          backgroundColor: const Color.fromARGB(255, 2, 92, 123),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius if needed
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,*/
    );
  }

  // fetch data
  Future<void> getuserss() async {
    final url = Uri.parse('http://$ip:3000/tradetryst/usermanage/list');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      /* body: jsonEncode(<String, String>{
         
        }),*/
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      try {
        Map<String, dynamic> responseBody = json.decode(response.body);
        List<dynamic> userData =
            responseBody['message']; //json.decode(response.body);
        setState(() {
          userss = userData
              .map((user) => {
                    'first_name': user['first_name'],
                    'last_name': user['last_name'],
                    'email': user['email'],
                    'user_type': user['user_type'],
                    'user_id': user['user_id'],
                  })
              .toList();
        });
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      // Handle the error
      print('Failed to load users');
    }
  }

  /// update iiii

  Future<void> updateuserfromadmin(Map<String, dynamic> user) async {
    final url = Uri.parse('http://$ip:3000/tradetryst/useradmin/updateadmin');
    // user['first_name'] = namefirst.text;
    // user['last_name'] = namelast.text;
    // user['email'] = email.text;
    // user['user_type'] = type.text;

    //
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user
          /* <String, dynamic>{
      'first_name': user['first_name'],
      'last_name': user['last_name'],
      'email': user['email'],
      'user_type': user['user_type'],
    }*/

          ),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      print('User updated successfully');
    } else {
      print('Failed to update user: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

// update iii

// delete user from adminnnnnn
  Future<void> deletuserfromadmin(Map<String, dynamic> user) async {
    final url = Uri.parse('http://$ip:3000/tradetryst/deleteaccount/delete');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        //user
        <String, String>{
          'userId': user['user_id'].toString(),
        },
      ),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      print('User deletedddd successfully');
      setState(() {
        print(' User deleted hhhh\n \n ');
        getuserss();
      });
    } else {
      print('Failed to deleteddd user: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

// delete user frommmm adminnnn

// fetch data user
}
