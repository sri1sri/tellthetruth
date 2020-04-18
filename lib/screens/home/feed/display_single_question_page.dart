import 'dart:async';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:slimy_card/slimy_card.dart';


class SingleQuestion extends StatelessWidget {
  SingleQuestion({@required this.questionDetails, @required this.gangID, @required this.insightsDetails});
  String gangID;
  QuestionDetails questionDetails;
  InsightsDetails insightsDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SingleQuestion(questionDetails: questionDetails, gangID: gangID, insightsDetails:insightsDetails),
    );
  }
}

class F_SingleQuestion extends StatefulWidget {
  F_SingleQuestion({@required this.questionDetails, @required this.gangID, @required this.insightsDetails});
  String gangID;
  QuestionDetails questionDetails;
  InsightsDetails insightsDetails;

  @override
  _F_SingleQuestionState createState() => _F_SingleQuestionState();
}

class _F_SingleQuestionState extends State<F_SingleQuestion> {
  static const duration = const Duration( seconds: 1 );

  bool isActive = true;
  Timer timer;
  int secondsLeft;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsLeft = secondsLeft - 1;
      } );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    secondsLeft = ((widget.questionDetails.endsAt.toDate().millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch)~/1000).toInt();
    print(secondsLeft);

    if(widget.insightsDetails == null) {
      final updateQuestionDetails = QuestionDetails(viewCount: widget.questionDetails.viewCount + 1,);
      final createInsightDetails = InsightsDetails(isViewed: true);

      DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
      DBreference.createInsights(createInsightDetails, widget.gangID,widget.questionDetails.questionID);

    }
  }


  @override
  Widget build(BuildContext context) {
    return offlineWidget( context );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0, 0, 0, 0 ),
        child: Scaffold(
          body: _buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic( duration, (Timer t) {
        handleTick( );
      } );
    }


    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: Container(
          width: MediaQuery
              .of( context )
              .size
              .width,
          height: MediaQuery
              .of( context )
              .size
              .height,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color( 0XffFD8B1F ),
                  Color( 0XffD152E0 ),
                  Color( 0Xff30D0DB ),
                  Color( 0Xff12c2e9 ),
                ],
              ) ),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
//                    SizedBox( height: getDynamicHeight(40) ),
                    Padding(
                      padding: const EdgeInsets.all( 15.0 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector( child: Icon(
                            Icons.arrow_back_ios, color: Colors.white, ),
                            onTap: () {
                              Navigator.pop( context, true );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              LabelText(
                                  label: 'HRS',
                                  value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[0].toString( ).padLeft( 2, '0' ) ),
                              LabelText(
                                  label: 'MIN',
                                  value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[1].toString( ).padLeft(
                                      2, '0' ) ),
                              LabelText(
                                  label: 'SEC',
                                  value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[2].toString( ).padLeft(
                                      2, '0' ) ),
                            ],
                          ),
                          Container(
                            child: Text(".....",style: TextStyle(color: Colors.transparent),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(0, -250), // disabled value value
                          Offset(0, -250), //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child:Container(
                          width: getDynamicWidth(MediaQuery.of(context).size.width),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular( 5 ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all( 20.0 ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Lottie.network('https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json',height: getDynamicHeight(80),width: getDynamicWidth(80)),
                                SizedBox( height: getDynamicHeight(15) ),
                                GradientText(
                                  '${widget.questionDetails.question}?'.capitalize(),
                                  textAlign: TextAlign.center,
                                  style: mediumStyle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color( 0XffFD8B1F ),
                                      Color( 0XffD152E0 ),
                                      Color( 0Xff30D0DB ),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TranslationAnimatedWidget(
                            enabled: true,
                            duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                            values: [
                              Offset(0, -250), // disabled value value
                              Offset(0, -250), //intermediate value
                              Offset(0, 0) //enabled value
                            ],
                            child: OptionCard(context ,'${widget.questionDetails.options[0]}','${widget.questionDetails.optionOne} members'),
                          ),
                          SizedBox(height: getDynamicHeight(8),),
                          TranslationAnimatedWidget(
                            enabled: true,
                            duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                            values: [
                              Offset(-200, 250), // disabled value value
                              Offset(-200, 250), //intermediate value
                              Offset(0, 0) //enabled value
                            ],
                            child: OptionCard(context ,'${widget.questionDetails.options[1]}','${widget.questionDetails.optionTwo} members'),
                          ),
                          SizedBox(height: getDynamicHeight(8),),
                          TranslationAnimatedWidget(
                            enabled: true,
                            duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                            values: [
                              Offset(400, -250), // disabled value value
                              Offset(400, -250),  //intermediate value
                              Offset(0, 0) //enabled value
                            ],
                            child: OptionCard(context ,'${widget.questionDetails.options[2]}','${widget.questionDetails.optionThree} members'),/* your widget */
                          ),
                          SizedBox(height: getDynamicHeight(8),),
                          TranslationAnimatedWidget(
                            enabled: true,
                            duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                            values: [
                              Offset(0, 250), // disabled value value
                              Offset(0, 250), //intermediate value
                              Offset(0, 0) //enabled value
                            ],
                            child: OptionCard(context ,'${widget.questionDetails.options[3]}','${widget.questionDetails.optionFour} members'),/* your widget */
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all( 15.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'images/seen.png' ),
                          radius: 14,
                        ),
                        SizedBox( width: getDynamicWidth(5), ),
                        Text('${widget.questionDetails.viewCount}', style: countStyle, ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'images/poll.png' ),
                          radius: 12,
                        ),
                        SizedBox( width: getDynamicWidth(5), ),
                      Text( '${(widget.questionDetails.optionOne+widget.questionDetails.optionTwo+widget.questionDetails.optionThree+widget.questionDetails.optionFour).toString()}',
                          style: countStyle, ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 14,
                        ),
                        SizedBox( width: getDynamicWidth(5), ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showFancyCustomDialog( context );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.share, color: Colors.white, ),
                          ),
                          SizedBox( width: getDynamicWidth(5), ),
                          Text( "Share", style: countStyle, ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),

        ),

      ),
    );
  }


//  Future<T> showGeneralDialog<T>({
//    @required BuildContext context,
//    @required RoutePageBuilder pageBuilder,
//    bool barrierDismissible,
//    String barrierLabel,
//    Color barrierColor,
//    Duration transitionDuration,
//    RouteTransitionsBuilder transitionBuilder,
//  }){}


}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 5 ),
      padding: EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 15 ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GradientText(
            '$value',
            textAlign: TextAlign.center,
            style: boldStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          GradientText(
            '$label',
            style: answerStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }

}





void showFancyCustomDialog(BuildContext context) {

  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: getDynamicHeight(300.0),
                width: getDynamicWidth(300.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: getDynamicHeight(300),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: getDynamicHeight(100),),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('images/whatsapp.png',height: getDynamicHeight(70),width: getDynamicWidth(70),),
                                  Image.asset('images/fb.png',height: getDynamicHeight(60),width: getDynamicWidth(60),),
                                  Image.asset('images/insta.png',height: getDynamicHeight(60),width: getDynamicWidth(60),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: getDynamicHeight(50),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Share",
                            style: questionStyle
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: getDynamicHeight(50),
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Okay let's go!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(1.05, -1.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}


Widget OptionCard(BuildContext context ,String Option,String Members)
{
  return Container(
    height: getDynamicHeight(55),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular( 5 ),
    ),
    child: Padding(
      padding: const EdgeInsets.only( left: 15.0, right: 15.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientText(
            Option..capitalize(),
            style: answerStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          GradientText(
            Members,
            style: answerStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    ),
  );

}