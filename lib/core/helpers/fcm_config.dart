import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

requestPermissionNotification() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

fcmConfig() {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  firebaseMessaging.getToken().then((token) {
    log("firebase token is $token");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showNotification(message);
    log('================== Notification ==================');
    log('Message title: ${message.notification!.title}');
    log('Message body: ${message.notification!.body}');
  });
}

void showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'custom_notification_channel_id',
    'com.hamdy_khalid_dawood.quran_app',
    channelDescription: "sadasdad",
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}
