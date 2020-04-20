import 'dart:async';
import 'dart:io';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';


class SingleQuestion extends StatelessWidget {
  SingleQuestion({@required this.questionID, @required this.gangID});
  String gangID;
  String questionID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SingleQuestion(questionID: questionID, gangID: gangID),
    );
  }
}

class F_SingleQuestion extends StatefulWidget {
  F_SingleQuestion({ @required this.gangID, @required this.questionID});
  String gangID;
  String questionID;

  @override
  _F_SingleQuestionState createState() => _F_SingleQuestionState();
}

class _F_SingleQuestionState extends State<F_SingleQuestion> {

  static const duration = const Duration( seconds: 1 );

  bool isActive = true;
  Timer timer;
  int secondsLeft;

  Color optionOneBackgroundColor = Colors.black54;
  Color optionTwoBackgroundColor = Colors.black54;
  Color optionThreeBackgroundColor = Colors.black54;
  Color optionFourBackgroundColor = Colors.black54;

  bool isAnonymous = true;

  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;

//  void handleTick() {
//
//    if (isActive) {
//      if (this.mounted) {
//        setState(() {
//          secondsLeft = secondsLeft - 1;
//        });
//      }
//    }
//  }

  Future<bool> updateData(InsightsDetails insightsDetails, QuestionDetails questionDetails) async{

    if(insightsDetails == null) {
      final updateQuestionDetails = QuestionDetails(viewCount: questionDetails.viewCount + 1,);
      final createInsightDetails = InsightsDetails(isViewed: true, isAnonymos: true, optionSelected: 0);

      await DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID, questionDetails.questionID);
      await DBreference.createInsights(createInsightDetails, widget.gangID, questionDetails.questionID);
    }
    isAnonymous =  insightsDetails.isAnonymos != null ? insightsDetails.isAnonymos : true;

