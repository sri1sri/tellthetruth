
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
                textStyle: backgroundTextStyleMedium,
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center // or Alignment.topLeft
            ),
          ),
          Positioned(
            top: 55,
            child: GradientText(
              foreText,
              style: foregroundTextStyleLight,
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

class BackForeTextInput extends StatelessWidget {

  BackForeTextInput(
      {
        this.backText,
        this.backTextStyle,
        this.lines,
        this.length,
        this.textFont,
        this.hintFont,
        this.onEditingComplete,
        this.onChanged,
        this.hintText,
        this.validationText,
        this.topPadding,
        this.height,
        this.textInputAction,
        this.focusNode,
        this.onFieldSubmitted,
        this.showCounterStyle,
        this.initialValue,
        this.controller,
      });
  final TextEditingController controller;
  final String initialValue;
  final String validationText;
  final double height;
  final TextStyle backTextStyle;
  final VoidCallback onEditingComplete;
  ValueChanged<String> onChanged;
  final int lines;
  final double textFont;
  final double hintFont;
  final int length;
  final List backText;
  final String hintText;
  final double topPadding;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  bool showCounterStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: getDynamicHeight(height),
        ),
        Positioned(
          top: -10,
          child:FadeAnimatedTextKit(
              text: backText,
              textStyle: backgroundTextStyleMedium,
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.center // or Alignment.topLeft
          ),
        ),
        Positioned(
          child:TextFormField(
            controller: controller,
            initialValue: initialValue,
            onChanged: onChanged,
            maxLines: lines,
            textInputAction: textInputAction,
            autocorrect: true,
            obscureText: false,
            keyboardType: TextInputType.text,
            keyboardAppearance: Brightness.light,
            autofocus: true,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            cursorColor: Colors.blue,
            maxLength: length,
            onEditingComplete: onEditingComplete,
            textAlign: TextAlign.center,
            style: foregroundTextStyleDark,
            decoration:  InputDecoration(
              counterStyle: TextStyle(
                fontFamily: mainFontFamily,
                fontWeight: FontWeight.w600,
                fontSize: showCounterStyle ? 17 : 0,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              hintText: hintText,
              hintStyle: foregroundTextStyleMedium,
              enabledBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 0.0),
              ),
            ),
            validator: (value) {
              print(value);
              if (value.isEmpty) {
                return validationText;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

