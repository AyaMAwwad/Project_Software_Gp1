// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, unnecessary_import, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project/src/chat/chat_service.dart';
import 'package:project/src/screen/chat_bubble.dart';
import 'package:project/src/screen/chat_page.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/login_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  static String FirstNameSender = '';
  static String LastNameSender = '';
  static String FirstNameReceiver = '';
  static String LastNameReceiver = '';
  List<Map<String, dynamic>> allUserName = [];
  Map<String, dynamic> userInfo = {
    'first_name': 'You',
  };
////////////
  final ChatService chatService = ChatService();
  @override
  void initState() {
    super.initState();
    j = 0;
    //  allUserName.clear();

    allUserName.add(userInfo);
    buildUserList();
  }

  int j = 0;

  final FirebaseAuth auth = FirebaseAuth.instance;

  List<String> ListProfile = [
    'images/icon/aega.jpeg',
    'images/icon/userprofile1.png',
    'images/icon/Profile1.png',
  ];

  @override
  Widget build(BuildContext context) {
    j = 0;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 92, 123),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Messages',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        decorationThickness: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'R E C E N T',
                style: TextStyle(
                  color: Color.fromARGB(255, 150, 150, 150),
                  fontSize: 12,
                  decorationThickness: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    ListProfile.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                          right: index < ListProfile.length - 1
                              ? 10.0
                              : 0), // Adjust the value according to your needs
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          ListProfile[index],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 20),
              child: Text(
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decorationThickness: 1,
                  ),
                ),
                allUserName.map((userInfo) {
                  String firstName = userInfo['first_name'];

                  //  String lastName = userInfo['last_name'];
                  return '$firstName ';
                }).join(
                    '           '), // Joining all the names with a comma and space
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    255, 95, 150, 168), //Color.fromARGB(255, 95, 150, 168),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey,
                      Color.fromARGB(255, 147, 198, 215),
                      // .withOpacity(0.15),
                      Color.fromARGB(255, 95, 150, 168),
                      // .withOpacity(0.1),

                      //  .withOpacity(0.05),
                      Color.fromARGB(255, 95, 150, 168),
                      // .withOpacity(0.1),
                      Color.fromARGB(255, 147, 198, 215),
                      Colors.grey,
                      // .withOpacity(0.15),
                    ]),*/
              ),
              width: double.infinity,
              height: 515,
              child: buildUserList(),
            ),
            //   buildUserList(),
          ],
        ),
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      //FirebaseFirestore.instance.collection('users').snapshots(),
      stream: FirebaseFirestore.instance.collection('Theusers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Text(
            'Loading...',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,

                // decoration: TextDecoration.underline,
                decorationThickness: 1,
                fontWeight: FontWeight.bold,
                //padding: 10,
              ),
            ),
          ));
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  void fetchProducts(String data) async {
    // userDetailsList.clear();
    await getName(data);
    // setState(() {});
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    print(data['uid']);
    print(data['first_name']);
    print(data['last_name']);

    if (auth.currentUser!.email != data['email']) {
      LastNameReceiver = data['last_name'];
      FirstNameReceiver = data['first_name'];
      bool nameExists = allUserName
          .any((userInfo) => userInfo['first_name'] == FirstNameReceiver);

// If the name doesn't already exist, add it to the list
      if (!nameExists) {
        Map<String, dynamic> userInfo = {
          'first_name': FirstNameReceiver,
        };

        // Add the map to the list
        // allUserName.add(userInfo);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            allUserName.add(userInfo);
          });
        });
      }

      j++;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: InkWell(
          onTap: () async {
            await getName(Login.Email);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userId: data['uid'],
                  userEmail: data['email'],
                  firstNameSender: FirstNameSender,
                  lastNameSender: LastNameSender,
                  firstNameReceiver: data['first_name'],
                  lastNameReceiver: data['last_name'],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    ListProfile[j],
                    width: 50,
                    height: 50, // 200
                    //  fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // for (int i = j; i < j + 1; i++)
                      Text(
                        '${data['first_name']} ${data['last_name']}',
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: Colors.white,
                            //Color.fromARGB(255, 0, 0, 0), // Colors.white,
                            fontSize: 16,
                            decorationThickness: 1,
                          ),
                        ), /*TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),*/
                      ),
                      //CustomChatBubble
                      SizedBox(
                        height: 5,
                      ),
                      buildMessageList(data['uid']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildMessageList(String uid) {
    return StreamBuilder(
      stream: chatService.getMessages(uid, auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Text(
            'Loading...',
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
          ));
        }
        var messages = snapshot.data!.docs as List<DocumentSnapshot>;
        if (messages.isNotEmpty) {
          var lastMessage =
              messages[messages.length - 1].data() as Map<String, dynamic>;

          Timestamp timestamp = lastMessage['timestamp'];
          DateTime dateTime = timestamp.toDate();

          String formattedTime = DateFormat.Hm().format(dateTime);

          return lastMessage['senderId'] == auth.currentUser!.uid
              ? designMsg('You: ' + lastMessage['message'], (formattedTime))
              : designMsg(lastMessage['message'], (formattedTime));
        } else {
          return Text('');
        }
      },
    );
  }

  Widget designMsg(String msg, String theDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          msg,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 191, 189, 189),
              fontSize: 12,
              decorationThickness: 1,
            ),
          ),
        ),
        Text(
          theDate,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 191, 189, 189),
              fontSize: 12,
              decorationThickness: 1,
            ),
          ),
        ),
      ],
    );
  }

///////////////////
  Future<Map<String, dynamic>?> getName(String email) async {
    http.Response? response;

    // print(email);
    try {
      response = await http.get(Uri.parse(
          'http://192.168.0.114:3000/tradetryst/user/userName?email=$email'));
      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          // Extract price from the first item in the list

          dynamic user = responseData[0];
          // print(responseData[0]);
          // if (email == Login.Email) {
          print("AEGAAEGAAEGA");
          FirstNameSender = user['first_name'];
          LastNameSender = user['last_name'];
          dynamic userId = user['user_id'].toString();
          // }
          /*else {
            FirstNameReceiver = user['first_name'];
            LastNameReceiver = user['last_name'];
            dynamic userId = user['user_id'].toString();
            print(FirstNameReceiver);
            print(LastNameReceiver);

            Map<String, dynamic> userDetails = {
              'first_name': FirstNameReceiver,
              'last_name': LastNameReceiver,
            };
          }*/
        } else {
          throw Exception('Empty or invalid response ');
        }
      } else {
        throw Exception('Failed . Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e, Response body: ${response?.body}');
      throw Exception('Failed  : $e');
    }
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    } else {
      return null;
    }
  }
}
