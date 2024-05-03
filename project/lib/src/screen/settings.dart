import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/src/screen/multiLanguage.dart';
import 'package:project/src/screen/notification_page.dart';
import 'package:project/src/screen/security.dart';

class SettingsPage extends StatelessWidget {
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
                  Navigator.of(context).pushReplacementNamed(
                      "homepagee"); // This will pop the current route (Drawer)
                },
              ),
              SizedBox(width: 10),
              Text(
                // '1'.tr,
                '62'.tr,
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

      // onPressed: () {
      //  Navigator.of(context).pushReplacementNamed(
      // //       "homepagee"); // This will pop the current route (Drawer)
      //  },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildSectionHeader(
                'General'), // Used a custom method to build section headers
            _buildListTile(
              context,
              icon: Icons.language,
              title: 'Language',
              onTap: () //async
                  {
                //  Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => MultiLanguage()),
                //  );
                Get.to(() => MultiLanguage());
              }, // () {
              // Navigate to language selection page  MultiLanguage()
              // },
            ),
            _buildDivider(),
            _buildListTile(
              context,
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                Get.to(() => NotificationPage());
                // Navigate to notification settings page notification
              },
            ),
            _buildDivider(),
            _buildSectionHeader('Account'),
            _buildListTile(
              context,
              icon: Icons.account_circle,
              title: 'Account Settings',
              onTap: () {
                // Navigate to account settings page
              },
            ),
            _buildDivider(),
            _buildListTile(
              context,
              icon: Icons.security,
              title: 'Privacy & Security',
              onTap: () // async
                  {
                //  Navigator.pushReplacement(
                //    context,
                //    MaterialPageRoute(builder: (context) => PrivacySecurityPage()),
                //  );
                Get.to(() => PrivacySecurityPage());
              },
            ),
            _buildDivider(),
            // Add more sections and settings options as needed
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 0,
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required Function onTap}) {
    return ListTile(
      leading: Icon(icon,
          size: 30,
          color: Color.fromARGB(
              255, 20, 79, 99)), // Increased icon size and added color
      title: Text(title),
      onTap: () => onTap(),
    );
  }
}
