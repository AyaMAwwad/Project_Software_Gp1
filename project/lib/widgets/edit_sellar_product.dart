import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/saller_product_page.dart';
import 'package:project/widgets/button_2.dart';

class EditProductPage extends StatefulWidget {
  final int productId;
  final Map<String, dynamic> productData;
  final Map<String, dynamic> productDataDetails;

  EditProductPage({
    required this.productId,
    required this.productData,
    required this.productDataDetails,
  });

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _demandOnType;
  late TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _description = TextEditingController();
    _quantityController = TextEditingController();
    _priceController = TextEditingController();
    _demandOnType = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _demandOnType.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> updateProduct(int productId, String name, String type,
      String prodState, int quantity, String cond) async {
    print(productId);
    print(name);
    print(type);
    print(prodState);
    print(quantity);
    print(cond);
    final response = await http.put(
      Uri.parse('http://$ip:3000/tradetryst/product/updateSellarProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'productId': productId,
        'name': name,
        'type': type,
        'prodState': prodState,
        'quantity': quantity,
        'cond': cond,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String theText = (widget.productData['product_type'] == 'New' ||
            widget.productData['product_type'] == 'new' ||
            widget.productData['product_type'] == 'جديد')
        ? 'warranty period'
        : 'product condition';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Product',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Color(0xFF0D6775),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productData['name'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productData['description'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Product Quantity',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productData['quantity'].toString(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productDataDetails.containsKey('price')
                      ? widget.productDataDetails['price'].toString()
                      : widget.productDataDetails['state_free'].toString(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _demandOnType,
                decoration: InputDecoration(
                  labelText: 'Product $theText',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productDataDetails
                          .containsKey('warranty_period')
                      ? widget.productDataDetails['warranty_period'].toString()
                      : widget.productDataDetails['product_condition']
                          .toString(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product $theText';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40, bottom: 40, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomeButton2(
                      text: 'Cancel',
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    CustomeButton2(
                      text: 'Update',
                      onPressed: () async {
                        //  if (_formKey.currentState!.validate()) {
                        await updateProduct(
                          widget.productData['product_id'],
                          _nameController.text.isEmpty
                              ? widget.productData['name']
                              : _nameController.text,
                          widget.productData['product_type'],
                          _priceController.text.isEmpty
                              ? (widget.productDataDetails.containsKey('price')
                                  ? widget.productDataDetails['price']
                                      .toString()
                                  : widget.productDataDetails['state_free']
                                      .toString())
                              : _priceController.text,
                          int.parse(_quantityController.text.isEmpty
                              ? widget.productData['quantity'].toString()
                              : _quantityController.text),
                          _demandOnType.text.isEmpty
                              ? (widget.productDataDetails
                                      .containsKey('warranty_period')
                                  ? widget.productDataDetails['warranty_period']
                                      .toString()
                                  : widget
                                      .productDataDetails['product_condition']
                                      .toString())
                              : _demandOnType.text,
                        );
                        await SellarPageState.getProductOfSellar(Login.idd);
                        // }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/saller_product_page.dart';
import 'package:project/widgets/button_2.dart';

class EditProductPage extends StatefulWidget {
  final int productId;
  final Map<String, dynamic> productData;
  final Map<String, dynamic> productDataDetails;

  EditProductPage({
    required this.productId,
    required this.productData,
    required this.productDataDetails,
  });

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _demandOnType;
  late TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productData['name']);
    _description = TextEditingController(
        text: widget.productData['description'].toString());
    _quantityController =
        TextEditingController(text: widget.productData['quantity'].toString());
    _priceController = TextEditingController(
      text: (widget.productData['product_type'] == 'New' ||
              widget.productData['product_type'] == 'Used' ||
              widget.productData['product_type'] == 'new' ||
              widget.productData['product_type'] == 'used' ||
              widget.productData['product_type'] == 'جديد' ||
              widget.productData['product_type'] == 'مستعمل')
          ? widget.productDataDetails['price'].toString()
          : widget.productDataDetails['state_free'].toString(),
    );
    _demandOnType = TextEditingController(
      text: (widget.productData['product_type'] == 'New' ||
              widget.productData['product_type'] == 'new' ||
              widget.productData['product_type'] == 'جديد')
          ? widget.productDataDetails['warranty_period'].toString()
          : widget.productDataDetails['product_condition'].toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _demandOnType.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> updateProduct(int productId, String name, String type,
      String prodState, int quantity, String cond) async {
    final response = await http.put(
      Uri.parse('http://$ip:3000/tradetryst/product/updateSellarProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'productId': productId,
        'name': name,
        'type': type,
        'prodState': prodState,
        'quantity': quantity,
        'cond': cond,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String theText = (widget.productData['product_type'] == 'New' ||
            widget.productData['product_type'] == 'new' ||
            widget.productData['product_type'] == 'جديد')
        ? 'warranty period'
        : 'product condition';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Product',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Color(0xFF0D6775),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productData['name'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productData['description'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Product Quantity',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productData['quantity'].toString(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productDataDetails.containsKey('price')
                      ? widget.productDataDetails['price'].toString()
                      : widget.productDataDetails['state_free'].toString(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _demandOnType,
                decoration: InputDecoration(
                  labelText: 'Product $theText',
                  labelStyle: TextStyle(color: Color(0xFF0D6775), fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0D6775),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: widget.productDataDetails
                          .containsKey('warranty_period')
                      ? widget.productDataDetails['warranty_period'].toString()
                      : widget.productDataDetails['product_condition']
                          .toString(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product $theText';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40, bottom: 40, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomeButton2(
                      text: 'Cancel',
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    CustomeButton2(
                      text: 'Update',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await updateProduct(
                            widget.productData['product_id'],
                            _nameController.text.isEmpty
                                ? widget.productData['name']
                                : _nameController.text,
                            widget.productData['product_type'],
                            _priceController.text.isEmpty
                                ? (widget.productDataDetails
                                        .containsKey('price')
                                    ? widget.productDataDetails['price']
                                        .toString()
                                    : widget.productDataDetails['state_free']
                                        .toString())
                                : _priceController.text,
                            int.parse(_quantityController.text.isEmpty
                                ? widget.productData['quantity'].toString()
                                : _quantityController.text),
                            _demandOnType.text.isEmpty
                                ? (widget.productDataDetails
                                        .containsKey('warranty_period')
                                    ? widget
                                        .productDataDetails['warranty_period']
                                        .toString()
                                    : widget
                                        .productDataDetails['product_condition']
                                        .toString())
                                : _demandOnType.text,
                          );
                          await SellarPageState.getProductOfSellar(Login.idd);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/