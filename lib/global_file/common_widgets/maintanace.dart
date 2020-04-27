import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class Maintanance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GradientText(
                  'Tell The Truth',
                  style: backgroundTextStyleLight,
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
              ),
              Lottie.network("https://assets7.lottiefiles.com/private_files/lf30_FQVNNa.json",height: getDynamicHeight(350),width: getDynamicWidth(350)),
              GradientText(
                'This page is under maintanance, It will be fixed soon.',
                style: foregroundTextStyleDark,
                textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
