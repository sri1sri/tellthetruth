
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class BackForeText extends StatelessWidget {

  BackForeText(
      {
        this.backText,
        this.foreText,
        this.route,
      });

  final Widget route;
  final List backText;
  final String foreText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightUp, duration: Duration(seconds: 1),alignment: Alignment.bottomCenter, child: route));

      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: getDynamicHeight(140),
          ),
          Positioned(
            top: 18,
            child:FadeAnimatedTextKit(
                text: backText,
                textStyle: backgroundText,
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center // or Alignment.topLeft
            ),
          ),
          Positioned(
            child: GradientText(
              foreText,
              style: questionStyle1,
              gradient: LinearGradient(
                colors: [
                  Color(0XffFD8B1F),
                  Color(0XffD152E0),
                  Color(0Xff30D0DB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          )
        ],
      ),
    );
  }
}
