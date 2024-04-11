// ignore_for_file: unnecessary_import, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/chat/chat_service.dart';
import 'package:project/src/screen/chat_bubble.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/signup_screen.dart';
import 'package:project/widgets/textfield_add_prod.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String userEmail;

  final String firstNameSender;
  final String lastNameSender;
  final String firstNameReceiver;
  final String lastNameReceiver;

  const ChatPage({
    super.key,
    required this.userId,
    required this.userEmail,
    required this.firstNameSender,
    required this.lastNameSender,
    required this.firstNameReceiver,
    required this.lastNameReceiver,
  });
  @override
  ChatpageState createState() => ChatpageState();
}

class ChatpageState extends State<ChatPage> {
  static String sendN = '';
  static String sendF = '';

  String? lastSenderName;
  final TextEditingController msgController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  void sendMessage() async {
    if (msgController.text.isNotEmpty) {
      await chatService.sendMessage(widget.userId, msgController.text);
      msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    sendN = widget.firstNameReceiver;
    sendF = widget.lastNameReceiver;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 150, 168),
        elevation: 40,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 2, 92, 123),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '${widget.firstNameReceiver} ${widget.lastNameReceiver}',
          style: TextStyle(
            color: Color.fromARGB(255, 2, 92, 123),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          //height: 30,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 95, 150, 168),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: kToolbarHeight),
          alignment: Alignment.bottomCenter,
          child: SizedBox(height: 20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      /*AppBar(
        backgroundColor: Color.fromARGB(255, 95, 150, 168),
        elevation: 90,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 2, 92, 123),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '${widget.firstNameReceiver} ${widget.lastNameReceiver}',
          style: TextStyle(
            color: Color.fromARGB(255, 2, 92, 123),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),*/
      /* bottom: PreferredSize(
          preferredSize: Size.square(20),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(90),
                ),
              ),
              color: const Color.fromARGB(255, 255, 251, 254),
            ),
            height: 30.0,
          ),
        ),
      ),*/
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          buildMessageInput(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessages(widget.userId, auth.currentUser!.uid),
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
        return ListView(
          children: snapshot.data!.docs
              .map((document) => buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
/*
    String senderName = (data['senderEmail'] == Login.Email)
        ? widget.firstNameSender + ' ' + widget.lastNameSender
        : widget.firstNameReceiver + ' ' + widget.lastNameReceiver;*/

    // Check if the current sender's name is different from the last sender's name
    /* bool showSenderName = senderName != lastSenderName;
    lastSenderName = senderName; // Update last sender's name
*/
    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 2),
      child: Column(
        crossAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          /* if (showSenderName)
            Text(
              senderName,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 15,
                  decorationThickness: 1,
                ),
              ),
            ),*/
          SizedBox(
            height: 4,
          ),
          CustomChatBubble(
              message: data['message'], email: data['senderEmail']),
          /* Container(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['message'],
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 15,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200],
              ),
              child: TextFormField(
                controller: msgController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Message...',
                  hintStyle: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                      fontSize: 16,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ),
          SizedBox(
              width:
                  10), // Add some space between the text field and send button
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              onTap: sendMessage,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 2, 92, 123),
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    /*Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: custemFieldforProductPage(
              hintText: 'Enter a message',
              controller: msgController,
              text: '',
              validator: (val) {},
            ), /*TextField(
              controller: msgController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a message',
              ),
            ),*/
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55.0),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 2, 92, 123),
                  size: 35,
                )),
          )
        ],
      ),
    );*/
  }
}
