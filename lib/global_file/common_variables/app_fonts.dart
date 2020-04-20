
import 'dart:ui';
import 'package:flutter/material.dart';


import 'app_functions.dart';

//light
var heavyStyle = TextStyle(
    color: Colors.black54,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
    fontSize: getDynamicTextSize(35),decoration: TextDecoration.none);

var backgroundText = TextStyle(
    color: Colors.black12,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
    fontSize: getDynamicTextSize(50),decoration: TextDecoration.none);

var backgroundText1 = TextStyle(
    color: Colors.black12,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
    fontSize: getDynamicTextSize(35),decoration: TextDecoration.none);


var boldStyle = TextStyle(
    color: Color(0xFF253949),
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);

var mediumStyle = TextStyle(
    color: Color(0xFF253949),
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none);

var regularStyle = TextStyle(
    color: Color(0xFF253949),
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: getDynamicTextSize(17),decoration: TextDecoration.none);

var boldStyleLight = TextStyle(
    color: Color(0xFF253949),
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);

var questionStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w800,
    fontSize: getDynamicTextSize(24),decoration: TextDecoration.none);
var questionStyle2 = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none);

var questionStyle1 = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(24),decoration: TextDecoration.none);

var questionStyleThin = TextStyle(
    color: Colors.black,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: getDynamicTextSize(24),decoration: TextDecoration.none);

var answerStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(15),decoration: TextDecoration.none);


var answerStyleBlur = TextStyle(
    color: Colors.black54.withOpacity(0.6),
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(15),decoration: TextDecoration.none);

var countStyle = TextStyle(
color: Colors.white,
fontFamily: 'Montserrat',
fontWeight: FontWeight.w600,
fontSize: getDynamicTextSize(13),decoration: TextDecoration.none);

var logoStyle1 = TextStyle(
    color: Colors.white,
    fontFamily: 'FingerPaint',
    fontWeight: FontWeight.w700,
    fontSize: getDynamicTextSize(40),decoration: TextDecoration.none);
var logoStyle2 = TextStyle(
    color: Colors.white,
    fontFamily: 'FingerPaint',
    fontWeight: FontWeight.w700,
    fontSize: getDynamicTextSize(22),decoration: TextDecoration.none);


var answerStyleBlur1 = TextStyle(
    color: Colors.black87,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: getDynamicTextSize(18),decoration: TextDecoration.none);


Gradient gradiantText =  LinearGradient(
  colors: [
    Color(0XffFD8B1F),
    Color(0XffD152E0),
    Color(0Xff30D0DB),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0XffFD8B1F),Color(0XffD152E0), Color(0Xff30D0DB)],
).createShader(Rect.fromLTWH(150.0, 250.0, 50.0,100));

