import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/gang_notification_model.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
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
  SingleQuestion(
      {@required this.questionDetails,
      @required this.gangDetails,
      @required this.insightsDetails});
  GangDetails gangDetails;
  QuestionDetails questionDetails;
  InsightsDetails insightsDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SingleQuestion(
          questionDetails: questionDetails,
          gangDetails: gangDetails,
          insightsDetails: insightsDetails),
    );
  }
}

class F_SingleQuestion extends StatefulWidget {
  F_SingleQuestion(
      {@required this.questionDetails,
      @required this.gangDetails,
      @required this.insightsDetails});
  GangDetails gangDetails;
  QuestionDetails questionDetails;
  InsightsDetails insightsDetails;

  @override
  _F_SingleQuestionState createState() => _F_SingleQuestionState();
}

class _F_SingleQuestionState extends State<F_SingleQuestion> {
  static const duration = const Duration(seconds: 1);

  bool isActive = true;
  Timer timer;
  int secondsLeft;

  List<String> optionOneBackgroundColor = ['E3E3E3', 'E3E3E3'];
  List<String> optionTwoBackgroundColor = ['E3E3E3', 'E3E3E3'];
  List<String> optionThreeBackgroundColor = ['E3E3E3', 'E3E3E3'];
  List<String> optionFourBackgroundColor = ['E3E3E3', 'E3E3E3'];

  int optionOnePolledCount = 0;
  int optionTwoPolledCount = 0;
  int optionThreePolledCount = 0;
  int optionFourPolledCount = 0;

  int viewCount = 0;
  int polledCount = 0;

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

  bool canAnswer = true;

//  bool _dropdownShown = false;
//
//  void _toggleDropdown() {
//    setState(() {
//      _dropdownShown = !_dropdownShown;
//    });
//  }

  void handleTick() {
    if (isActive) {
      if (this.mounted) {
        setState(() {
          secondsLeft = secondsLeft - 1;
        });
      }
    }
  }

