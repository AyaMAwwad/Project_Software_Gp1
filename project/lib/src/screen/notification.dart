import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/src/app.dart';
import 'package:project/src/chat/notification_service.dart';
import 'package:project/src/screen/login_screen.dart';

class FirebaseNotification {
  static final firebaseMsg = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    await firebaseMsg.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  static Future getDiveceToken() async {
    final fcmToken = await firebaseMsg.getToken();
    // print('Token: ${fcmToken}');
    bool isUserLog = LoginScreen.isUserLog;
    if (isUserLog) {
      await CRUDService.saveUserToken(fcmToken!);
      // print('save token');
    }
    firebaseMsg.onTokenRefresh.listen((event) async {
      if (isUserLog) {
        await CRUDService.saveUserToken(fcmToken!);
        // print('save token');
      }
    });
  }

  static Future localNotification() async {
    const AndroidInitializationSettings initSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings drawInitSetting =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings linuxInitSetting =
        LinuxInitializationSettings(defaultActionName: 'Open notifications');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initSettingAndroid,
      iOS: drawInitSetting,
      linux: linuxInitSetting,
    );
    flutterLocalNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    flutterLocalNotification.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static void onNotificationTap(NotificationResponse response) {
    navigatorKey.currentState!
        .pushNamed('notification'); //, arguments: response
  }

  static Future showNotification(
    String title,
    String body,
    String payload,
  ) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelID', 'channelName',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotification.show(0, title, body, notificationDetails,
        payload: payload);
  }
}
