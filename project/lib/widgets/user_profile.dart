import 'package:flutter/material.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/enam.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
