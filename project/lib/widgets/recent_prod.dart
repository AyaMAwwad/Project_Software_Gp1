// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class RecentProd extends StatelessWidget {
  final prodList = [
    {
      'name': 'yyy',
      'image': 'images/icon/jec_men.png',
      'price': 50,
      'description': '7777',
    },
    {
      'name': 'aaa',
      'image': 'images/icon/jec_men.png',
      'price': 80,
      'description': 'dada',
    },
    {
      'name': 'aya',
      'image': 'images/icon/jec_men.png',
      'price': 90,
      'description': 'jadja',
    },
    {
      'name': 'aya',
      'image': 'images/icon/jec_men.png',
      'price': 110,
      'description': 'sjajsa',
    },
    {
      'name': 'aya',
      'image': 'images/icon/jec_men.png',
      'price': 110,
      'description': 'sjajsa',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: prodList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.70),
      itemBuilder: (BuildContext context, int index) {
        return RecentSingleProd(
          recet_prod_description: prodList[index]['description'],
          recet_prod_name: prodList[index]['name'],
          recet_prod_image: prodList[index]['image'],
          recet_prod_price: prodList[index]['price'],
        );
      },
    );
  }
}

class RecentSingleProd extends StatefulWidget {
  final recet_prod_name;
  final recet_prod_image;
  final recet_prod_price;
  final recet_prod_description;

  const RecentSingleProd(
      {super.key,
      this.recet_prod_name,
      this.recet_prod_image,
      this.recet_prod_price,
      this.recet_prod_description});

  @override
  State<RecentSingleProd> createState() => _RecentSingleProdState();
}

class _RecentSingleProdState extends State<RecentSingleProd> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: 180,
          //height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 239, 237, 245),
          ),

          child: Column(
            children: [
              Container(
                width: 160,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                // child: Text(recet_prod_name), //
                child: Image.asset(widget.recet_prod_image),
              ),
              ListTile(
                title: Text(widget.recet_prod_name),
                subtitle: Text(widget.recet_prod_description),
                trailing: Text('\$${widget.recet_prod_price}'),
                //subtitle: Text('\$${recet_prod_price}'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
