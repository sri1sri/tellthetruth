//
//import 'package:firebase_admob/firebase_admob.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:provider/provider.dart';
//import 'package:tellthetruth/firebase/custom_cloud_messaging.dart';
//import 'firebase/admobs.dart';
//import 'firebase/auth.dart';
//import 'global_file/common_variables/app_functions.dart';
//import 'landing_page.dart';
////BannerAd bannerAd;
//const MaterialColor white = const MaterialColor(
//  0Xff30D0DB,
//  const <int, Color>{
//    50: const Color(0XffFD8B1F),
//    100: const Color(0XffFD8B1F),
//    200: const Color(0XffFD8B1F),
//    300: const Color(0XffD152E0),
//    400: const Color(0XffD152E0),
//    500: const Color(0XffD152E0),
//    600: const Color(0Xff30D0DB),
//    700: const Color(0Xff30D0DB),
//    800: const Color(0Xff30D0DB),
//    900: const Color(0Xff30D0DB),
//  },
//);
//
//
//void main(){
////  bannerAd = createBannerAd();
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//
//  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//
//  String token;
//
//  Future<String> getToken() async {
//    token = await firebaseMessaging.getToken();
//    return token;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    var initializationSettingsAndroid =
//    new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//
//
//    return Provider<AuthBase>(
//      create: (context) => Auth(),
//      child: MaterialApp(
//        title: 'Tell The Truth',
//        theme: ThemeData(
//          primarySwatch: white,
//        ),
//        debugShowCheckedModeBanner: false,
//        home: LandingPage(),
//        //routes: routes
//      ),
//    );
//  }
//}


import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:tellthetruth/screens/home/feed/display_single_question_page.dart';

import 'firebase/auth.dart';
import 'global_file/common_variables/app_functions.dart';
import 'landing_page.dart';

//BannerAd bannerAd;
const MaterialColor white = const MaterialColor(
  0Xff30D0DB,
  const <int, Color>{
    50: const Color(0XffFD8B1F),
    100: const Color(0XffFD8B1F),
    200: const Color(0XffFD8B1F),
    300: const Color(0XffD152E0),
    400: const Color(0XffD152E0),
    500: const Color(0XffD152E0),
    600: const Color(0Xff30D0DB),
    700: const Color(0Xff30D0DB),
    800: const Color(0Xff30D0DB),
    900: const Color(0Xff30D0DB),
  },
);

void main() {
//  bannerAd = createBannerAd();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  void _settingUpLocalNotification() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print("onDidReceiveLocalNotification: called");
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
//      GoToPage(context,  SingleQuestion(
//        gangDetails: widget.gangDetails,
//        questionDetails: questionData,
//        insightsDetails: insightsData,
//      ), true);
      debugPrint('notification payload: ' + payload);
    }
    print("selectNotification: called");
  }

  void sendNotification(Map<String, dynamic> message) async {
    print("Send Notification: called");
    var _messageString = jsonDecode(jsonEncode(message));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'default_notification_channel_id',
        'your channel name',
        'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        randomBetween(0, 100),
        _messageString['notification']['title'],
        _messageString['notification']['body'],
        platformChannelSpecifics,
        payload: 'item x');
  }

  void dailyNotification(int hour) async{
    var time = Time(hour, 00, 00);
    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        hour == 09 ? 'Good morning, ${USER_NAME}' : hour == 16 ? 'Good evening, ${USER_NAME}' : 'Good night, ${USER_NAME}',
        hour == 09 ? 'Daily notification shown at approximately' : hour == 16 ? 'Daily notification shown at approximately' : 'Daily notification shown at approximately',
        time,
        platformChannelSpecifics);
  }


  @override
  Widget build(BuildContext context) {
    print("Token: Taken");
    dailyNotification(09);
    dailyNotification(16);
    dailyNotification(21);
    _settingUpLocalNotification();
    firebaseMessaging.configure(
      // This will be called when app is in foreground
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        sendNotification(message);
      },

      // This will be called when app is in background
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // Show Local Notifications
        sendNotification(message);
      },

      // This will be called when app is shut
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // Show Local Notification
        sendNotification(message);
      },
    );

    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Tell The Truth',
        theme: ThemeData(
          primarySwatch: white,
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
        //routes: routes
      ),
    );
  }
}