  Future<bool> updateData() async {

    viewCount = widget.questionDetails.viewCount;
    polledCount = widget.questionDetails.optionOnePolledCount +
        widget.questionDetails.optionTwoPolledCount +
        widget.questionDetails.optionThreePolledCount +
        widget.questionDetails.optionFourPolledCount;

    if (widget.insightsDetails == null) {
      final updateQuestionDetails = QuestionDetails(
        viewCount: widget.questionDetails.viewCount + 1,
      );
      final createInsightDetails =
          InsightsDetails(isViewed: true, isReported: false);

      await DBreference.updateQuestionDetails(updateQuestionDetails,
          widget.gangDetails.gangID, widget.questionDetails.questionID);
      await DBreference.createInsights(createInsightDetails, widget.gangDetails.gangID,
          widget.questionDetails.questionID);

      setState(() {
        viewCount = viewCount + 1;
      });
    }

    if (widget.insightsDetails.optionSelected != null) {
      setState(() {
        selectedOption = widget.insightsDetails.optionSelected;
        isPolled = true;

        switch (selectedOption) {
          case 1:
            optionOneBackgroundColor = [
              widget.questionDetails.color1,
              widget.questionDetails.color2
            ];
            isOptionOneSelected = true;
            break;
          case 2:
            optionTwoBackgroundColor = [
              widget.questionDetails.color1,
              widget.questionDetails.color2
            ];
            isOptionTwoSelected = true;
            break;
          case 3:
            optionThreeBackgroundColor = [
              widget.questionDetails.color1,
              widget.questionDetails.color2
            ];
            isOptionThreeSelected = true;
            break;
          case 4:
            optionFourBackgroundColor = [
              widget.questionDetails.color1,
              widget.questionDetails.color2
            ];
            isOptionFourSelected = true;
            break;
        }
      });
    } else {
      setState(() {
        isPolled = false;
      });
    }

    widget.insightsDetails.optionSelected == null
        ? setState(() {
            isPolled = false;
          })
        : setState(() {
            selectedOption = widget.insightsDetails.optionSelected;
            isPolled = true;

            switch (selectedOption) {
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

//    Ads.showBannerAd();
    secondsLeft =
        ((widget.questionDetails.endsAt.toDate().millisecondsSinceEpoch -
                    DateTime.now().millisecondsSinceEpoch) ~/
                1000)
            .toInt();

    updateData();

    optionOnePolledCount = widget.questionDetails.optionOnePolledCount;
    optionTwoPolledCount = widget.questionDetails.optionTwoPolledCount;
    optionThreePolledCount = widget.questionDetails.optionThreePolledCount;
    optionFourPolledCount = widget.questionDetails.optionFourPolledCount;

    isAnswerAnonymos = widget.insightsDetails == null
        ? true
        : widget.insightsDetails.isAnonymous != null
            ? widget.insightsDetails.isAnonymous
            : true;
    isQuestionAnonymos = widget.questionDetails.isAnonymous;

    viewCount = widget.questionDetails.viewCount;
    polledCount = widget.questionDetails.optionOnePolledCount +
        widget.questionDetails.optionTwoPolledCount +
        widget.questionDetails.optionThreePolledCount +
        widget.questionDetails.optionFourPolledCount;
  }

  void updateInsights(int optionSelected) {
    switch (optionSelected) {
      case 1:
        final updateQuestionDetails = QuestionDetails(
          optionOnePolledCount: widget.questionDetails.optionOnePolledCount + 1,
        );
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangDetails.gangID,
            widget.questionDetails.questionID);
        break;
      case 2:
        final updateQuestionDetails = QuestionDetails(
          optionTwoPolledCount: widget.questionDetails.optionTwoPolledCount + 1,
        );
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangDetails.gangID,
            widget.questionDetails.questionID);
        break;
      case 3:
        final updateQuestionDetails = QuestionDetails(
          optionThreePolledCount:
              widget.questionDetails.optionThreePolledCount + 1,
        );
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangDetails.gangID,
            widget.questionDetails.questionID);
        break;
      case 4:
        final updateQuestionDetails = QuestionDetails(
          optionFourPolledCount:
              widget.questionDetails.optionFourPolledCount + 1,
        );
        DBreference.updateQuestionDetails(updateQuestionDetails, widget.gangDetails.gangID,
            widget.questionDetails.questionID);
        break;
    }

    final updateInsightDetails =
        InsightsDetails(optionSelected: optionSelected, isAnonymous: true);
    DBreference.updateInsights(
        updateInsightDetails, widget.gangDetails.gangID, widget.questionDetails.questionID);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      child: offlineWidget(context),
      controller: screenshotController,
    );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(int.tryParse(widget.questionDetails.color1)),
          Color(int.tryParse(widget.questionDetails.color2)),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(58.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context, true);
                },
              ),
              actions: [
                TimerText(secondsLeft: secondsLeft),
                SizedBox(width: getDynamicWidth(70),),
                widget.questionDetails.createdBy != USER_ID
                    ? IconButton(
                  icon: Icon(
                    Icons.report,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    CustomAlertBox(
                        context,
                        'Report',
                        'Are you sure what to report this question ? Uploader will be notified and this question will be removed.',
                        true, () {
                      final updateInsightDetails =
                      InsightsDetails(isReported: true);
                      DBreference.updateInsights(
                          updateInsightDetails,
                          widget.gangDetails.gangID,
                          widget.questionDetails.questionID);
                      GoToPage(context, LandingPage(), true);
                    });
                  },
                  color: Colors.white,
                )
                    : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    CustomAlertBox(
                        context,
                        'Delete',
                        'Are you sure what to delete this question ?',
                        true, () {
                      DBreference.deleteQuestion(widget.gangDetails.gangID,
                          widget.questionDetails.questionID);
                      DBreference.deleteInsights(widget.gangDetails.gangID,
                          widget.questionDetails.questionID);
                      GoToPage(context, LandingPage(), true);
                    });
                  },
                  color: Colors.white,
                ),
              ],
            ),
        ),

        body: SingleChildScrollView(
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: getDynamicHeight(20),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.questionDetails.createdBy == USER_ID
                          ? GestureDetector(
                        onTap: () async{
                          final updateQuestionDetails = QuestionDetails(
                              isAnonymous: !isQuestionAnonymos);
                          final gangNotifications = GangNotifications(
                              topic: widget.gangDetails.gangNotificationToken,
                              title: 'Question identity has been revealed for this question.',
                              message: widget.questionDetails.question,
                              navigateTo: 'answer identity revealed');
                          
                          
                         await DBreference.updateQuestionDetails(
                              updateQuestionDetails,
                              widget.gangDetails.gangID,
                              widget.questionDetails.questionID);
                          setState(() {
                            isQuestionAnonymos = !isQuestionAnonymos;
                          });
                          !isQuestionAnonymos ? await DBreference.createNotification(gangNotifications) : null;
                        },
                        child: Padding(
                          padding:
                          EdgeInsets.only(bottom: getDynamicHeight(15.0)),
                          child: Text(
                            isQuestionAnonymos
                                ? "Questioned anonymous"
                                : '${USER_NAME}\'s question',
                            style: mediumTextStyleLight,
                          ),
                        ),
                      )
                          : Padding(
              padding:
              EdgeInsets.only(bottom: getDynamicHeight(15.0)),
      child: Text(
        isQuestionAnonymos
            ? "Anonymou's question"
            : 'Question identity revealed',
        style: mediumTextStyleLight,
      ),
    ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: getDynamicWidth(25.0),
                            right: getDynamicWidth(25.0)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(getDynamicWidth(25.0),
                                getDynamicHeight(15.0), getDynamicWidth(25.0), 0.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      getDynamicWidth(10.0),
                                      getDynamicHeight(10.0),
                                      getDynamicWidth(10.0),
                                      getDynamicHeight(5.0)),
                                  child: AutoSizeText(
                                    widget.questionDetails.question,
                                    style: mediumTextStyleDark,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          if(secondsLeft > 0){
                                            if (!isPolled) {
                                              if (await Vibration
                                                  .hasAmplitudeControl()) {
                                                Vibration.vibrate(amplitude: 128);
                                              }
                                              setState(() {
                                                polledCount = polledCount + 1;
                                                optionOneBackgroundColor = [
                                                  widget.questionDetails.color1,
                                                  widget.questionDetails.color2
                                                ];
                                                isPolled = true;
                                                optionOnePolledCount =
                                                    optionOnePolledCount + 1;
                                                isOptionOneSelected = true;
                                                addPollCount = true;
                                              });
                                              updateInsights(1);
                                            }
                                          }
                                        },
                                        child: optionsStyle(
                                          0,
                                          '${optionOnePolledCount.toString()} votes',
                                          selectedOption == 0
                                              ? optionOneBackgroundColor
                                              : selectedOption == 1
                                              ? [
                                            widget.questionDetails.color1,
                                            widget.questionDetails.color2
                                          ]
                                              : optionOneBackgroundColor,
                                          isOptionOneSelected,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 1,
                                          width: getDynamicWidth(350),
                                          child: Container(
                                            color: Colors.white,
                                          )),
                                      GestureDetector(
                                        onTap: () async {
                                          if(secondsLeft > 0){
                                            if (!isPolled) {
                                              if (await Vibration
                                                  .hasAmplitudeControl()) {
                                                Vibration.vibrate(amplitude: 128);
                                              }
                                              setState(() {
                                                polledCount = polledCount + 1;
                                                optionTwoBackgroundColor = [
                                                  widget.questionDetails.color1,
                                                  widget.questionDetails.color2
                                                ];
                                                isPolled = true;
                                                optionTwoPolledCount =
                                                    optionTwoPolledCount + 1;
                                                isOptionTwoSelected = true;
                                                addPollCount = true;
                                              });
                                              updateInsights(2);
                                            }
                                          }
                                        },
                                        child: optionsStyle(
                                          1,
                                          '${optionTwoPolledCount.toString()} votes',
                                          selectedOption == 0
                                              ? optionTwoBackgroundColor
                                              : selectedOption == 2
                                              ? [
                                            widget.questionDetails.color1,
                                            widget.questionDetails.color2
                                          ]
                                              : optionTwoBackgroundColor,
                                          isOptionTwoSelected,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 1,
                                          width: getDynamicWidth(350),
                                          child: Container(
                                            color: Colors.white,
                                          )),
                                      GestureDetector(
                                        onTap: () async {
                                          if(secondsLeft > 0){
                                            if (!isPolled) {
                                              if (await Vibration
                                                  .hasAmplitudeControl()) {
                                                Vibration.vibrate(amplitude: 128);
                                              }
                                              setState(() {
                                                polledCount = polledCount + 1;
                                                optionThreeBackgroundColor = [
                                                  widget.questionDetails.color1,
                                                  widget.questionDetails.color2
                                                ];
                                                isPolled = true;
                                                optionThreePolledCount =
                                                    optionThreePolledCount + 1;
                                                isOptionThreeSelected = true;
                                                addPollCount = true;
                                              });
                                              updateInsights(3);
                                            }
                                          }
                                        },
                                        child: optionsStyle(
                                          2,
                                          '${optionThreePolledCount.toString()} votes',
                                          selectedOption == 0
                                              ? optionThreeBackgroundColor
                                              : selectedOption == 3
                                              ? [
                                            widget.questionDetails.color1,
                                            widget.questionDetails.color2
                                          ]
                                              : optionThreeBackgroundColor,
                                          isOptionThreeSelected,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 1,
                                          width: getDynamicWidth(350),
                                          child: Container(
                                            color: Colors.white,
                                          )),
                                      GestureDetector(
                                        onTap: () async {
                                          if(secondsLeft > 0){
                                            if (!isPolled) {
                                              if (await Vibration
                                                  .hasAmplitudeControl()) {
                                                Vibration.vibrate(amplitude: 128);
                                              }
                                              setState(() {
                                                polledCount = polledCount + 1;
                                                optionFourBackgroundColor = [
                                                  widget.questionDetails.color1,
                                                  widget.questionDetails.color2
                                                ];
                                                isPolled = true;
                                                optionFourPolledCount =
                                                    optionFourPolledCount + 1;
                                                isOptionFourSelected = true;
                                                addPollCount = true;
                                              });
                                              updateInsights(4);
                                            }
                                          }
                                        },
                                        child: optionsStyle(
                                          3,
                                          '${optionFourPolledCount.toString()} votes',
                                          selectedOption == 0
                                              ? optionFourBackgroundColor
                                              : selectedOption == 4
                                              ? [
                                            widget.questionDetails.color1,
                                            widget.questionDetails.color2
                                          ]
                                              : optionFourBackgroundColor,
                                          isOptionFourSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      getDynamicWidth(10.0),
                                      getDynamicHeight(20.0),
                                      getDynamicWidth(10.0),
                                      getDynamicHeight(15.0)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${viewCount.toString()} views',
                                        style: smallTextStyleDark,
                                      ),


                                      GestureDetector(
                                        onTap: () {
                                          GoToPage(context, RevealIdentity(
                                            gangID: widget.gangDetails.gangID,
                                            questionID:
                                            widget.questionDetails.questionID,
                                            pageTitle: isQuestionAnonymos ? "Anonymou's question" : "${widget.questionDetails.createdByUsername}'s question",
                                          ), false);
                                        },
                                        child: Text(
                                          '${polledCount.toString()} votes',
                                          style: smallTextStyleDark,
                                        ),
                                      ),


                                      Text(
                                        '30 votes',
                                        style: smallTextStyleLight,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          screenshotController
                                              .capture()
                                              .then((File image) {
                                            setState(() async {

                                              var status = await Permission.storage.status;
                                              if (status.isUndetermined) {
                                                Permission.storage.request();
                                              }

                                              await ImageGallerySaver.saveImage(
                                                  image.readAsBytesSync());



                                              showFancyCustomDialogShare(
                                                  context, image);
                                            });
                                          }).catchError((onError) {
                                            print(onError);
                                          });
                                        },
                                        child: Text(
                                          'share',
                                          style: smallTextStyleDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          final updateInsightDetails =
                          InsightsDetails(isAnonymous: !isAnswerAnonymos);
                          final gangNotifications = GangNotifications(
                              topic: widget.gangDetails.gangNotificationToken,
                              title: 'Answer identity has been revealed for this question.',
                              message: widget.questionDetails.question,
                              navigateTo: 'answer identity revealed');

                          await DBreference.updateInsights(updateInsightDetails,
                              widget.gangDetails.gangID, widget.questionDetails.questionID);

                          setState(() {
                            isAnswerAnonymos = !isAnswerAnonymos;
                          });
                          !isAnswerAnonymos ? await DBreference.createNotification(gangNotifications) : null;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: getDynamicHeight(15.0)),
                          child: Text(
                            isAnswerAnonymos
                                ? 'Answered anonymous'
                                : '${USER_NAME}\'s answer',
                            style: mediumTextStyleLight,
                          ),
                        ),
                      ),
//                  SizedBox(height: 60,),


                    ],
                  ),
                ),
              ),


              Container(height: 60,color: Colors.transparent,width: 300,),
            ],
          ),
        ),
      ),
    );
  }

