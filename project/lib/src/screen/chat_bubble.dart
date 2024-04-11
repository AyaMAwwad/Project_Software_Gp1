import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:project/model/message.dart';
import 'package:project/src/screen/login_screen.dart';

class CustomChatBubble extends StatelessWidget {
  final String message;
  final String email;

  const CustomChatBubble({Key? key, required this.message, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSentByMe = false;
    if (email == Login.Email) {
      isSentByMe = true;
    } else {
      isSentByMe = false;
    }

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ChatBubble(
        alignment: isSentByMe ? Alignment.topRight : Alignment.topLeft,
        clipper: isSentByMe
            ? ChatBubbleClipper6(
                type: BubbleType.sendBubble,
                radius: 10,
                nipSize: 5,
                sizeRatio: 3,
                //  radius: 15,
                // nipSize: 4,
                // sizeRatio: 3)
              )
            : ChatBubbleClipper6(
                type: BubbleType.receiverBubble,
                radius: 10,
                nipSize: 5,
                sizeRatio: 3),
        backGroundColor: isSentByMe
            ? Color.fromARGB(255, 17, 99, 132)
            : Colors.grey[
                300]!, // Color.fromARGB(255, 2, 92, 123) : Colors.grey[300]!,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          // padding: EdgeInsets.all(5),
          child: Text(
            message,
            style: TextStyle(
              color: isSentByMe ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
