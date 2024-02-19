// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:jokes_ai_app/providers/notifications.dart';
// import 'package:provider/provider.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class LocalNotifications {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// //on tap of the notification
//   static void onNotificationTap(NotificationResponse notificationResponse) {}

//   //Initialise the plugin
//   static Future init() async {
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: (id, title, body, payload) => null);
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onNotificationTap,
//       onDidReceiveBackgroundNotificationResponse: onNotificationTap,
//     );
//   }

//   //show simple notification

//   static Future showSimpleNotification(
//       {required String title,
//       required String body,
//       required String payload}) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('you', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }

//   // Show Periodic Notification at regular intervals
//   static Future showPeriodicNotifications(
//       {required String title,
//       required String body,
//       required String payload}) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel 2', 'your name',
//             channelDescription: 'your description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         0, title, body, RepeatInterval.everyMinute, notificationDetails);
//   }

// // Shedule Notifications
//   static Future sheduleNotifications(BuildContext context) async {
//     String? notificationBody =
//         await Provider.of<NotificationProvider>(context, listen: false)
//             .sendRequest();
//     tz.initializeTimeZones();
//     var localTime = tz.local;

//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel 3', 'your name',
//             channelDescription: 'your description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       2,
//       "test",
//       notificationBody,
//       tz.TZDateTime.now(localTime).add(const Duration(seconds: 5)),
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: "payload",
//     );
//   }

//   static Future cancel(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }
// }
