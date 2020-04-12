
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'AuthenticationScreens/login_page.dart';
import 'firebase/auth.dart';
import 'landing_page.dart';

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


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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