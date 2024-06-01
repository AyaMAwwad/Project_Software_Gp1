import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/rolemanagement.dart';
import 'package:project/src/screen/usermanagement.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 80, 95),
        elevation: 40,
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Colors.white), // Change color to white
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      "homepagee"); // This will pop the current route (Drawer)
                },
              ),

              //
              //  actions: [

              // SizedBox(width: 16), // Add spacing between the title and actions
              // ],
              //
              SizedBox(width: 10),
              Text(
                // '1'.tr,
                'Admin Dashboard',
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
      /*appBar: AppBar(
  title: Text(
    'Admin Dashboard',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor: Colors.blue, // You can change the color to match your app's theme
  elevation: 0, // This removes the shadow
  centerTitle: true, // Center the title horizontally
  actions: [
    IconButton(
      icon: Icon(Icons.notifications), // Add an icon for notifications or any other action
      onPressed: () {
        // Add functionality for notifications
      },
    ),
    SizedBox(width: 16), // Add spacing between the title and actions
  ],
),*/

      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          AdminDashboardCard(
            title: 'User Management',
            icon: Icons.person,
            onTap: () {
              //  Navigator.pushNamed(context, UserManagementPage());
              // Get.to(() => AdminDashboard());
              Get.to(() => UserManagementPage());
            },
          ),
          AdminDashboardCard(
            title: 'Role Management',
            icon: Icons.security,
            onTap: () {
              //  Navigator.pushNamed(context, '/role_management');
              Get.to(() => rolemanagement());
            },
          ),
          AdminDashboardCard(
            title: 'Activity Logs',
            icon: Icons.list,
            onTap: () {
              Navigator.pushNamed(context, '/activity_logs');
            },
          ),
          // Add more cards as needed
        ],
      ),
    );
  }
}

class AdminDashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  AdminDashboardCard(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(12.0),
              child: Icon(
                icon,
                size: 45.0,
                color: Color.fromARGB(255, 2, 92, 123),
              ),
            ),
            //Center(child:
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 78, 130, 147),
                  fontSize: 16,
                ),
              ),
            ),
            //  ),
          ],
        ),
      ),
    );
  }
}

/*
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 40.0 , color: Color.fromARGB(255, 2, 92, 123),),
              SizedBox(height: 10.0),
              Text(title, style: GoogleFonts.aBeeZee(
             textStyle:  TextStyle(fontSize: 16.0 , ),
             

              ),
              
              
             ),
            ],
          ),
        ),
       */
/*
 InkWell(
                    
                    
                    child: 
                   
                          Container(
                    
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 1,
                            //  blurRadius: 6,
                          ),
                        ],
                      ),
                     

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(
                            child: Container(
                             
                              width: 80, // Set the desired size of the circle
                              height: 80, // Set the desired size of the circle
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    // Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 147, 198, 215),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 66, 119, 138),
                                    Color.fromARGB(255, 95, 150, 168),
                                    Color.fromARGB(255, 147, 198, 215),
                                  
                                    // Color.fromARGB(255, 95, 150, 168),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                //margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Image.asset(
                                  image,
                                  width: 140,   // ibtisam
                                // width: adjustedWidth,
                                  //height: 30,
                                ),
                              ),
                            ),
                          ),

                         
                          Text(
                            type,
                            style: GoogleFonts.aDLaMDisplay(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 78, 130, 147),
                                // Color.fromARGB(255, 4, 51, 67),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ),
                    // ),
                    // )])),
                  )
                  
                  
                  );




*/
