// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/app_bar.dart';
//import 'package:project/src/screen/EditProfileScreen.dart';

import 'package:project/src/screen/EditProfileScreen.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  int selectedIndex = 3;
  static String uu = Login.Email;
  static String firstname = Login.first_name;
  static String lastname = Login.last_name;
  static File? imagesayyya;
  void _imagePicker() async {
    var imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagesayyya = File(
            pickedImage.path); // Assign the selected image to the File variable
      });
    }
  }

  updateFirstName() {
    setState(() {
      // Update the first_name variable in Login
      // Login.first_name = ;
      //   firstname = ;
      //EditProfileScreen.callfun()
      firstname = Login.first_name;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the state with the values passed from the constructor
    // Login.first_name = firstName.text ;
    // Login.last_name = lastName.text;
    // callfun(firstName.text);
    //firstname ;
    //updateFirstName();
    // lastName.text = Login.last_name;
  }

  //void updateProfileInfo(Map<String, String> updatedInfo) {

  //}
  // email;
  //Login.Email;
  //   Login()
  //LoginScreen.emailController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        //child: CustemAppBar(),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    "homepagee"); // This will pop the current route (Drawer)
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            CustemAppBar(
              text: 'Profile',
              // child: Column()
            ),

            SizedBox(height: 50),
            Stack(
              alignment: Alignment.center,
              children: [
                image(),
                /*
        SizedBox(
          width: 150, 
          height: 150,
          child: Stack(
           // fit: 150,
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(image: AssetImage('images/icon/userprofile.png')),
              ),
              IconButton(
                icon: Icon(Icons.edit, size: 30, // Adjust the size of the icon
               color: Color.fromARGB(218, 3, 57, 52),),
                //size: 30, // Adjust the size of the icon
              // color: Colors.blue,
               // style: //width: 150,

                onPressed: () {
                  // Implement the edit functionality here
                },
              ),
            ],
          ),
        ),*/
              ],
            ),
            SizedBox(height: 10),

            //  Text('Ibtisam Kharrosheh', style: Theme.of(context).textTheme.headline6,  ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black, // Default text color
                  fontSize: 16, // Default font size
                ),
                //  SizedBox(height: 10),
                //  Text('Ibtisamkharrosheh@gmail.com', style: Theme.of(context).textTheme.headline6,  ),
                //  SizedBox(height: 10),

                children: [
                  TextSpan(
                    text: '$firstname $lastname\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Make the first text bold
                      fontSize: 20, // Larger font size
                    ),
                  ),
                  TextSpan(
                    //ibtisamkharrosheh@gmail.com
                    text: '$uu\n', // Add a line break
                    style: TextStyle(
                      color: Color.fromARGB(255, 79, 77, 77), // Light color
                      fontSize: 16, // Smaller font size
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            //  SizedBox(//height: 50,
            //width: 200,
            // width: double.infinity, // Make button take full width
            Center(
              child: CustomeButton(
                //  width:50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editprofile()),
                  ).then((updatedFirstName) {
                    if (updatedFirstName != null) {
                      setState(() {
                        firstname = updatedFirstName;
                      });
                    }
                  });
                },
                text: 'Edit Profile',
                borderRadius: BorderRadius.circular(30),
                // width : 50,
                //child: Text('Edit Profile'),
              ),
            ),
            //  ),
            SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            buildListTile('Multi Language', Icons.language), // settings

            /// adding
            /* 
     ListTile(
     leading: Row(
     mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: 40), // Add an empty space to increase the distance
      Container(
        width: 45,
        height: 45,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(255, 124, 137, 125).withOpacity(0.1),
        ),
        child: Icon(Icons.settings, color: Color.fromARGB(255, 2, 92, 123),),
      ),
    ],
  ),
           // title: Text('Settings', style:Theme.of(context).textTheme.bodyText1 ,  ),  
            title: Text(
    'Settings', 
    style: Theme.of(context).textTheme.bodyText2?.copyWith(
      fontSize: 18, // Set the font size as desired
      //fontWeight: FontWeight.bold, // Set the font weight as desired
      color: Colors.black, // Set the text color as desired
    ),
  ),  
            trailing:  Row(
               mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimum space
                 children: [
             Container
            (padding: EdgeInsets.all(10),
             // width: 30,height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1), // Specify the color with opacity
                borderRadius: BorderRadius.circular(100), // Adjust the border radius as needed
              ),
             // padding: EdgeInsets.all(8), // Adjust padding as needed
              child: Icon(Icons.arrow_forward,size: 20, color: Colors.grey), // Add the icon
         //  SizedBox(width: 40), 
            ),
            SizedBox(width: 20), 
                 ],
            ),
         ),*/
            // SizedBox(height: 10),
            //const Divider(),
            // listtt(),
            SizedBox(height: 10),
            //const Divider(),
            // SizedBox(height: 10),
            // listtt(),
            buildListTile('Informations', Icons.info),
            SizedBox(height: 10),
            buildListTile('About Us', Icons.info_outline),
            // SizedBox(height: 10),
            //  buildListTile('Contact', Icons.info),
            // SizedBox(height: 10),
            SizedBox(
              height: 10,
            ),
            buildListTile('LogOut', Icons.exit_to_app),
          ],
        ),

