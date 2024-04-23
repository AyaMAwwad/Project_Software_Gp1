import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  State<AboutUsPage> createState() => about();
}

class about extends State<AboutUsPage> {
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
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back when back arrow is pressed
                },
              ),
              SizedBox(width: 5),
              Text(
                'About Us',
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
      //  ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Our Team Members",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Meet the amazing people behind our app! \nOur team consists of dedicated individuals who are passionate about creating innovative solutions to meet the needs of our users. From developers to designers, each member has a unique set of distinct skills and experiences. We constantly cooperate with each other to provide the best possible.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTeamMember(
              name: "Ibtisam kharrosheh",
              position: "Developer",
              image: "images/icon/ibtisam.jpg",
            ),
            buildTeamMember(
              name: "Aya Moin",
              position: "Developer",
              image: "images/icon/aega.jpeg",
            ),
            // Add more team members here as needed
          ],
        ),
      ),
    );
  }

  Widget buildTeamMember({
    required String name,
    required String position,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40, // Increase the radius to increase the size of the image
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                position,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
