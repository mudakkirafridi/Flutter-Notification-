import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/view/chat.dart';
import 'package:notification/view/home.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initLocalNoti(BuildContext context, RemoteMessage message) async {
    var androidNotificationinitial =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosNotificationinitial = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidNotificationinitial, iOS: iosNotificationinitial);
    await notificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          handelMessage(context, message);
        });
  }

  firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification!.title);
      debugPrint(message.notification!.body);
      debugPrint(message.data.toString());
      debugPrint(message.data['id']);
      debugPrint(message.data['type ']);
      if (Platform.isAndroid) {
        initLocalNoti(context, message);
showNotification(message);
      }else{
        showNotification(message);
      }
      
    });
  }

 Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel notificationChannel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(),
        "High Importance Notification",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            notificationChannel.id, notificationChannel.name,
            priority: Priority.high,
            importance: Importance.high,
            ticker: 'ticker',
            channelDescription: 'our channel description');
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    Future.delayed(Duration.zero, () {
      notificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails);
    });
  }

  requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('authorized');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('provisional');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      debugPrint('cancel');
    }
  }

  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    debugPrint(token);
    return token;
  }

  handelMessage(BuildContext context , RemoteMessage message){
    if (message.data['type'] == 'chat') {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  ChatScreen(
        id: message.data['id'],
      )));
    }
  }
}
