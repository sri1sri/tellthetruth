import 'dart:async';
import 'dart:io';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/landing_page.dart';
import 'package:tellthetruth/screens/home/feed/polled_users_page.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:vibration/vibration.dart';


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

  Color optionOneBackgroundColor = Colors.black54;
  Color optionTwoBackgroundColor = Colors.black54;
  Color optionThreeBackgroundColor = Colors.black54;
  Color optionFourBackgroundColor = Colors.black54;

  int optionOnePolledCount = 0;
  int optionTwoPolledCount = 0;
  int optionThreePolledCount = 0;
  int optionFourPolledCount = 0;

  bool isOptionOneSelected = false;
  bool isOptionTwoSelected = false;
  bool isOptionThreeSelected = false;
  bool isOptionFourSelected = false;

  bool addPollCount = false;

  bool isPolled = false;
  int selectedOption = 0;

  bool isAnswerAnonymos = true;
  bool isQuestionAnonymos = true;

  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;

  bool _dropdownShown = false;

  void _toggleDropdown() {
    setState(() {
      _dropdownShown = !_dropdownShown;
    });
  }

  void handleTick() {

    if (isActive) {
      if (this.mounted) {
        setState(() {
          secondsLeft = secondsLeft - 1;
        });
      }
    }
  }

  Future<bool> updateData() async{

    if(widget.insightsDetails == null) {
      final updateQuestionDetails = QuestionDetails(viewCount: widget.questionDetails.viewCount + 1,);
      final createInsightDetails = InsightsDetails(isViewed: true, isReported: false);

      await DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
      await DBreference.createInsights(createInsightDetails, widget.gangID,widget.questionDetails.questionID);
    }
    widget.insightsDetails.optionSelected == null ? setState(() {
      isPolled = false;
    }) : setState(() {
      selectedOption = widget.insightsDetails.optionSelected;
      isPolled = true;

      switch(selectedOption){
        case 1:
          isOptionOneSelected = true;
          break;
        case 2:
          isOptionTwoSelected = true;
          break;
        case 3:
          isOptionThreeSelected = true;
          break;
        case 4:
          isOptionFourSelected = true;
          break;

      }
    });
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    secondsLeft = ((widget.questionDetails.endsAt.toDate().millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch)~/1000).toInt();

    updateData();

    optionOnePolledCount = widget.questionDetails.optionOnePolledCount;
    optionTwoPolledCount = widget.questionDetails.optionTwoPolledCount;
    optionThreePolledCount = widget.questionDetails.optionThreePolledCount;
    optionFourPolledCount = widget.questionDetails.optionFourPolledCount;

    isAnswerAnonymos = widget.insightsDetails == null ? true : widget.insightsDetails.isAnonymous != null ? widget.insightsDetails.isAnonymous : true;
    isQuestionAnonymos = widget.questionDetails.isAnonymous;
  }

  void updateInsights(int optionSelected){

    switch(optionSelected){
      case 1:
        final updateQuestionDetails = QuestionDetails(optionOnePolledCount: widget.questionDetails.optionOnePolledCount + 1,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
        break;
      case 2:
        final updateQuestionDetails = QuestionDetails(optionTwoPolledCount: widget.questionDetails.optionTwoPolledCount + 1,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
        break;
      case 3:
        final updateQuestionDetails = QuestionDetails(optionThreePolledCount: widget.questionDetails.optionThreePolledCount + 1,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
        break;
      case 4:
        final updateQuestionDetails = QuestionDetails(optionFourPolledCount: widget.questionDetails.optionFourPolledCount + 1,);
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
        break;
    }

    final updateInsightDetails = InsightsDetails(optionSelected: optionSelected, isAnonymous: true);
    DBreference.updateInsights(updateInsightDetails, widget.gangID,widget.questionDetails.questionID);
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
    if (timer == null) {
      timer = Timer.periodic( duration, (Timer t) {
        handleTick( );
      } );
    }
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                    Color(int.tryParse(widget.questionDetails.color1)),
                    Color(int.tryParse(widget.questionDetails.color2)),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TimerText(
                                    label: 'HRS',
                                    value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[0].toString( ).padLeft( 2, '0' ) ),
                                TimerText(
                                    label: 'MIN',
                                    value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[1].toString( ).padLeft(
                                        2, '0' ) ),
                                TimerText(
                                    label: 'SEC',
                                    value: convertSeconds(secondsLeft >0 ? secondsLeft : 0)[2].toString( ).padLeft(
                                        2, '0' ) ),
                              ],
                            ),

                            widget.questionDetails.createdBy != USER_ID ? IconButton(
                              icon: Icon(
                                Icons.report,
                                color: Colors.white,
                              ),
                              onPressed: (){
                                CustomAlertBox(context, 'Report', 'Are you sure what to report this question ? Uploader will be notified and this question will be removed.', true, (){
                                  final updateInsightDetails = InsightsDetails(isReported: true);
                                 DBreference.updateInsights(updateInsightDetails, widget.gangID, widget.questionDetails.questionID);
                                  GoToPage(context, LandingPage());
                                });
                              },
                              color: Colors.white,
                            ) : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: (){
                                CustomAlertBox(context, 'Delete', 'Are you sure what to delete this question ?', true, (){
                                  DBreference.deleteQuestion(widget.gangID, widget.questionDetails.questionID);
                                  GoToPage(context, LandingPage());
                                });
                              },
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      StreamBuilder<UserDetails>(
                          stream: DBreference.getUserDetails(widget.questionDetails.createdBy),
                          builder: (context, snapshot) {
                            final userDetails = snapshot.data;

                            return isQuestionAnonymos ? Container(height: 0,width: 0,) : Text(userDetails.username != null ? '${userDetails.username}\'s question' : 'fetching...',style: answerStyle);
                          }
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
                               //   Lottie.network('https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json',height: getDynamicHeight(80),width: getDynamicWidth(80)),
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
                              child: GestureDetector(
                                onTap: () async{
                                  if(!isPolled){
                                    if (await Vibration.hasAmplitudeControl()) {
                                      Vibration.vibrate(amplitude: 128);
                                    }
                                    updateInsights(1);
                                    setState(() {
                                      optionOneBackgroundColor = Colors.white;
                                      isPolled = true;
                                      optionOnePolledCount = optionOnePolledCount + 1;
                                      isOptionOneSelected = true;
                                      addPollCount = true;
                                    });
                                  }
                                },
                                child: OptionCard(
                                  0,
                                  '${optionOnePolledCount.toString()} votes',
                                  selectedOption == 0 ? optionOneBackgroundColor : selectedOption == 1 ? Colors.white : optionOneBackgroundColor,
                                  isOptionOneSelected,
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
                                onTap: () async{
                                  if(!isPolled){
                                    if (await Vibration.hasAmplitudeControl()) {
                                      Vibration.vibrate(amplitude: 128);
                                    }
                                    updateInsights(2);
                                    setState(() {
                                      optionTwoBackgroundColor = Colors.white;
                                      isPolled = true;
                                      optionTwoPolledCount = optionTwoPolledCount + 1;
                                      isOptionTwoSelected = true;
                                      addPollCount = true;
                                    });
                                  }
                                },
                                child: OptionCard(1,
                                  '${optionTwoPolledCount.toString()} votes',
                                  selectedOption == 0 ? optionTwoBackgroundColor : selectedOption == 2 ? Colors.white : optionTwoBackgroundColor,
                                  isOptionTwoSelected,
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
                                onTap: () async{
                                  if(!isPolled){
                                    if (await Vibration.hasAmplitudeControl()) {
                                      Vibration.vibrate(amplitude: 128);
                                    }
                                    updateInsights(3);
                                    setState(() {
                                      optionThreeBackgroundColor = Colors.white;
                                      isPolled = true;
                                      optionThreePolledCount = optionThreePolledCount + 1;
                                      isOptionThreeSelected = true;
                                      addPollCount = true;
                                    });
                                  }

                                },
                                child: OptionCard(2,
                                  '${optionThreePolledCount.toString()} votes',
                                  selectedOption == 0 ? optionThreeBackgroundColor : selectedOption == 3 ? Colors.white : optionThreeBackgroundColor,
                                  isOptionThreeSelected,
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
                                onTap: () async{
                                  if(!isPolled){
                                    if (await Vibration.hasAmplitudeControl()) {
                                      Vibration.vibrate(amplitude: 128);
                                    }
                                    updateInsights(4);
                                    setState(() {
                                      optionFourBackgroundColor = Colors.white;
                                      isPolled = true;
                                      optionFourPolledCount = optionFourPolledCount + 1;
                                      isOptionFourSelected = true;
                                      addPollCount = true;
                                    });
                                  }
                                },
                                child: OptionCard(3,
                                  '${optionFourPolledCount.toString()} votes',
                                  selectedOption == 0 ? optionFourBackgroundColor : selectedOption == 4 ? Colors.white : optionFourBackgroundColor,
                                  isOptionFourSelected,
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
                  padding: const EdgeInsets.all( 10.0 ),
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
                          Text('${addPollCount ? 1 + widget.questionDetails.viewCount : widget.questionDetails.viewCount}', style: countStyle, ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rippleRightUp,
                                  duration: Duration(seconds: 1),
                                  child: RevealIdentity(gangID: widget.gangID, questionID: widget.questionDetails.questionID,)));
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  'images/poll.png' ),
                              radius: 12,
                            ),
                            SizedBox( width: getDynamicWidth(5), ),
                            Text( '${(addPollCount ?
                            1 + widget.questionDetails.optionOnePolledCount+widget.questionDetails.optionTwoPolledCount+widget.questionDetails.optionThreePolledCount+widget.questionDetails.optionFourPolledCount
                                : widget.questionDetails.optionOnePolledCount+widget.questionDetails.optionTwoPolledCount+widget.questionDetails.optionThreePolledCount+widget.questionDetails.optionFourPolledCount
                            ).toString()}',
                              style: countStyle, ),
                          ],
                        ),
                      ),


                      widget.questionDetails.createdBy == USER_ID ? GestureDetector(
                        child: CircleAvatar(
                          backgroundImage:
                          AssetImage(isQuestionAnonymos ? 'images/questionAskedAnonymous.png' : 'images/questionNotAskedAnonymous.png'),
                          radius: 20,
                          backgroundColor: Colors.transparent,
                        ),
                        onTap: () {
                          final updateQuestionDetails = QuestionDetails(isAnonymous: isQuestionAnonymos ? false : true);
                          DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangID,widget.questionDetails.questionID);
                          setState(() {
                            isQuestionAnonymos ? isQuestionAnonymos = false : isQuestionAnonymos = true;
                          });
                          showFancyCustomDialogBottom(context , isQuestionAnonymos ? 'Now you are in anonymous mode, No one can know who asked this question.' : 'Now you revealed you\'r identity, Everyone can know asked this question.' );
                        },
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
                        child: CircleAvatar(
                          backgroundImage:
                          AssetImage(isAnswerAnonymos ? 'images/questionAskedAnonymous.png' :'images/questionNotAskedAnonymous.png' ),
                          radius: 20,
                          backgroundColor: Colors.transparent,
                        ),
                        onTap: () {
                          final updateInsightDetails = InsightsDetails(isAnonymous: isAnswerAnonymos ? false : true);
                          DBreference.updateInsights(updateInsightDetails, widget.gangID,widget.questionDetails.questionID);
                          setState(() {
                            isAnswerAnonymos ? isAnswerAnonymos = false : isAnswerAnonymos = true;
                          });
                          showFancyCustomDialog(context, isAnswerAnonymos ? 'Now you are in anonymous mode, No one can know what you polled.' : 'Now you revealed you\'r identity, Everyone can see what you polled.');
                        },
                      ),

                      GestureDetector(
                        onTap: () {
                          screenshotController.capture().then((File image) {
                            //Capture Done
                            setState(() async{
                              print(_imageFile);
                              _imageFile = image;
                              print(_imageFile);
                              final result = await ImageGallerySaver.saveImage(_imageFile.readAsBytesSync());
                              print(result);

                              showFancyCustomDialogShare(context, _imageFile);

                            });
                          }).catchError((onError) {
                            print(onError);
                          });
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.share, color: Colors.white, ),
                            ),
