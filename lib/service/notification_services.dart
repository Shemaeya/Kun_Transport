import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
 

  initializeNotification() async {
    tz.initializeTimeZones();
    final initializationSettingsIOS = DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      if (payload != null) {
        print('notification payload: $payload');
      } else {
        print("Notification Done");
      }
      Get.to(() => Container(color: Colors.white));
    });
  }

  displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  scheduledNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'KUNTRANSPORT',
        'Votre voiture arrive dans un instant',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel name', 'your channel description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );

    Get.dialog(const Text("welcome to KunTransport"));
  }

  // Initialise les notifications locales
  initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);
  }

  // Gère l'action lorsque l'utilisateur appuie sur la notification
  selectNotification(NotificationResponse notificationResponse) async {
    // Insérer ici le code pour gérer l'action lorsque l'utilisateur appuie sur la notification
    //  showDialog(
    //   context: context,
    //   builder: (_) => AlertDialog(
    //     title: Text('Notification'),
    //     content: Text('L\'utilisateur a passé une commande de voiture.'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: Text('Fermer'),
    //       ),
    //     ],
    //   ),);
  }

  // Envoie une notification
  sendNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      // 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Nouvelle commande de voiture',
      'Une nouvelle commande de voiture a été passée.',
      platformChannelSpecifics,
      payload: 'notification',
    );
  }

//Send notification to Admin

  sendPushMessage(String deviceToken, String title, String body) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'key=AAAAz3te1S0:APA91bFXzYPGPY6qC5w2nCyeSn_QMsJOWkh8WLjfNliTuTZuCsln57ce9mJBFYiw5g-7Q3zpSQzI2A8zK4nnO8eM-Nk9jUxJphAKdjmatxM57ouMCUg6dumGXpft1gxQfmOmTN4Pt7QR', // Replace with your FCM server key
    };

    final message = {
      'to': deviceToken,
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
      },
    };

    final response = await http.post(
      Uri.parse(postUrl),
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Push message sent successfully.');
    } else {
      print('Error sending push message: ${response.statusCode}');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }
}

// class MessagingHelper {
//   Future<void> sendNotification() async {
//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//     const String adminDeviceToken = '<ADMIN_DEVICE_TOKEN>';

//   await _firebaseMessaging.send(
//     RawMessage(
//       data: {
//         'notification': {
//           'title': 'Nouvelle commande de voiture',
//           'body': 'Une nouvelle commande de voiture a été passée.',
//         },
//       },
//       token: adminDeviceToken,
//     ),
//   );
//     }
// }
