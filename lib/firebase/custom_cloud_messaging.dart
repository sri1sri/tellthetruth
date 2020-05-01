import 'dart:core';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:random_string/random_string.dart';

class CustomCloudMessaging {
  FirebaseMessaging firebaseMessaging;

  CustomCloudMessaging() {
    firebaseMessaging = FirebaseMessaging();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // Setting These Callbacks To Display The Data In Application
  void settingCallbackForPayloads() {
    firebaseMessaging.configure(
      // This will be called when app is in foreground
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // Show a toast or whatever
      },

      // This will be called when app is in background
      onResume: (Map<String, dynamic> message) async {
        _showNotificationWithDefaultSound();
        print("onMessage: $message");
        // Show Local Notifications
      },

      // This will be called when app is shut
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // Show Local Notification
      },
    );
  }

  // Get Token
//  Future<String> getDeviceToken() {
//    if (Platform.isIOS) {
//      firebaseMessaging.onIosSettingsRegistered.listen((event) {
//        return firebaseMessaging.getToken();
//      });
//
//      firebaseMessaging
//          .requestNotificationPermissions(IosNotificationSettings());
//    }
//    return firebaseMessaging.getToken();
//  }

  // Pass a unique topic name for each gang or make sure that each gang has a unique name
  String registerToGroup(String groupName) {
    String saltToAdd = randomAlpha(5);
    final String topicName = groupName + saltToAdd;
    firebaseMessaging.subscribeToTopic(topicName);
    return topicName;
  }

  // Pass a unique topic name for each gang or make sure that each gang has a unique name
  void unregisterToGroup(String groupName) {
    firebaseMessaging.unsubscribeFromTopic(groupName);
  }

  void registerToGroupNotCreate(String topicName) {
    firebaseMessaging.subscribeToTopic(topicName);
  }
}
