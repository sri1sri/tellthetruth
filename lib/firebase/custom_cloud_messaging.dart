import 'dart:core';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:random_string/random_string.dart';

class CustomCloudMessaging {
  FirebaseMessaging firebaseMessaging;

  CustomCloudMessaging() {
    firebaseMessaging = FirebaseMessaging();
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
  Future<String> getDeviceToken() {
    if (Platform.isIOS) {
      firebaseMessaging.onIosSettingsRegistered.listen((event) {
        return firebaseMessaging.getToken();
      });

      firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }
    return firebaseMessaging.getToken();
  }

  // Pass a unique topic name for each gang or make sure that each gang has a unique name
  String registerToGroup(String groupName) {
    String saltToAdd = randomString(10);
    final String topicName = groupName + saltToAdd;
    firebaseMessaging.subscribeToTopic(topicName);
    return topicName;
  }

  // Pass a unique topic name for each gang or make sure that each gang has a unique name
  void unregisterToGroup(String groupName) {
    firebaseMessaging.unsubscribeFromTopic(groupName);
  }
}
