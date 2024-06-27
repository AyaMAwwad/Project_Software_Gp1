import 'dart:convert';
//import 'dart:ffi';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/src/screen/ipaddress.dart';
import 'package:project/src/screen/user_show_percentage.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int totalProducts = 0;
  int totalProductsSold = 0;
  double percetagesold = 0.0;
  double totalpricesoldproduct = 0.0;
  //
  double sumProfitPercentage = 0.0;
  bool showChart = false; // Add this line

  double sumProfit = 0.0;
  @override
  void initState() {
    super.initState();
    fetchTotalProducts();
    fetchTotalProductsSold();
    fetchTotalRevenue();
  }

  Future<void> fetchTotalProducts() async {
    final url = Uri.parse(
        'http://$ip:3000/tradetryst/totalnumproductt/totalproduct'); // http://$ip:3000/tradetryst/orderproduct/productlistt
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        totalProducts = data['totalProducts'];
      });
    } else {
      print('Failed to load total products');
    }
  }
// product pay or solddddd

  Future<void> fetchTotalProductsSold() async {
    final url = Uri.parse(
        'http://$ip:3000/tradetryst/totalnumproductt/totalproductsold');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        totalProductsSold = data['totalProductsSold'];
        calpercentagesold();
      });
    } else {
      print('Failed to load total products sold');
    }
  }

//percentageSold = total

// end

  void calpercentagesold() {
    if (totalProducts > 0) {
      percetagesold = (totalProductsSold / totalProducts) * 100;
      print('\n percentagesold $percetagesold \n ');
    } else {
      percetagesold = 0.0;
      print('\n percentagesold $percetagesold \n ');
    }
  }

  Future<void> fetchTotalRevenue() async {
    final url =
        Uri.parse('http://$ip:3000/tradetryst/totalnumproductt/totalrevenue');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Total Revenue JSON: $data'); // Debugging line
      setState(() {
        totalpricesoldproduct =
            double.tryParse(data['totalRevenue'].toString()) ?? 0.0;
        final productsWithAdminProfit =
            data['productsWithAdminProfit']; // Get products with admin profit
        // Process productsWithAdminProfit if needed
        print('Total Revenue: $totalpricesoldproduct'); // Debugging line
        print('Total Products: $productsWithAdminProfit'); // Debugging line
        //  double sumProfitPercentage = 0.0;

        //   double sumProfit = 0.0;

        for (var product in productsWithAdminProfit) {
          sumProfitPercentage +=
              double.parse(product['profitPercentage'].toString());
          sumProfit += double.parse(product['adminProfit'].toString());
        }
        print('Sum of Profit Percentages: $sumProfitPercentage');
        print('Sum of Profit: $sumProfit');
      });
    } else {
      print('Failed to load total revenue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 36, 80, 95), // Background color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, // Change your color here
            ),
            title: Text(
              '182'.tr,
              style: TextStyle(
                fontSize: 22,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // add
            actions: <Widget>[],

            // add icon notification
            backgroundColor: Colors
                .transparent, // Make AppBar transparent to show Container's decoration
            elevation: 0, // Remove AppBar shadow

            //centerTitle: true,
          ),
        ),
      ),

      /*AppBar(
        title: Text('Statistics'),
        backgroundColor: Color.fromARGB(255, 36, 80, 95),
      ),*/
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* buildStatisticCard('Total Products', totalProducts.toString()),
            buildStatisticCard('Products Sold', totalProductsSold.toString()),
            buildStatisticCard('Percentage Sold', '${percetagesold.toStringAsFixed(2)}%'),
            buildStatisticCard('Total Revenue', '\$${totalpricesoldproduct.toStringAsFixed(2)}'),
            buildStatisticCard('Total Admin Profit Percentage', '${sumProfitPercentage.toStringAsFixed(2)}%'),
            buildStatisticCard('Total Admin Profit', '\$${sumProfit.toStringAsFixed(2)}'),
            SizedBox(height: 20),*/
            buildStatisticCard('183'.tr, totalProducts.toString(),
                Icons.production_quantity_limits, Colors.blue),
            buildStatisticCard('184'.tr, totalProductsSold.toString(),
                Icons.sell, Colors.green),
            buildStatisticCard('185'.tr, '${percetagesold.toStringAsFixed(2)}%',
                Icons.pie_chart, Colors.orange),
            buildStatisticCard(
                '186'.tr,
                '\$${totalpricesoldproduct.toStringAsFixed(2)}',
                Icons.attach_money,
                Colors.purple),
            buildStatisticCard(
                '194'.tr,
                '${sumProfitPercentage.toStringAsFixed(2)}%',
                Icons.percent,
                Colors.red),
            buildStatisticCard('195'.tr, '\$${sumProfit.toStringAsFixed(2)}',
                Icons.account_balance_wallet, Colors.teal),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showChart = !showChart;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 36, 80, 95),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(showChart ? '189'.tr : '190'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            SizedBox(height: 40),
            if (showChart) // Add this line
              Column(
                children: [
                  Text(
                    '191'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Color.fromARGB(255, 43, 120, 143),
                            value: percetagesold,
                            title: '${percetagesold.toStringAsFixed(2)}%',
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Color.fromARGB(255, 8, 113, 103),
                            value: sumProfitPercentage,
                            title: '${sumProfitPercentage.toStringAsFixed(2)}%',
                            radius: 50,
                            titleStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Color.fromARGB(255, 199, 198,
                                198), //Color.fromARGB(255, 185, 184, 184),
                            value: 100 - percetagesold,
                            title: '',
                            radius: 50,
                          ),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                  buildLegendItem(Color.fromARGB(255, 43, 120, 143),
                      '185'.tr), // Color.fromARGB(255, 43, 120, 143),
                  buildLegendItem(Color.fromARGB(255, 8, 113, 103), '196'.tr),
                  buildLegendItem(
                      const Color.fromARGB(255, 199, 198, 198), '193'.tr),
                ],
              ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserShowPercentage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Show User Percentages',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Widget buildStatisticCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
 */ //
  /// }
  ///
  Widget buildStatisticCard(
      String title, String value, IconData icon, Color iconColor) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          value,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: iconColor),
        ),
      ),
    );
  }
}

