import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDService {
  static Future saveUserToken(String token) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "email": user!.email,
      "token": token,
    };
    try {
      await FirebaseFirestore.instance
          .collection('users_Token_Notification')
          .doc(user.uid)
          .set(data);
      print('document added successfully to ${user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<String>> getFCMTokensFromDatabase() async {
    List<String> fcmTokens = [];
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users_Token_Notification')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          String? token = data['token'];
          if (token != null) {
            fcmTokens.add(token);
          }
        }
      }
    } catch (e) {
      print('Error getting FCM tokens from database: $e');
    }
    return fcmTokens;
  }
}
