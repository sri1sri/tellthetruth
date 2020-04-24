
import 'dart:ui';
import 'package:flutter/material.dart';


import 'app_functions.dart';

String mainFontFamily = 'BalooBhaina2';


var backgroundTextStyleDark = TextStyle(
    color: Colors.black,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w900,
    fontSize: getDynamicTextSize(50),decoration: TextDecoration.none);

var backgroundTextStyleMedium = TextStyle(
    color: Colors.black12,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w900,
    fontSize: getDynamicTextSize(50),decoration: TextDecoration.none);

var backgroundTextStyleLight = TextStyle(
    color: Colors.white,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w900,
    fontSize: getDynamicTextSize(50),decoration: TextDecoration.none);

var foregroundTextStyleDark = TextStyle(
    color: Colors.black,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);

var foregroundTextStyleMedium = TextStyle(
    color: Colors.black12,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);

var foregroundTextStyleLight = TextStyle(
    color: Colors.white,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);

var mediumTextStyleDark = TextStyle(
    color: Colors.black,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none,
    height: 1.5);

var mediumTextStyleMedium = TextStyle(
    color: Colors.black54,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none);

var mediumTextStyleLight = TextStyle(
    color: Colors.white,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none);

var smallTextStyleDark = TextStyle(
    color: Colors.black,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(16),decoration: TextDecoration.none);

var smallTextStyleMedium = TextStyle(
    color: Colors.black54,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getDynamicTextSize(16),decoration: TextDecoration.none);

var smallTextStyleLight = TextStyle(
    color: Colors.white,
    fontFamily: mainFontFamily,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontSize: getDynamicTextSize(16),decoration: TextDecoration.none);

var verySmallTextStyleLight = TextStyle(
    color: Colors.white,
    fontFamily: mainFontFamily,
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




//
////light
//var heavyStyle = TextStyle(
//    color: Colors.black54,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w900,
//    fontSize: getDynamicTextSize(35),decoration: TextDecoration.none);


//
//var backgroundText1 = TextStyle(
//    color: Colors.black12,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w900,
//    fontSize: getDynamicTextSize(35),decoration: TextDecoration.none);
//
//
//var boldStyle = TextStyle(
//    color: Colors.black54,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w700,
//    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);
//
//var mediumStyle = TextStyle(
//    color: Colors.black87,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w600,
//    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none);
//
//var regularStyle = TextStyle(
//    color: Colors.black54,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w400,
//    fontSize: getDynamicTextSize(17),decoration: TextDecoration.none);
//
//var boldStyleLight = TextStyle(
//    color: Colors.black87,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w700,
//    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none);
//
//var questionStyle = TextStyle(
//    color: Colors.white,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w800,
//    fontSize: getDynamicTextSize(24),decoration: TextDecoration.none);
//var questionStyle2 = TextStyle(
//    color: Colors.white,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w600,
//    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none);
//
//var questionStyle1 = TextStyle(
//    color: Colors.white,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w600,
//    fontSize: getDynamicTextSize(24),decoration: TextDecoration.none);
//
//var questionStyleThin = TextStyle(
//    color: Colors.black,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w400,
//    fontSize: getDynamicTextSize(24),decoration: TextDecoration.none);
//
//var answerStyle = TextStyle(
//    color: Colors.white,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w600,
//    fontSize: getDynamicTextSize(16),decoration: TextDecoration.none);
//
//
//var answerStyleBlur = TextStyle(
//    color: Colors.black54.withOpacity(0.6),
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w600,
//    fontSize: getDynamicTextSize(15),decoration: TextDecoration.none);
//
//var countStyle = TextStyle(
//color: Colors.white,
//    fontFamily: mainFontFamily,
//fontWeight: FontWeight.w600,
//fontSize: getDynamicTextSize(13),decoration: TextDecoration.none);
//

//
//
//var answerStyleBlur1 = TextStyle(
//    color: Colors.black87,
//    fontFamily: mainFontFamily,
//    fontWeight: FontWeight.w700,
//    fontSize: getDynamicTextSize(18),decoration: TextDecoration.none);


//Gradient gradiantText =  LinearGradient(
//  colors: [
//    Color(0XffFD8B1F),
//    Color(0XffD152E0),
//    Color(0Xff30D0DB),
//  ],
//  begin: Alignment.topLeft,
//  end: Alignment.bottomRight,
//);

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0XffFD8B1F),Color(0XffD152E0), Color(0Xff30D0DB)],
).createShader(Rect.fromLTWH(150.0, 250.0, 50.0,100));

