import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class EmptyPolledContent extends StatelessWidget {

  final String title;
  final String message;

  const EmptyPolledContent({Key key, this.title = 'Emptyyyyy!!!', this.message ='No items has been added.'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20,top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Lottie.network("https://assets4.lottiefiles.com/private_files/lf30_YWyaYi.json",height: getDynamicHeight(250),width: getDynamicWidth(250)),
              GradientText(
                'You don\'t have any gangs to display.',
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
              SizedBox(height: getDynamicHeight(20.0),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
