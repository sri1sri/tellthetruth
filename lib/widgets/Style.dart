
import 'package:flutter/material.dart';

const backgroundGradient = LinearGradient( colors: <Color>[
  Color(0XffFD8B1F),
  Color(0XffD152E0),
  Color(0Xff30D0DB),
], begin: Alignment.topLeft, end: Alignment.bottomRight);

List<BoxShadow> softUiShadow = [
  BoxShadow(
    color: Colors.white,
    offset: Offset(-5, -5),
    spreadRadius: 1,
    blurRadius: 15,
  ),
  BoxShadow(
    color: Color(0XFF748CAC).withOpacity(.6),
    offset: Offset(5, 5),
    spreadRadius: 1,
    blurRadius: 15,
  ),
];

const activeGradient = LinearGradient(
  colors: <Color>[
    Colors.white,
    Color(0XffD152E0),
    Color(0Xff30D0DB),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

