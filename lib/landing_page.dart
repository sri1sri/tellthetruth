import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AuthenticationScreens/login_page.dart';
import 'common_variables/app_functions.dart';
import 'firebase/auth.dart';
import 'firebase/database.dart';
import 'home/home_page.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    SCREEN_SIZE = MediaQuery.of(context).size;


    return StreamBuilder<User>(
      stream: auth.onAuthStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {

          User user = snapshot.data;
          if (user == null) {
            return LoginPage.create(context);
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


