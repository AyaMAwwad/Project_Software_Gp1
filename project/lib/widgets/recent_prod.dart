// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class RecentProd extends StatelessWidget {
  final String category;
  final String type;

  RecentProd({required this.category, required this.type});

  final prodList = [
    {
      'name': 'Sweatshirt',
      'image': 'images/icon/clo_A.png',
      'price': 50,
      'description': '7777',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/clo_B.jpeg',
      'price': 220,
      'description': 'dada',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/clo_C.jpeg',
      'price': 150,
      'description': 'jadja',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'Howdy',
      'image': 'images/icon/clo_D.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Men',
      'type': 'New',
    },
    {
      'name': 'Crossbody Bag',
      'image': 'images/icon/bag1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'New',
    },
    {
      'name': 'School Bag',
      'image': 'images/icon/bag2.jpeg',
      'price': 80,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'New',
    },
    {
      'name': 'White Bag',
      'image': 'images/icon/bag3.jpeg',
      'price': 120,
      'description': 'sjajsa',
      'category': 'Bags',
      'type': 'New',
    },
    {
      'name': 'Black Glasses',
      'image': 'images/icon/glas1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Glasses',
      'type': 'New',
    },
    {
      'name': 'Black Glasses',
      'image': 'images/icon/glas2.png',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Glasses',
      'type': 'New',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/watch1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'New',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/clo1.jpeg',
      'price': 150,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'New',
    },
    {
      'name': 'Watch',
      'image': 'images/icon/clo2.jpeg',
      'price': 100,
      'description': 'sjajsa',
      'category': 'Clock',
      'type': 'New',
    },
    {
      'name': 'Blazer & Pants',
      'image': 'images/icon/wom1.jpeg',
      'price': 200,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'Bizwear',
      'image': 'images/icon/wom2.jpeg',
      'price': 130,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'jacket',
      'image': 'images/icon/wom3.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'Dress',
      'image': 'images/icon/dress.jpeg',
      'price': 180,
      'description': 'sjajsa',
      'category': 'Women',
      'type': 'New',
    },
    {
      'name': 'shoes Men',
      'image': 'images/icon/sho1.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'New',
    },
    {
      'name': 'shoes Women',
      'image': 'images/icon/sho22.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'New',
    },
    {
      'name': 'Heeles',
      'image': 'images/icon/sho3.jpeg',
      'price': 110,
      'description': 'sjajsa',
      'category': 'Shoes',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids1.jpeg',
      'price': 90,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids2.jpeg',
      'price': 70,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids3.jpeg',
      'price': 120,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
    {
      'name': 'Kids',
      'image': 'images/icon/kids4.jpeg',
      'price': 80,
      'description': 'sjajsa',
      'category': 'Kids',
      'type': 'New',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredType =
        prodList.where((product) => product['type'] == type).toList();
    final List<Map<String, dynamic>> filteredProducts = filteredType
        .where((product) => product['category'] == category)
        .toList();
    return GridView.builder(
      itemCount: filteredProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.70),
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: RecentSingleProd(
            recet_prod_description: filteredProducts[index]['description'],
            recet_prod_name: filteredProducts[index]['name'],
            recet_prod_image: filteredProducts[index]['image'],
            recet_prod_price: filteredProducts[index]['price'],
          ),
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
    return SingleChildScrollView(
      child: Column(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      widget.recet_prod_image,
                      width: 150,
                      height: 200, // 200
                      fit: BoxFit.cover,
                    ),
                  ),
                  //Image.asset(widget.recet_prod_image),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recet_prod_name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Price:\$${widget.recet_prod_price}',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                    /* Text(
                      widget.recet_prod_description,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),*/
                  ],
                ),
                /* ListTile(
                  title: Text(
                    widget.recet_prod_name,
                    //  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(widget.recet_prod_description),
                  trailing: Text(
                    'Price:\$${widget.recet_prod_price}',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  //subtitle: Text('\$${recet_prod_price}'),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
