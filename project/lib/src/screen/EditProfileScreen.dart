import 'dart:convert';
import 'dart:io';
import 'package:project/src/screen/ipaddress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/widgets/button.dart';
//import 'package:project/widgets/date_field.dart';
import 'package:project/widgets/form_field.dart';
//import 'package:project/src/screen/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:project/widgets/user_profile.dart';
//import 'package:project/src/mixins/valid_mixin.dart';
import 'package:project/src/screen/login_screen.dart';

class editprofile extends StatefulWidget {
  //late final Function(String) onUpdateFirstName;
  // Define callback function type
//editprofile({required this.onUpdateFirstName}); // Constructor

  @override
  EditProfileScreen createState() => EditProfileScreen();
}

class EditProfileScreen extends State<editprofile> {
  /// the new

  void _imagePicker() async {
    var imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        UserProfileState.imagesayyya = File(
            pickedImage.path); // Assign the selected image to the File variable
      });
    }
  }

  //
  static TextEditingController firstName = TextEditingController();
  static TextEditingController lastName = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController phoneA = TextEditingController();
  static TextEditingController address = TextEditingController();
  static TextEditingController gender = TextEditingController();

  String firsttname = Login.first_name;
  String lastttname = Login.last_name;
  String emailbefore = Login.Email;
  String addressbefore = Login.address;
  String phonebefore = Login.phonenumberr;
  int iduser = Login.idd;
  String birthday = Login.birthdaylogin;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  String formattedBirthday = '';

  fub() {
    if (birthday.isNotEmpty) {
      final DateTime parsedDate = DateTime.parse(birthday);
      formattedBirthday = DateFormat('yyyy-MM-dd').format(parsedDate);
      // print('\n \n $formattedBirthday\n $birthday\n \n ');
    }
  }

// late String firstName;
  // late String lastName;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        gender.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the state with the values passed from the constructor
    Login.first_name = firstName.text;
    Login.last_name = lastName.text;
    //Login.birthdaylogin = gender.text;
    fub();
    // callfun(firstName.text);
    // lastName.text = Login.last_name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 95, 150, 168),
        elevation: 40,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white, // Color.fromARGB(255, 2, 92, 123),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
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
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Column(
          children: [
            SizedBox(height: 40.0),
            image(),
            SizedBox(height: 20.0),
            textfield1(),
          ],
        ),
      ),
    );
  }

  Widget textfield1() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60.0),
            // First Name TextField
            Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0), // Symmetric padding
                width:
                    MediaQuery.of(context).size.width * 0.75, // Adjusted width
                child: custemField(
                  hintText: '$firsttname',
                  controller: firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  icon: Icons.person,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Last Name TextField
            Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0), // Symmetric padding
                width: MediaQuery.of(context).size.width *
                    0.75, // Same width as First Name
                child: custemField(
                  hintText: '$lastttname',
                  controller: lastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  icon: Icons.person,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0), // Symmetric padding
                width: MediaQuery.of(context).size.width *
                    0.75, // Same width as First Name
                child: custemField(
                  hintText: '$emailbefore',
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  icon: Icons.email,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0), // Symmetric padding
                width: MediaQuery.of(context).size.width *
                    0.75, // Same width as First Name
                child: custemField(
                  hintText: '$phonebefore',
                  controller: phoneA,
                  validator: (value) {
                    if (value!.length == 10 &&
                        (value.startsWith('059') || value.startsWith('056'))) {
                    } else if (value.isEmpty) {
                      return 'This Field is required';
                    } else {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  icon: Icons.phone,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0), // Symmetric padding
                width: MediaQuery.of(context).size.width *
                    0.75, // Same width as First Name
                child: custemField(
                  hintText: '$addressbefore',
                  controller: address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Adreess';
                    }
                    return null;
                  },
                  icon: Icons.location_on,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0), // Symmetric padding
                width: MediaQuery.of(context).size.width *
                    0.75, // Same width as First Name
                child: DateField1(
                  hintText: '$formattedBirthday',
                  controller: gender,
                  onTap: () {
                    _selectDate(context);
                  },
                  selectedDate: selectedDate,
                  // hintText: selectedDate == null ? 'Select your birthday' : DateFormat('yyyy-MM-dd').format(selectedDate!),
                  //  2024-04-02T21:00:00.000Z
                ),
              ),
            ),

            //
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: CustomeButton(
                //  width:50,
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      selectedDate != null) {
                    profiledata(
                      iduser,
                      firstName.text,
                      lastName.text,
                      email.text,
                      address.text,
                      phoneA.text,
                      selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : '',
                    );
                    Login.first_name = firstName.text;
                    //widget.onUpdateFirstName(firstName.text);
                    // print('it is ok ${Login.first_name}\n');
                    setState(() {
                      Login.first_name = firstName.text;
                      UserProfileState.firstname = firstName.text;
                      UserProfileState.lastname = lastName.text;
                      UserProfileState.uu = email.text;
                      Login.birthdaylogin =
                          DateFormat('yyyy-MM-dd').format(selectedDate!);
                      Navigator.pop(context, UserProfileState.firstname);
                    });
                    Login.last_name = lastName.text;
                    print('it is ok \n');
                    // print('id user :::: $iduser \n');

                    // All fields are valid, perform update operation
                    // Call a function to update the profile in the database
                    //updateProfile();
                  } else {
                    print('not ok \n');
                  }
                  // Navigator.push(
                  //   context,
                  //  MaterialPageRoute(builder: (context) => editprofile()),
                  //);
                },
                text: 'Edit Profile',
                borderRadius: BorderRadius.circular(30),
                // width : 50,
                //child: Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          UserProfileState.imagesayyya == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                      image: AssetImage('images/icon/userprofile.png')),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    UserProfileState.imagesayyya!,
                    fit: BoxFit.cover,
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

