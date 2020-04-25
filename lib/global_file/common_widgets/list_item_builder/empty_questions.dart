import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class EmptyQuestions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Lottie.network("https://assets4.lottiefiles.com/private_files/lf30_lmwiE8.json",height: getDynamicHeight(300),width: getDynamicWidth(300)),
              GradientText(
                'You don\'t have any questions to play.',
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
              SizedBox(height: getDynamicHeight(40.0),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rules :', style: mediumTextStyleDark),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text('- After 24hrs of add question polling will be closed. But questions can be viewed for 48hrs. After that questions will be removed.', style: smallTextStyleMedium,),
                        SizedBox(height: getDynamicHeight(10.0),),
                        Text('- By default questioned & polled users identity will anonymous.', style: smallTextStyleMedium),
                        SizedBox(height: getDynamicHeight(10.0),),
                        Text('- If you want you can reveal your identity any time while answering or while adding question.', style: smallTextStyleMedium),
                        SizedBox(height: getDynamicHeight(10.0),),
                        Text('- You can share the question status directly to whatsapp, facebook, instagram stories from our app itself.', style: smallTextStyleMedium,),
                        SizedBox(height: getDynamicHeight(40.0),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