// SizedBox(height: 10),
      ),
      // list2

      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartShop()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
                break;
            }
          });
        },
      ),
    );
  }

// function refactor
  listtt() {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 40), // Add an empty space to increase the distance
          Container(
            width: 45,
            height: 45,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromARGB(255, 124, 137, 125).withOpacity(0.1),
            ),
            child: Icon(
              Icons.info,
              color: Color.fromARGB(255, 2, 92, 123),
            ),
          ),
        ],
      ),
      // title: Text('Settings', style:Theme.of(context).textTheme.bodyText1 ,  ),
      title: Text(
        'Informations',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 18, // Set the font size as desired
              //fontWeight: FontWeight.bold, // Set the font weight as desired
              color: Colors.black, // Set the text color as desired
            ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimum space
        children: [
          Container(
            padding: EdgeInsets.all(10),
            // width: 30,height: 30,
            decoration: BoxDecoration(
              color: Colors.grey
                  .withOpacity(0.1), // Specify the color with opacity
              borderRadius: BorderRadius.circular(
                  100), // Adjust the border radius as needed
            ),
            // padding: EdgeInsets.all(8), // Adjust padding as needed
            child: Icon(Icons.arrow_forward,
                size: 20, color: Colors.grey), // Add the icon
            //  SizedBox(width: 40),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  /// function i need
  Widget buildListTile(String title, IconData iconData) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 40), // Add an empty space to increase the distance
          Container(
            width: 45,
            height: 45,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromARGB(255, 124, 137, 125).withOpacity(0.1),
            ),
            child: Icon(iconData, color: Color.fromARGB(255, 2, 92, 123)),
          ),
        ],
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 18, // Set the font size as desired
              //fontWeight: FontWeight.bold, // Set the font weight as desired
              color: Colors.black, // Set the text color as desired
            ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        // Ensure the Row takes minimum space
        children: [
          Container(
            padding: EdgeInsets.all(10),
            // width: 30,height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              // Specify the color with opacity
              borderRadius: BorderRadius.circular(100),
              // Adjust the border radius as needed
            ),
            child: Icon(Icons.arrow_forward, size: 20, color: Colors.grey),
            // Add the icon
            //  SizedBox(width: 40),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

//// function image
  ///
  Widget image() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          imagesayyya == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                      image: AssetImage('images/icon/userprofile.png')),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    imagesayyya!,
                    // fit: BoxFit.cover,
                  ),
                ),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 30,
              color: Color.fromARGB(218, 3, 57, 52),
            ),
            onPressed: () {
              _imagePicker(); // Call _imagePicker function to select an image
            },
          ),
        ],
      ),
    );
  }
}

/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/widgets/add_product.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/enam.dart';
import 'package:project/widgets/app_bar.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        //child: CustemAppBar(),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    "homepagee"); // This will pop the current route (Drawer)
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            CustemAppBar(
              text: 'Profile',
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartShop()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
                break;
            }
          });
        },
        // context: context,
      ),
    );
  }
}
*/