/*
  image() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        // fit: 150,
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
                    fit: BoxFit.cover,
                  ),
                ),
          IconButton(
            icon: Icon(
              Icons.edit, size: 30, // Adjust the size of the icon
              color: Color.fromARGB(218, 3, 57, 52),
            ),
            //size: 30, // Adjust the size of the icon
            // color: Colors.blue,
            // style: //width: 150,

            onPressed: () {
              _imagePicker();
              // Implement the edit functionality here
            },
          ),
        ],
      ),
    );
  }
*/

  Future<void> profiledata(int id, String firstName, String lastName,
      String email, String address, String phoneNumber, String gender) async {
    final url = Uri.parse('http://$ip:3000/tradetryst/edit/editprofile');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'address': address,
          'phoneNumber': phoneNumber,
          'gender': gender,
        }),
      );
      if (response.statusCode == 200) {
        // Profile updated successfully
        print('Profile updated successfully');

        // Retrieve the updated values from the database
        // Example: If your response contains the updated data
        // you can extract it and update the hint texts

        // Assuming the response contains the updated data
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final updatedFirstName = responseData['firstName'];
        final updatedLastName = responseData['lastName'];
        final updatedEmail = responseData['email'];
        final updatedAddress = responseData['address'];
        final updatedPhoneNumber = responseData['phoneNumber'];
        final updatedGender = responseData['gender'];
        //  widget.onUpdateFirstName(updatedFirstName);
        // callfun(updatedFirstName);
        // Set the updated values to the respective TextEditingControllers
        setState(() {
          EditProfileScreen.firstName.text = updatedFirstName;
          EditProfileScreen.lastName.text = updatedLastName;
          EditProfileScreen.email.text = updatedEmail;
          EditProfileScreen.phoneA.text = updatedPhoneNumber;
          EditProfileScreen.address.text = updatedAddress;
          EditProfileScreen.gender.text = updatedGender;
          Login.first_name = updatedFirstName;
          //  Navigator.pop(context, updatedFirstName);
          // callfun(updatedFirstName);
          //  UserProfileState.updateFirstName(updatedFirstName);
        });

        // Trigger a rebuild to update the hint texts
        setState(() {});
        Navigator.pop(context, updatedFirstName);
      } else {
        // Failed to update profile
        print('Failed to update profile');
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
    }
  }
}

// class new

class DateField1 extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  final DateTime? selectedDate;
  final String? hintText; // New parameter for hint text
  DateField1({
    required this.controller,
    required this.onTap,
    required this.selectedDate,
    this.hintText, // Initialize the new parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(82, 209, 224, 223),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Color(0xFF063A4E),
          size: 22,
        ),

        hintText: hintText ??
            'Select your birthday', // Use hintText parameter or default text
        hintStyle: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: selectedDate == null
                ? Color.fromARGB(255, 78, 78, 78)
                : Colors.black,
            fontSize: 16,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF107086),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2679A3)),
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16,
        ),
      ),
      // validator: validPhone,
      onSaved: (String? val) {
        // ignore: avoid_print
        // phone = val!;
      },
      onTap: onTap,
    );
  }
}
