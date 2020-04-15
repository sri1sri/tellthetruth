
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

var subBackgroundColor = Color(0xFF253949);
var backgroundColor = Color(0xFF259ED9);


var topNavigationBackgroundColor = Color(0xFF1F4B6E);
var bottomNavigationBackgroundColor = Colors.greenAccent;


var bigTitleColor = Colors.greenAccent;
var titleColor = Colors.greenAccent;
var subTitleColor = Colors.greenAccent;
var descriptionColor = Colors.greenAccent;


var accpetButtonBackgroundColor = Colors.greenAccent;
var declineButtonBackgroundColor = Colors.greenAccent;
var pendingButtonBackgroundColor = Colors.greenAccent;


var activeButtonTextColor = Colors.white;
var inActiveButtonTextColor = Colors.black54;



var activeButtonBackgroundColor = Color(0xFF1F4B6E);
var inActiveButtonBackgroundColor = Colors.black12;
var removeButtonBackgroundColor = Colors.deepOrange;

final tween = MultiTrackTween([
  Track("color1").add(Duration(seconds: 3),
      ColorTween(begin: Color(0xffD38312), end: Color(0XffD152E0))),
  Track("color2").add(Duration(seconds: 3),
      ColorTween(begin: Color(0XffD152E0), end: Color(0Xff30D0DB))),
  Track("color3").add(Duration(seconds: 3),
      ColorTween(begin: Color(0Xff30D0DB), end: Color(0Xff12c2e9))),
  Track("color4").add(Duration(seconds: 3),
      ColorTween(begin: Color(0Xff12c2e9), end: Color(0xffD38312))),
]);