Widget buildLegendItem(Color color, String text) {
  return Row(
    children: [
      Container(
        width: 16,
        height: 16,
        color: color,
      ),
      SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}

/*
// ibtisam
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        backgroundColor: Color.fromARGB(255, 36, 80, 95),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Text(
              
              'Total Products:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$totalProducts', // Replace with actual value
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'product Sold:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$totalProductsSold', // Replace with actual value
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Percentage Sold:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${percetagesold.toStringAsFixed(2)}%', // Replace with actual value
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 16),
             Text(
              'Total Revenue:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$totalpricesoldproduct', // Replace with actual value
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Add more statistics widgets as needed
             SizedBox(height: 16),
            Text(
          'Total Admin Profit Percentage:' ,  /// 'Sum of Profit Percentages:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${sumProfitPercentage.toStringAsFixed(2)}%', // Replace with actual value
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
           'Total Admin Profit:', //  'Sum of Profit:',
              style: TextStyle(fontSize: 18),
            ),
             Text(
              '$sumProfit', // Replace with actual value
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ), SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: percetagesold,
                      title: '${percetagesold.toStringAsFixed(2)}%',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                     PieChartSectionData(
                      color: const Color.fromARGB(255, 18, 20, 22),
                      value: sumProfitPercentage,
                      title: '${sumProfitPercentage.toStringAsFixed(2)}%',
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
                      value: 100 - percetagesold,
                      title: '',
                      radius: 50,
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
// ibtisam

/*import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
class StatisticsPage extends StatelessWidget {
  //Future<Map<String, dynamic>> statisticsFuture;

 // StatisticsPage() {
 //  statisticsFuture = fetchStatistics() as Future<Map<String, dynamic>>;
 // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        backgroundColor: Color.fromARGB(255, 36, 80, 95),
      ),
     // body:
      /* FutureBuilder<Map<String, dynamic>>(
        future: statisticsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
*/

            final stats = snapshot.data!;
            final totalProducts = stats['totalProductsSold'];
            final productsSold = stats['productsSold'];

            // Calculate percentage of products sold
            final percentageSold = (productsSold / totalProducts) * 100;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Total Products Sold: $productsSold',
                      style: TextStyle(fontSize: 18)),
                  Text('Percentage Sold: ${percentageSold.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 18)),
                  Text('Total Revenue: \$${stats['totalRevenue']}',
                      style: TextStyle(fontSize: 18)),
                  // Add more statistics as needed
                ],
              ),
            );
         // }
        //},
      );
    //);
  }

  Future<http.Response> fetchStatistics() {
  return http.get(Uri.parse('https://api.example.com/statistics'));
}
}*/