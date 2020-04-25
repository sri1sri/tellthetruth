import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:finite_coverflow/finite_coverflow.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_share/social_share.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/firebase/firebase_common_variables.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/empty_questions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'display_single_question_page.dart';
import 'display_gang_members_page.dart';

class AllQuestions extends StatelessWidget {
  AllQuestions({@required this.gangDetails});
  GangDetails gangDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AllQuestions(
        gangDetails: gangDetails,
      ),
    );
  }
}

class F_AllQuestions extends StatefulWidget {
  F_AllQuestions({@required this.gangDetails});
  GangDetails gangDetails;

  @override
  _F_AllQuestionsState createState() => _F_AllQuestionsState();
}

class _F_AllQuestionsState extends State<F_AllQuestions> {
  bool _dropdownShown = false;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  void _toggleDropdown() {
    setState(() {
      _dropdownShown = !_dropdownShown;
    });
  }

  String whtsAppMessage =
      "I want you to join our gang in Tell The Truth! Please install from Android: https://play.google.com/store/apps/details?id=com.ludo.king iOS: https://itunes.apple.com/in/app/ludo-king/id993090598 .Click on ‘+’ go to join gang and enter gang code '12345'.Believe me this is awesome game!";

  @override
  void initState() {
//    show_interstitial_ad += show_interstitial_ad;
//    show_interstitial_ad == 5 ? Ads.showInterstitialAd() : Container(height: 0, width: 0,);
//
//    Ads.showBannerAd();
    Firestore.instance
        .collection('${API_SUFFIX}gangs')
        .document(widget.gangDetails.gangID)
        .collection('questions')
        .where('delete_at',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .snapshots()
        .listen(
          (data) => data.documents.forEach(
            (element) {
              DBreference.deleteQuestion(
                  widget.gangDetails.gangID, element.documentID);
            },
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
//    final primaryColor = Theme.of(context).primaryColor;
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              color: Colors.white,
              onPressed: () {
                _toggleDropdown();
                Navigator.pop(context, true);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onPressed: _toggleDropdown,
                color: Colors.white,
              ),
              OverlayContainer(
                show: _dropdownShown,
                position: OverlayContainerPosition(
                  -200,
                  -50,
                ),
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 1,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _toggleDropdown();
                          SocialShare.shareWhatsapp(
                              "I want you to join our gang in Tell The Truth! Please install from Android: https://play.google.com/store/apps/details?id=com.ludo.king iOS: https://itunes.apple.com/in/app/ludo-king/id993090598 Click on ‘+’ go to join gang and enter gang code '${widget.gangDetails.gangCode}'. Believe me this is awesome game");
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              "images/whatsapp.png",
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: getDynamicWidth(20),
                            ),
                            Text(
                              "Share code",
                              style: mediumTextStyleDark,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black54,
                      ),
                      GestureDetector(
                        onTap: () {
                          _toggleDropdown();
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rotate,
                              duration: Duration(seconds: 1),
                              child: GangMembers(
                                gangDetails: widget.gangDetails,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              "images/myGang.png",
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: getDynamicWidth(20),
                            ),
                            Text(
                              "View Gang",
                              style: mediumTextStyleDark,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black54,
                      ),
//                      GestureDetector(
//                        onTap: () {
//                          setState(() {
//                            _dropdownShown = false;
//                          });
//                        },
//                        child: Row(
//                          children: [
//                            Image.asset(
//                              "images/myQuestions.png",
//                              height: 30,
//                              width: 30,
//                            ),
////                            SizedBox(
////                              width: getDynamicWidth(20),
////                            ),
////                            Text(
////                              "Edit Post",
////                              style: mediumTextStyleDark,
////                            )
//                          ],
//                        ),
//                      )
                    ],
                  ),
                ),
              ),
            ],
            centerTitle: true,
            title: GradientText(
              widget.gangDetails.gangName,
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
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<QuestionDetails>>(
      stream: DBreference.readQuestions(widget.gangDetails.gangID),
      builder: (context, questionsSnapshot) {
        return questionsSnapshot.data != null
            ? questionsSnapshot.data.length != 0
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 1.0,
                    children: List.generate(
                      questionsSnapshot.data != null
                          ? questionsSnapshot.data.length
                          : 0,
                      (index) {
                        return _QuestionListCard(questionsSnapshot.data[index]);
                      },
                    ),
                  )
                : EmptyQuestions()
            : Container(
                height: 0,
                width: 0,
              );
      },
    );
  }

