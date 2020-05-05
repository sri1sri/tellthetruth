import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/screens/authentication/select_authentication_page.dart';
import 'package:tellthetruth/screens/home/home_page.dart';
import 'firebase/auth.dart';
import 'firebase/database.dart';
import 'global_file/common_variables/app_functions.dart';

class LandingPage extends StatelessWidget {

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String token;

  Future<void> getToken() async {
    token = await firebaseMessaging.getToken();
//    print("Token: " + token);
    USER_DEVICE_TOKEN = token;
//    print("USER_DEVICE_TOKEN: " + USER_DEVICE_TOKEN);
  }

  @override
  Widget build(BuildContext context) {

    getToken();

    final auth = Provider.of<AuthBase>(context, listen: false);
    SCREEN_SIZE = MediaQuery.of(context).size;

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {

          User user = snapshot.data;
          if (user == null) {
            return SelectAuthentication.create(context);
          }
          return Provider<User>.value(
            value: user,
            child: Provider<Database>(
                create: (_) => FirestoreDatabase(uid: USER_ID = user.uid),
                child: HomePage()),
          );

        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}


