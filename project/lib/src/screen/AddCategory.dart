import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/adminscreen.dart';
import 'package:project/src/screen/categorylist.dart';
import 'dart:convert';
import 'dart:io';

import 'package:project/src/screen/ipaddress.dart';

class AddCategoryPage extends StatefulWidget {
  //   final Function(Category) updateCategoryList;
  // AddCategoryPage({required this.updateCategoryList});
  static String iiname = '';
  static String typee = '';
  static String imageeload = '';
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        AddCategoryPage.imageeload = pickedFile.path;
      }
    });
  }

  Future<void> _addCategory() async {
    final String categoryName = _categoryNameController.text;
    //static String ii = categoryName;
    //  final String description = _descriptionController.text;
    AddCategoryPage.iiname = categoryName;
    final String type = _typeController.text;
    AddCategoryPage.typee = type;

    String imagefile = '';
    if (_image != null) {
      // Save image to a local or remote location and get the path
      // Here, we'll just use a placeholder path for demonstration
      imagefile = _image!.path;
    }
    AddCategoryPage.imageeload = imagefile;
    Category newCategory = Category(
        name: categoryName,
        imagePath: imagefile); // Replace with actual image path
    print(newCategory.name);
    print('hiii name add category $categoryName \n \n ');
    print('hiii name add category  $imagefile\n \n \n ');
    print(newCategory.imagePath);

    //  widget.updateCategoryList(newCategory);
    Navigator.of(context).pop(newCategory);
    /////////////////////////////////
    /*
    // Handle image uploading
    if (_image != null) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://$ip:3000/tradetryst/category/add'),
      );

      request.fields['category_name'] = categoryName;
   //   request.fields['description'] = description;
      request.fields['type'] = type;

      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category added successfully');
        Navigator.of(context).pop(); // Close the Add Category page after success
      } else {
        print('Failed to add category: ${response.statusCode}');
      }
    } else {
      // Handle cases when no image is selected
      final response = await http.post(
        Uri.parse('http://$ip:3000/tradetryst/category/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'category_name': categoryName,
         // 'description': description,
          'type': type,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category added successfully');
        Navigator.of(context).pop(); // Close the Add Category page after success
      } else {
        print('Failed to add category: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 40,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.to(() => AdminDashboard());
              },
            ),
            SizedBox(width: 10),
            Text(
              'Add Category',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF24505F), Color(0xFF368293)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 2, 92, 123),
                  ),
                  prefixIcon: Icon(Icons.category,
                      color: Color.fromARGB(255, 36, 80, 95)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 36, 80, 95)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              /* SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 2, 92, 123),
                  ),
                  prefixIcon: Icon(Icons.description, color: Color.fromARGB(255, 36, 80, 95)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 36, 80, 95)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),*/
              SizedBox(height: 16.0),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: 'Type',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 2, 92, 123),
                  ),
                  prefixIcon:
                      Icon(Icons.label, color: Color.fromARGB(255, 36, 80, 95)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 36, 80, 95)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(
                              26, 54, 52, 52) //Color.fromARGB(255, 36, 80, 95),
                          ),
                      child: Icon(
                        Icons.add_photo_alternate, size: 50,
                        color: Color.fromARGB(255, 36, 80, 95), //Colors.white
                      ),
                    ),
                  ),
                  Spacer(),
                  if (_image != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Container(
                            width: 28,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: Icon(Icons.close,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 16.0),

              Container(
                width: 200, // Set the desired width here
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addCategory();
                    }
                  },
                  child: Text(
                    'Add Category',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF24505F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                    elevation:
                        5, // Adds a shadow to the button for a more raised appearance
                  ),
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