  Widget _QuestionListCard(QuestionDetails questionData) {
    return StreamBuilder<InsightsDetails>(
      stream: DBreference.myInsight(
          widget.gangDetails.gangID, questionData.questionID),
      builder: (context, snapshot) {
        final insightsData = snapshot.data;
        return ExpandPageTransition(
          navigateToPage: SingleQuestion(
            gangID: widget.gangDetails.gangID,
            questionDetails: questionData,
            insightsDetails: insightsData,
          ),
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return FlatButton(
              disabledColor: Colors.white,
              onPressed: (){
                _toggleDropdown();
                openContainer();
              },
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(colors: <Color>[
                    Color(int.tryParse(questionData != null
                        ? questionData.color1
                        : 0Xff30DD76)),
                    Color(int.tryParse(questionData != null
                        ? questionData.color2
                        : 0Xff30DD76)),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                height: getDynamicHeight(350),
                width: getDynamicWidth(200.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(height: getDynamicHeight(300.0)),
                        Positioned(
                          child: Container(
                            height: getDynamicHeight(310),
                            width: getDynamicWidth(200.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(int.tryParse(questionData != null
                                          ? questionData.color1
                                          : 0Xff30DD76)),
                                      Color(int.tryParse(questionData != null
                                          ? questionData.color2
                                          : 0Xff30DD76)),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: questionData !=
                                                      null
                                                  ? questionData
                                                              .createByGender ==
                                                          'male'
                                                      ? AssetImage(
                                                          'images/boy.png')
                                                      : AssetImage(
                                                          'images/girl.png')
                                                  : Container(
                                                      height: 0,
                                                      width: 0,
                                                    ),
                                              radius: 15,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    TyperAnimatedTextKit(
                                      onTap: openContainer,
                                      text: [
//                                        'Ready',
//                                        'Get Set',
//                                        'Your Question',
                                        '${questionData.question}?'
                                            .capitalize(),
                                      ],
                                      textStyle: mediumTextStyleLight,
                                      textAlign: TextAlign.center,
                                      alignment: AlignmentDirectional.topCenter,
                                      isRepeatingAnimation:
                                          false, // or Alignment.topLeft
                                    ),
                                    insightsData == null
                                        ? BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5,
                                              sigmaY: 5,
                                            ),
                                            child: Container(
                                              height: getDynamicHeight(1),
                                              width: getDynamicWidth(1),
                                              color:
                                                  Colors.black.withOpacity(0.0),
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                            width: 0,
                                          ),
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.end,
//                                      children: [
//                                        Row(
//                                          children: [
//                                            CircleAvatar(
//                                              backgroundColor:
//                                                  Colors.transparent,
//                                              backgroundImage:
//                                                  AssetImage('images/seen.png'),
//                                              radius: 14,
//                                            ),
//                                            SizedBox(
//                                              width: getDynamicWidth(5),
//                                            ),
//                                            Text(
//                                              questionData.viewCount.toString(),
//                                              style: verySmallTextStyleLight,
//                                            ),
//                                          ],
//                                        ),
////                                        SizedBox(
////                                          width: getDynamicWidth(20),
////                                        ),
////                                        Row(
////                                          children: [
////                                            CircleAvatar(
////                                              backgroundColor:
////                                                  Colors.transparent,
////                                              backgroundImage:
////                                                  AssetImage('images/poll.png'),
////                                              radius: 12,
////                                            ),
////                                            SizedBox(
////                                              width: getDynamicWidth(5),
////                                            ),
////                                            Text(
////                                              '${questionData != null ? (questionData.optionOnePolledCount + questionData.optionTwoPolledCount + questionData.optionThreePolledCount + questionData.optionFourPolledCount).toString() : '0'}',
////                                              style: verySmallTextStyleLight,
////                                            ),
////                                          ],
////                                        ),
//                                      ],
//                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CustomData {
  var _name;
  var _isShow;

  String get name => _name;

  bool get isShow => _isShow;

  set isShow(bool value) {
    _isShow = value;
  }

  set name(String value) {
    _name = value;
  }

  CustomData(this._name, this._isShow);
}
