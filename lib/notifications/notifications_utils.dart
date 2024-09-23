// import 'dart:async';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
//
// /* *********************************************
//     PERMISSIONS
// ************************************************ */
//
// class PrayerNotifications {
//   notifications() async {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
//       // awaitDeterminePosition();
//       if (!isAllowed) {
//         // This is just a basic example. For real apps, you must show some
//         // friendly dialog box before call the request method.
//         // This is very important to not harm the user experience
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       } else {
//         NotificationUtils.showAlarmNotificationProphet(id: 13);
//         NotificationUtils.showAlarmNotificationAzkarSabah(id: 14);
//         NotificationUtils.showAlarmNotificationAzkarMasaa(id: 15);
//       }
//     });
//   }
// }
//
// class NotificationUtils {
//   //*********************************// Prophet Muhammed //**********************//
//   static Future<void> showAlarmNotificationProphet({
//     required int id,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id,
//         channelKey: 'basic_channel',
//         groupKey: 'basic_channel',
//         title: 'صّلِ عَلۓِ مُحَمد',
//         body: 'اللهم صّلِ وسَلّمْ عَلۓِ نَبِيْنَا مُحَمد ﷺ',
//         displayOnBackground: true,
//         displayOnForeground: true,
//         wakeUpScreen: true,
//         category: NotificationCategory.Reminder,
//         autoDismissible: true,
//         customSound: 'resource://raw/res_notifications',
//       ),
//       schedule: NotificationCalendar(
//         preciseAlarm: true,
//         allowWhileIdle: true,
//         repeats: true,
//         hour: 16,
//         minute: 5,
//         second: 00,
//       ),
//     );
//   }
//
//   static Future<void> showAlarmNotificationAzkarSabah({
//     required int id,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id,
//         channelKey: 'alert_channel',
//         groupKey: 'alert_channel',
//         title: 'اذكار الصباح',
//         body: 'هل اكملت اذكار الصباح ؟',
//         displayOnBackground: true,
//         displayOnForeground: true,
//         wakeUpScreen: true,
//         category: NotificationCategory.Reminder,
//         autoDismissible: true,
//       ),
//       schedule: NotificationCalendar(
//         preciseAlarm: true,
//         allowWhileIdle: true,
//         repeats: true,
//         hour: 16,
//         minute: 7,
//         second: 00,
//       ),
//     );
//   }
//
//   static Future<void> showAlarmNotificationAzkarMasaa({
//     required int id,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id,
//         channelKey: 'alert_channel',
//         groupKey: 'alert_channel',
//         title: 'اذكار المساء',
//         body: 'هل اكملت اذكار المساء ؟',
//         displayOnBackground: true,
//         displayOnForeground: true,
//         wakeUpScreen: true,
//         category: NotificationCategory.Reminder,
//         autoDismissible: true,
//       ),
//       schedule: NotificationCalendar(
//         preciseAlarm: true,
//         allowWhileIdle: true,
//         repeats: true,
//         hour: 19,
//         minute: 00,
//         second: 00,
//       ),
//     );
//   }
//
//   String toTwoDigitString(int value) {
//     return value.toString().padLeft(2, '0');
//   }
// }
