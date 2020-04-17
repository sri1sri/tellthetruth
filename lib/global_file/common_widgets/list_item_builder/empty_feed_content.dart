import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class EmptyFeedContent extends StatelessWidget {

  final String title;
  final String message;

  const EmptyFeedContent({Key key, this.title = 'Emptyyyyy!!!', this.message ='No items has been added.'}) : super(key: key);

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
                style: boldStyle,
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
                  Text('How to create gang?', style: answerStyleBlur1),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - Go to + tab below.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - Click on Create new gang & have fun.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - Enter you gang name & icon.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - You will be providing with gang code.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(20.0),),
                  Text('How to join gang?', style: answerStyleBlur1),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - Go to + tab below.', style: answerStyleBlur,),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - Click on Join your gang.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - Enter you gang code. That\'s it..!!!', style: answerStyleBlur,),
                  SizedBox(height: getDynamicHeight(40.0),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
