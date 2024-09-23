import 'package:firebase_messaging/firebase_messaging.dart';

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
    print("firebase token is $token");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('================== Notification ==================');
    print('Message title: ${message.notification!.title}');
    print('Message body: ${message.notification!.body}');
  });
}
