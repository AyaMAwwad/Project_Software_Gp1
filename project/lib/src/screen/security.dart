import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/src/screen/changepass.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:http/http.dart' as http;
import 'package:project/widgets/user_profile.dart';

class PrivacySecurityPage extends StatefulWidget {
  @override
  PrivacySecurity createState() => PrivacySecurity();
}

class PrivacySecurity extends State<PrivacySecurityPage> {
  int id = Login.idd;
  static String Delete = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 150, 168),
        elevation: 40,
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Colors.white), // Change color to white
                onPressed: () {
                  // Navigator.pop(context);
                  Get.back(); // Use GetX's navigation to return to the previous page

                  print(Get.previousRoute);
                },
              ),
              SizedBox(width: 10),
              Text(
                // '1'.tr,
                'Privacy & Security',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Account Security'),
            _buildSettingItem(
              icon: Icons.security,
              title: 'Change Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changepass()),
                );
                // Implement change password functionality
              },
            ),
            /*
            _buildSettingItem(
              icon: Icons.lock,
              title: 'Two-Factor Authentication',
              onTap: () {
                // Implement two-factor authentication settings
              },
            ),*/
            _buildDivider(),
            _buildSectionHeader('Privacy Settings'),
            /*
            _buildSettingItem(
              icon: Icons.visibility,
              title: 'Manage Data Sharing',
              onTap: () {
                // Implement data sharing preferences
              },
            ),*/
            _buildSettingItem(
              icon: Icons.notifications_active,
              title: 'Notification Preferences',
              onTap: () {
                Get.to(() => NotificationPage());
                // Implement notification preferences
              },
            ),
            _buildDivider(),
            _buildSectionHeader('Data Management'),
            _buildSettingItem(
              icon: Icons.data_usage,
              title: 'View Account Data',
              onTap: () {
                // Implement viewing account data
              },
            ),
            _buildSettingItem(
              icon: Icons.delete,
              title: 'Delete Account',
              onTap: () {
                _showDeleteConfirmationDialog(context);
                // Implement account deletion functionality
              },
            ),
            // Add more settings as needed
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 0,
    );
  }

  ///
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                // Implement delete account functionality here
                // For example:
                // deleteAccount();
                //  deleteaccount(id);
                print('id = $id \n');
                String ii = id.toString();
                print('idii = $ii \n');
                deleteaccount(ii);

                Get.back();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // delete account
  Future<void> deleteaccount(String userId) async {
    final url =
        Uri.parse('http://192.168.1.126:3000/tradetryst/deleteaccount/delete');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        // Account deleted successfully
        print('Account deleted successfully');
        Delete = 'delete';
        setState(() {
          Login.first_name = '';
          Login.last_name = '';
          Login.Email = '';
          Login.birthdaylogin = '';
          Login.phonenumberr = '';
          Login.address = '';
          UserProfileState.firstname = '';
          UserProfileState.lastname = '';
          UserProfileState.uu = '';
        });
        // Perform any additional actions after successful deletion
      } else {
        // Handle other status codes or errors
        print('Failed to delete account. Status code: ${response.statusCode}');
        // Display an error message to the user or handle the error accordingly
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('Error deleting account: $e');
      // Display an error message to the user or handle the error accordingly
    }
  }
}
