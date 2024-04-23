import 'package:flutter/material.dart';

class InformationsPage extends StatelessWidget {
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
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10),
              Text(
                'Trade Tryst Information',
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Trade Tryst',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vehicula magna sit amet justo ultricies, non fringilla mauris varius. Integer euismod ligula sit amet risus pharetra, et vulputate nisi lacinia. Mauris nec lorem neque. Fusce auctor libero sed augue vestibulum, a tincidunt est malesuada. Sed scelerisque neque nunc, vel laoreet tortor tempor in. Integer id enim quis justo vestibulum fermentum ac sed turpis. Vivamus in justo vestibulum, molestie quam et, fringilla est. Sed euismod ullamcorper dolor non cursus. Pellentesque blandit dolor nisi, et maximus quam pretium sed.',
              'An application specialized in the field of commercial advertising, which enables users, whether sellers or buyers, to buy and sell new or used products and offer and request services very quickly and with the least possible effort. Our goal with the application is to give a new life to goods that you do not use or need. Through the application, the user can disseminate these goods and earn additional income by selling them to those who need them. On the other hand, the user who needs these goods can buy them at a lower price than buying them new from the market or shops. Thus, the seller has earned extra money, and the buyer has saved money by purchasing an item in good, usable condition. The application also provides some free goods, as The user can also provide the product for free without financial profits to help people in need as a form of donation.',

              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Technologies Used:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Flutter\n'
              '- Node.js\n'
              '- MySQL',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
