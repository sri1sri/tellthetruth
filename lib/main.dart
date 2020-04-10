
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AuthenticationScreens/login_page.dart';
import 'firebase/auth.dart';
import 'landing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Tell The Truth',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
        //routes: routes
      ),
    );
  }
}