    return true;
  }

  void updateInsights(int optionSelected, polledCount){

    switch(optionSelected){
      case 1:
        final updateQuestionDetails = QuestionDetails(optionOnePolledCount: polledCount,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionID);
        break;
      case 2:
        final updateQuestionDetails = QuestionDetails(optionTwoPolledCount: polledCount,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionID);
        break;
      case 3:
        final updateQuestionDetails = QuestionDetails(optionThreePolledCount: polledCount,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionID);
        break;
      case 4:
        final updateQuestionDetails = QuestionDetails(optionFourPolledCount: polledCount,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionID);
        break;
    }

    final updateInsightDetails = InsightsDetails(optionSelected: optionSelected);
    DBreference.updateInsights(updateInsightDetails, widget.gangID,widget.questionID);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Screenshot(
        child: offlineWidget(context),
    controller: screenshotController,);
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
//    if (timer == null) {
//      timer = Timer.periodic( duration, (Timer t) {
//        handleTick( );
//      } );
//    }
    return StreamBuilder<QuestionDetails>(
        stream: DBreference.readSingleQuestion(widget.gangID, widget.questionID),
        builder: (context, snapshot) {
          final questionDetails = snapshot.data;

         // secondsLeft = (((questionDetails.endsAt != null ? questionDetails.endsAt.toDate().millisecondsSinceEpoch : 0) - DateTime.now().millisecondsSinceEpoch)~/1000).toInt();

          print(questionDetails);

          return StreamBuilder<UserDetails>(
            stream: DBreference.getUserDetails(questionDetails.createdBy),
            builder: (context, snapshot) {
              final userDetails = snapshot.data;

              print(userDetails);


            return StreamBuilder<InsightsDetails>(
                stream: DBreference.myInsight(widget.gangID, widget.questionID),
                builder: (context, snapshot) {
                  final insightsDetails = snapshot.data;

                  print(insightsDetails);


                  updateData(insightsDetails,questionDetails);


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
                            colors: <Color>[
                              Color(questionDetails.color1 != null ? int.tryParse(questionDetails.color1) : 0XffFD8B1F),
                              Color(questionDetails.color2 != null ? int.tryParse(questionDetails.color2) : 0Xff30DD76),
                            ],
                          ) ),
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all( 15.0 ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                        Icons.arrow_back_ios, color: Colors.white, ),
                                        onTap: () {
                                          Navigator.pop( context, true );
                                        },
                                      ),
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.center,
//                                        children: <Widget>[
//                                          TimerText(
//                                              label: 'HRS',
//                                              value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[0].toString( ).padLeft( 2, '0' ) ),
//                                          TimerText(
//                                              label: 'MIN',
//                                              value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[1].toString( ).padLeft(
//                                                  2, '0' ) ),
//                                          TimerText(
//                                              label: 'SEC',
//                                              value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[2].toString( ).padLeft(
//                                                  2, '0' ) ),
//                                        ],
//                                      ),
                                      GestureDetector(
                                        child: CircleAvatar(
                                          backgroundImage:
                                          AssetImage(insightsDetails.isAnonymos != null ? insightsDetails.isAnonymos ? 'images/questionAskedAnonymous.png' :'images/questionNotAskedAnonymous.png' : 'images/questionAskedAnonymous.png' ),
                                          radius: 20,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onTap: () async {
                                          setState(() {
                                            isAnonymous ? isAnonymous = false : isAnonymous = true;
                                          });
                                          final updateInsightDetails = InsightsDetails(isAnonymos: insightsDetails.isAnonymos != null ? insightsDetails.isAnonymos ? false : true : true);
                                          await DBreference.updateInsights(updateInsightDetails, widget.gangID,questionDetails.questionID != null ? questionDetails.questionID : '0');

                                          showFancyCustomDialog(context, isAnonymous ? 'You are in incognito mode. No one can see who answered this question..' : 'Your idenity has been revealed. Now every one can see who answered this question.');
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                questionDetails.isAnonymous != null ? questionDetails.isAnonymous ? Container(height: 0,width: 0,) : Text(userDetails.username != null ? userDetails.username : 'fetching...') : Container(height: 0,width: 0,) ,

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
                                              '${questionDetails.question != null ? questionDetails.question : 'fetching...'}?'.capitalize(),
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
                                          child: GestureDetector(
                                            onTap: (){
                                              if(insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 : 0 == 0){
                                                updateInsights(1, questionDetails.optionOnePolledCount != null ? questionDetails.optionOnePolledCount+1 : 0);
                                                setState(() {
                                                  optionOneBackgroundColor = Colors.white;
                                                });
                                              }
                                            },
                                              child: OptionCard(
                                                  0,
                                                  '${questionDetails.optionOnePolledCount != null ? questionDetails.optionOnePolledCount.toString() : '0'} votes',
                                                  insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 1 ? Colors.white : optionOneBackgroundColor : optionOneBackgroundColor,
                                                  insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 ? false : true : false,
                                                  questionDetails
                                              ),
                                          ),
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
                                        child: GestureDetector(
                                            onTap: (){
                                              if(insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 : 0 == 0){

                                                updateInsights(2, questionDetails.optionTwoPolledCount != null ? questionDetails.optionTwoPolledCount +1 :0);
                                                setState(() {
                                                  optionTwoBackgroundColor = Colors.white;
                                                });
                                              }
                                            },
                                            child: OptionCard(1,
                                                '${questionDetails.optionTwoPolledCount != null ? questionDetails.optionTwoPolledCount.toString() : '0'} votes',
                                                insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 2 ? Colors.white : optionTwoBackgroundColor : optionTwoBackgroundColor,
                                                insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 ? false : true : false,
                                              questionDetails
                                            ),
                                        ),
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
                                        child: GestureDetector(
                                            onTap: (){
                                              if(insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 : 0 == 0){
                                                updateInsights(3, questionDetails.optionThreePolledCount != null ? questionDetails.optionThreePolledCount+1 : 0);
                                                setState(() {
                                                  optionThreeBackgroundColor = Colors.white;
                                                });
                                              }

                                            },
                                            child: OptionCard(2,
                                                '${questionDetails.optionThreePolledCount != null ? questionDetails.optionThreePolledCount.toString() : '0'} votes',
                                                insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 3 ? Colors.white : optionThreeBackgroundColor : optionThreeBackgroundColor,
                                                insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 ? false : true : false,
                                              questionDetails
                                            ),
                                        ),/* your widget */
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
                                        child: GestureDetector(
                                            onTap: (){
                                              if(insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 : 0 == 0){
                                                updateInsights(4, questionDetails.optionFourPolledCount != null ? questionDetails.optionFourPolledCount+1 : 0);
                                                setState(() {
                                                  optionFourBackgroundColor = Colors.white;
                                                });
                                              }
                                            },
                                            child: OptionCard(3,
                                                '${questionDetails.optionFourPolledCount != null ? questionDetails.optionFourPolledCount.toString() : 0} votes',
                                                insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 4 ? Colors.white : optionFourBackgroundColor : optionFourBackgroundColor,
                                                insightsDetails.optionSelected != null ? insightsDetails.optionSelected == 0 ? false : true : false,
                                              questionDetails
                                            ),
                                        ),/* your widget */
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
                                    Text('${questionDetails.viewCount != null ? questionDetails.viewCount : 0}', style: countStyle, ),
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
                                  Text( '${(questionDetails.optionOnePolledCount != null ? questionDetails.optionOnePolledCount : 0
                                      + questionDetails.optionTwoPolledCount != null ? questionDetails.optionTwoPolledCount : 0
                                      + questionDetails.optionThreePolledCount != null ? questionDetails.optionThreePolledCount : 0
                                      + questionDetails.optionFourPolledCount != null ? questionDetails.optionFourPolledCount : 0).toString()}',
                                    style: countStyle, ),
                                  ],
                                ),

                                questionDetails.createdBy != null ? questionDetails.createdBy == USER_ID ? GestureDetector(
                                  child: CircleAvatar(
                                    backgroundImage:
                                    AssetImage(questionDetails.isAnonymous != null ? questionDetails.isAnonymous ? 'images/questionAskedAnonymous.png' : 'images/questionNotAskedAnonymous.png' : 'images/questionAskedAnonymous.png'),
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onTap: () {
                                    final updateQuestionDetails = QuestionDetails(isAnonymous: questionDetails.isAnonymous != null ? questionDetails.isAnonymous ? false : true : true);
                                    DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,questionDetails.questionID != null ? questionDetails.questionID : '0');
                                  },
                                ) : Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 14,
                                    ),
                                    SizedBox( width: getDynamicWidth(5), ),
                                  ],
                                ) : Row(
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

                            screenshotController.capture().then((File image) {
                            //Capture Done
                            setState(() {
                              print(_imageFile);
                              _imageFile = image;
                              print(_imageFile);
                              final result = ImageGallerySaver.saveImage(_imageFile.readAsBytesSync());
                              print(result);
                            });
                          }).catchError((onError) {
                            print(onError);
                          });
                                  //  showFancyCustomDialog( context );
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


//                          RaisedButton(
//                            onPressed: () {
//                              showFancyCustomDialog( context );
//                              _showSnackBar(context, "View Gang");
//                              final snackBar = SnackBar(
//                                content: Text('Yay! A SnackBar!'),
//                                action: SnackBarAction(
//                                  label: 'Undo',
//                                  onPressed: () {
//                                    // Some code to undo the change.
//                                  },
//                                ),
//                              );
//
//                              // Find the Scaffold in the widget tree and use
//                              // it to show a SnackBar.
//                              Scaffold.of(context).showSnackBar(snackBar);
//                            },
//                            child: Text('Show SnackBar'),
//                          ),

                        ],
                      ),

                    ),

                  ),
                );
              }
            );
          }
        );
      }
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message, style: questionStyle1),
      duration: const Duration(milliseconds: 1000),
    ));
  }


  Color selectBackgroundColor = Colors.white;
  Color textColor = Colors.red;


  Widget OptionCard(int optionIndex, String polledCount, Color backgroundColor, bool isOptionSelected, QuestionDetails questionDetails) {
    return Container(
      //height: getDynamicHeight(55),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular( 5 ),
      ),
      child: Padding(
        padding: const EdgeInsets.only( left: 15.0, right: 15.0 ,top:20,bottom:20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: getDynamicWidth(MediaQuery.of(context).size.width/1.5),

              child: GradientText(
                '${questionDetails.options[optionIndex]}'.capitalize(),
                style: answerStyle,
                gradient: LinearGradient(
                  colors: isOptionSelected ? [
                    Color( 0XffFD8B1F ),
                    Color( 0XffD152E0 ),
                    Color( 0Xff30D0DB ),
                  ] : [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            GradientText(
              polledCount,
              style: answerStyle,
              gradient: LinearGradient(
                colors: isOptionSelected ? [
                  Color( 0XffFD8B1F ),
                  Color( 0XffD152E0 ),
                  Color( 0Xff30D0DB ),
                ] : [
                  Colors.white,
                  Colors.white,
                  Colors.white,
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
  
}

class TimerText extends StatelessWidget {
  TimerText({this.label, this.value});

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

void showFancyCustomDialog(BuildContext context, String description) {

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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 500),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: getDynamicHeight(100.0),
                  width: getDynamicWidth(400.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: getDynamicHeight(250),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(description,style: answerStyleBlur,),
                              ],
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
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}