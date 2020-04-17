
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
      });

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
          top: 0,
          child:FadeAnimatedTextKit(
              text: backText,
              textStyle: backTextStyle,
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.center // or Alignment.topLeft
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:topPadding),
          child: Positioned(
            child:TextFormField(
                onChanged: (value) => onChanged,
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
                style: TextStyle(
                    fontSize: textFont,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()..shader = linearGradient),
                decoration:  InputDecoration(
                  counterStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: showCounterStyle ? 17 : 0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: hintFont,),
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
        )
      ],
    );
  }
}

