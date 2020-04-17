
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
        this.lines,
        this.length,
        this.textFont,
        this.hintFont,
        this.onEditingComplete,
        this.onChanged,
        this.hintText,
        this.validText,
      });

  final String validText;
  final VoidCallback onEditingComplete;
  ValueChanged<String> onChanged;
  final int lines;
  final double textFont;
  final double hintFont;
  final int length;
  final List backText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: getDynamicHeight(140),
        ),
        Positioned(
          top: 0,
          child:FadeAnimatedTextKit(
              text: backText,
              textStyle: backgroundText,
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.center // or Alignment.topLeft
          ),
          //Text("Question",style: backgroundText,),
        ),
        Padding(
          padding: const EdgeInsets.only(top:25.0),
          child: Positioned(
            child:TextFormField(
                onChanged: (value) => onChanged,
                maxLines: lines,
                textInputAction: TextInputAction.done,
                autocorrect: true,
                obscureText: false,
                keyboardType: TextInputType.text,
                keyboardAppearance: Brightness.dark,
                autofocus: true,
                cursorColor: Colors.blue,
                maxLength: length,
                onEditingComplete: onEditingComplete,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textFont,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()..shader = linearGradient),
                decoration: const InputDecoration(
                  counterStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  hintText: "Add your Qusetion",
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                ),
                validator: (value) {
                  print(value);
                  if (value.isEmpty) {
                    return validText;
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

