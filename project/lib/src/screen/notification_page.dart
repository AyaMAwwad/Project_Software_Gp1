import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/src/screen/detailpage.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/login_screen.dart';
import 'package:project/src/screen/notification_send_msg.dart';
import 'package:project/src/screen/order_tracking_page.dart';
import 'package:project/src/screen/payment.dart';
import 'package:project/widgets/bottom_nav.dart';
import 'package:project/widgets/cart_item.dart';
import 'package:project/widgets/cart_shop.dart';
import 'package:project/widgets/recent_prod.dart';

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
          notifications = snapshot.docs.map((doc) {
            var data = doc.data();
            data['id'] = doc.id; // Include the document ID
            return data;
          }).toList();
        });
      } catch (e) {
        print('Failed to fetch notifications: $e');
      }
    }
  }

  Future<void> markAsRead(String docId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .doc(docId)
            .update({'isRead': true});
      } catch (e) {
        print('Failed to mark notification as read: $e');
      }
    }
  }

  Future<void> deleteNotification(int index, String docId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(user.email)
            .collection('userNotifications')
            .doc(docId)
            .delete();

        setState(() {
          notifications.removeAt(index);
        });

        print('Notification deleted successfully');
      } catch (e) {
        print('Failed to delete notification: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    top: 0), //notifications[0]['isRead'] == true ? 20 :
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (notifications[index]['title'] ==
                            '[Private Reminder]') {
                          CartState().resetCart();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartShop()));
                        } else if (notifications[index]['title'] ==
                            'New Collection') {
                          CartState().resetCart();
                          print('**** itemsToNotify $productFromNotificaiom');
                          print('**** idx $idx');
                          //     HomePageState.InteractionOfUser(Login.idd,
                          //      itemsToNotify[idx]['product_id'], 1, 0, 0);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                categoryName: productFromNotificaiom[idx]
                                    ['name'],
                                imagePaths: productFromNotificaiom[idx]
                                    ['image'],
                                price: productDetailFromNotificaiom[idx]
                                    ['price'],
                                productid: productFromNotificaiom[idx]
                                    ['product_id'],
                                Typeproduct: productFromNotificaiom[idx]
                                    ['product_type'],
                                quantity: productFromNotificaiom[idx]
                                    ['quantity'],
                                name: productFromNotificaiom[idx]['name'],
                                description: productFromNotificaiom[idx]
                                    ['description'],
                              ),
                            ),
                          );

                          ///// need to update to new collection page or details of product that added
                        } else if (notifications[index]['title'] ==
                            'Rating Products') {
                          if (!CartItemState.flagIsOrder) {
                            RecentSingleProdState.showRatingDialog(
                                idOfProductForRating,
                                imageOfProductForRating,
                                nameOfProductForRating);
                          } else if (CartItemState.flagIsOrder) {
                            Payment.showRatingDialog();
                            CartItemState.flagIsOrder = false;
                          }
                        } else if (notifications[index]['title'] ==
                            'Track Your Order') {
                          CartState().resetCart();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderTrackingPage()));
                        }

                        // Mark the notification as read
                        await markAsRead(notifications[index]['id']);

                        setState(() {
                          notifications[index]['isRead'] = true;
                        });
                      },
                      child: Container(
                        //   margin: EdgeInsets.only(bottom: 1),
                        color: notifications[index]['isRead'] == true
                            ? Colors.white
                            : Color.fromARGB(255, 2, 92, 123).withOpacity(0.2),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          /* leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              notifications[index]['image'] ??
                                  'https://www.bing.com/images/search?view=detailV2&ccid=uMP4HQdF&id=77C0503E04B36E49058030F9D5B6BB441445CD38&thid=OIP.uMP4HQdFdx0GhrgPe6iH_AHaEo&mediaurl=https%3a%2f%2fwallpapercave.com%2fwp%2fwp3269246.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.b8c3f81d0745771d0686b80f7ba887fc%3frik%3dOM1FFES7ttX5MA%26pid%3dImgRaw%26r%3d0&exph=1600&expw=2560&q=Light+Grey+Wallpaper&simid=608001429529758255&FORM=IRPRST&ck=4AE198059604041A1EC176B312C4440A&selectedIndex=2&itb=0&ajaxhist=0&ajaxserp=0',
                            ),
                            radius: 25,
                          ),*/
                          title: Text(
                            notifications[index]['title'],
                            style: TextStyle(
                              color: Color.fromARGB(255, 2, 92, 123),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notifications[index]['body']),
                              SizedBox(height: 5),
                              Text(
                                notifications[index]['timestamp'] != null
                                    ? (notifications[index]['timestamp']
                                            as Timestamp)
                                        .toDate()
                                        .toString()
                                    : 'N/A',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<int>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            onSelected: (value) {
                              if (value == 1) {
                                deleteNotification(
                                    index, notifications[index]['id']);
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(
                                      IconsaxBold.close_square,
                                      color: Color.fromRGBO(2, 92, 123, 1),
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Remove this notification',
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 2, 92, 123),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