//  Color selectBackgroundColor = Colors.white;
//  Color textColor = Colors.red;

  Widget optionsStyle(int optionIndex, String polledCount,
      List<String> backgroundColorCode, bool isOptionSelected) {
    return Container(
      width: getDynamicWidth(350),
      //height: getDynamicHeight(55),
      decoration: BoxDecoration(
          borderRadius: optionIndex == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )
              : optionIndex == 3
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isOptionSelected
                ? <Color>[
                    Color(int.tryParse(backgroundColorCode[0])),
                    Color(int.tryParse(backgroundColorCode[1])),
                  ]
                : <Color>[
                    Colors.grey[350],
                    Colors.grey[350],
                  ],
          )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AutoSizeText(
              '${widget.questionDetails.options[optionIndex]}'.capitalize(),
              style: smallTextStyleLight,
              maxLines: 2,
            ),
            AutoSizeText(
              getCount(optionIndex),
              style: smallTextStyleLight,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  String getCount(int index){
    switch(index){
      case 0:
        return optionOnePolledCount.toString();
        break;
      case 1:
        return optionTwoPolledCount.toString();
        break;
      case 2:
        return optionThreePolledCount.toString();
        break;
      case 3:
        return optionFourPolledCount.toString();
        break;
    }
    return 'f';
  }

}



class TimerText extends StatelessWidget {
  TimerText({this.secondsLeft});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GradientText(
            '${convertSeconds(secondsLeft > 0 ? secondsLeft : 0)[0].toString().padLeft(2, '0')} : ${convertSeconds(secondsLeft > 0 ? secondsLeft : 0)[1].toString().padLeft(2, '0')} : ${convertSeconds(secondsLeft > 0 ? secondsLeft : 0)[2].toString().padLeft(2, '0')}',
            textAlign: TextAlign.center,
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
//          GradientText(
//            '$label',
//            style: smallTextStyleLight,
//            gradient: LinearGradient(
//              colors: [
//                Color(0XffFD8B1F),
//                Color(0XffD152E0),
//                Color(0Xff30D0DB),
//              ],
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//            ),
//          ),
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
                                Text(
                                  message,
                                  style: smallTextStyleDark,
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
                                  style: foregroundTextStyleDark,
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
                                image != null
                                    ? Image(
                                        image: FileImage(image),
                                        height: getDynamicHeight(200),
                                        width: getDynamicWidth(200),
                                      )
                                    : Container(
                                        height: getDynamicHeight(200),
                                        width: getDynamicWidth(200),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async{
                                          final ByteData bytess = await rootBundle.load(image.path);
                                              await Share.file('Tell The Truth', 'tellthetruth.png', bytess.buffer.asUint8List(), 'image/png');

                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'images/whatsapp.png'),
                                              height: getDynamicHeight(40),
                                              width: getDynamicWidth(40),
                                            ),
                                            SizedBox(
                                              width: getDynamicWidth(15),
                                            ),
                                            Text(
                                              "Share via WhatsApp",
                                              style: mediumTextStyleDark,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getDynamicHeight(15),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await SocialShare.shareFacebookStory(
                                              image.path,
                                              "#B21F1F",
                                              "#FDBB2D",
                                              "https://deep-link-url");

                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'images/facebook.png'),
                                              height: getDynamicHeight(35),
                                              width: getDynamicWidth(35),
                                            ),
                                            SizedBox(
                                              width: getDynamicWidth(15),
                                            ),
                                            Text(
                                              "Share via Facebook",
                                              style: mediumTextStyleDark,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getDynamicHeight(15),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await SocialShare.shareInstagramStory(
                                              image.path,
                                              "#B21F1F",
                                              "#FDBB2D",
                                              "https://deep-link-url");

                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'images/instagram.png'),
                                              height: getDynamicHeight(35),
                                              width: getDynamicWidth(35),
                                            ),
                                            SizedBox(
                                              width: getDynamicWidth(15),
                                            ),
                                            Text(
                                              "Share via Instagram",
                                              style: mediumTextStyleDark,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getDynamicHeight(15),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await ImageGallerySaver.saveImage(
                                              image.readAsBytesSync());
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'images/gallery.png'),
                                              height: getDynamicHeight(35),
                                              width: getDynamicWidth(35),
                                            ),
                                            SizedBox(
                                              width: getDynamicWidth(15),
                                            ),
                                            Text(
                                              "Save to Gallery",
                                              style: mediumTextStyleDark,
                                            ),
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
              padding: const EdgeInsets.only(top: 500),
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
                                Text(
                                  message,
                                  style: smallTextStyleDark,
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