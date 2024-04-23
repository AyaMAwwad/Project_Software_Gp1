// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    // Fetch notifications for the current user from Firestore
    getNotificationsForCurrentUser();
  }

  Future<void> getNotificationsForCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .orderBy('timestamp', descending: true)
            .get();
        setState(() {
          notifications = snapshot.docs.map((doc) => doc.data()).toList();
        });
      } catch (e) {
        print('Failed to fetch notifications: $e');
      }
    }
  }

  Future<void> deleteNotification(int index, String title, String body) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Query the collection to find the document ID associated with the notification
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .where('title', isEqualTo: title)
            .where('body', isEqualTo: body)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // Get the document ID of the first matching document
          String notificationId = snapshot.docs.first.id;

          // Delete the notification document
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(user.email)
              .collection('userNotifications')
              .doc(notificationId)
              .delete();

          setState(() {
            notifications.removeAt(index);
          });

          print('Notification deleted successfully');
        } else {
          print('Notification not found');
        }
      } catch (e) {
        print('Failed to delete notification: $e');
      }
    }
  }

/*
  Future<void> deleteNotification(int index,String title,String body ) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final notificationId = notifications[index]['uid'];
        print(notificationId);
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .doc('y0ghEhyxygNIjsWn5DT3')
            .delete();

        setState(() {
          notifications.removeAt(index);
        });
        print('Notification deleted successfully');
      } catch (e) {
        print('Failed to delete notification: $e');
      }
    }
  }*/
  /* remove all notifications
        setState(() {
          notifications = notifications
              .where((notification) => notification['id'] != notificationId)
              .toList();
        });
*/

/*
  // Function to delete a notification from Firestore
  Future<void> deleteNotification(int index) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        print(user.email);

        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .doc(notifications[index][
                'uid']) // Assuming 'id' is the unique identifier of the notification
            .delete();

        setState(() {
          notifications.removeAt(index);
        });
      } catch (e) {
        print('Failed to delete notification: $e');
      }
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    print(notifications);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 92, 123),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Notifications',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              height: 645.4545,
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Card(
                      elevation: 3,
                      child: /*ListTile(
                        title: Text(
                          notifications[index]['title'],
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 92, 123),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notifications[index]['body'],
                        ),
                        trailing: Expanded(
                          child: PopupMenuButton<int>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey, // Example: grey color
                            ),
                            onSelected: (value) {
                              if (value == 1) {
                                deleteNotification(index);
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                value: 1,
                                child: Text('Remove'),
                              ),
                            ],
                          ),
                        ),
                      ),*/
                          ListTile(
                        title: Text(
                          notifications[index]['title'],
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 92, 123),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notifications[index]['body'],
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(
                              right: 0), // Adjust padding as needed
                          child: PopupMenuButton<int>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey, // Example: grey color
                            ),
                            onSelected: (value) {
                              if (value == 1) {
                                print(index);
                                deleteNotification(
                                    index,
                                    notifications[index]['title'],
                                    notifications[index]['body']);
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                value: 1,
                                child: Text('Remove'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    // Fetch notifications for the current user from Firestore
    getNotificationsForCurrentUser();
  }

  Future<void> getNotificationsForCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .orderBy('timestamp', descending: true)
            .get();
        setState(() {
          notifications = snapshot.docs.map((doc) => doc.data()).toList();
        });
      } catch (e) {
        print('Failed to fetch notifications: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 92, 123),
      //  backgroundColor: Colors.blueGrey[50],
      /*  appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: ,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white, // Color.fromARGB(255, 2, 92, 123),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Notifications',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              //margin: ,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              height: 645.4545,
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Card(
                      elevation: 3,
                      // shape: RoundedRectangleBorder(
                      // borderRadius: BorderRadius.circular(12),
                      //   ),
                      child: ListTile(
                        title: Text(
                          notifications[index]['title'],
                          style: TextStyle(
                            color: Color.fromARGB(255, 2, 92, 123),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notifications[index]['body'],
                        ),
                        // Add more UI components to display notification details
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
