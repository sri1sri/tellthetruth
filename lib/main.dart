
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/firebase/custom_cloud_messaging.dart';
import 'firebase/admobs.dart';
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


void main(){
//  bannerAd = createBannerAd();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  String token;

  Future<String> getToken() async {
    token = await firebaseMessaging.getToken();
    return token;
  }

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//
//  @override
//  initState() {
//    super.initState();
//
//    var initializationSettingsAndroid =
//    new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        selectNotification: onSelectNotification);
//  }
//
//  Future onSelectNotification(String payload) async {
//    showDialog(
//      context: context,
//      builder: (_) {
//        return new AlertDialog(
//          title: Text("PayLoad"),
//          content: Text("Payload : $payload"),
//        );
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
//
//    getToken();
//    print("Token: " + token);
//    CustomCloudMessaging().settingCallbackForPayloads();
//    String newTopic = CustomCloudMessaging().registerToGroup('test_portal');
//    print("Topic: " + newTopic);

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);


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