//
                          ],
                        ),
                      ),





                    ],
                  ),
                ),


//              RaisedButton(
//                onPressed: () {
//                  showFancyCustomDialog( context );
//                  _showSnackBar(context, "View Gang");
//                  final snackBar = SnackBar(
//                    content: Text('Yay! A SnackBar!'),
//                    action: SnackBarAction(
//                      label: 'Undo',
//                      onPressed: () {
//                        // Some code to undo the change.
//                      },
//                    ),
//                  );
//
//                  // Find the Scaffold in the widget tree and use
//                  // it to show a SnackBar.
//                  Scaffold.of(context).showSnackBar(snackBar);
//                },
//                child: Text('Show SnackBar'),
//              ),

              ],
            ),

          ),
        ),

      ),
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


  Widget OptionCard(int optionIndex, String polledCount, Color backgroundColor, bool isOptionSelected) {
    return Container(
      //height: getDynamicHeight(55),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular( 5 ),
      ),
      child: Padding(
        padding: const EdgeInsets.only( left: 15.0, right: 15.0 ,top:10,bottom:10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: getDynamicWidth(MediaQuery.of(context).size.width/1.5),

              child: GradientText(
                '${widget.questionDetails.options[optionIndex]}'.capitalize(),
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

void showFancyCustomDialog(BuildContext context, String message) {

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
                                Text(message,style: answerStyleBlur,),
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


void showFancyCustomDialogShare(BuildContext context, File image) {

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
              padding: const EdgeInsets.only(bottom: 0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: getDynamicHeight(500.0),
                  width: getDynamicWidth(400.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: getDynamicHeight(500),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GradientText(
                                  'Share',
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

                                image != null ? Image(image: FileImage(image),height: getDynamicHeight(200),width: getDynamicWidth(200),)
                                    : Container(height: getDynamicHeight(200),width: getDynamicWidth(200),),
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(image: AssetImage('images/whatsapp.png'),height: getDynamicHeight(40),width: getDynamicWidth(40),),
                                            SizedBox(width: getDynamicWidth(15),),
                                            Text("Share via WhatsApp",style: mediumStyle,),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: getDynamicHeight(15),),
                                      GestureDetector(
                                        onTap: () async{
                                          await SocialShare.shareFacebookStory(image.path,"#B21F1F","#FDBB2D", "https://deep-link-url",  appId: "168006534448917");

                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(image: AssetImage('images/facebook.png'),height: getDynamicHeight(35),width: getDynamicWidth(35),),
                                            SizedBox(width: getDynamicWidth(15),),
                                            Text("Share via Facebook",style: mediumStyle,),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: getDynamicHeight(15),),
                                      GestureDetector(
                                        onTap: () async{
                                          await SocialShare.shareInstagramStory(image.path, "#B21F1F", "#FDBB2D", "https://deep-link-url");

                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(image: AssetImage('images/instagram.png'),height: getDynamicHeight(35),width: getDynamicWidth(35),),
                                            SizedBox(width: getDynamicWidth(15),),
                                            Text("Share via Instagram",style: mediumStyle,),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: getDynamicHeight(15),),
                                      GestureDetector(
                                        onTap: () async {
                                          await ImageGallerySaver.saveImage(image.readAsBytesSync());
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(image: AssetImage('images/gallery.png'),height: getDynamicHeight(35),width: getDynamicWidth(35),),
                                            SizedBox(width: getDynamicWidth(15),),
                                            Text("Save to Gallery",style: mediumStyle,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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


void showFancyCustomDialogBottom(BuildContext context, String message) {

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
              padding: const EdgeInsets.only(top:500),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: getDynamicHeight(110.0),
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
                                Text(message,style: answerStyleBlur,),
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