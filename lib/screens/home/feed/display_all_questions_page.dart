import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/empty_questions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'display_single_question_page.dart';
import 'disaply_gang_members_page.dart';

class AllQuestions extends StatelessWidget {
  AllQuestions({@required this.gangID, @required this.gangName});
  String gangID;
  String gangName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AllQuestions(gangID: gangID, gangName: gangName),
    );
  }
}

class F_AllQuestions extends StatefulWidget {
  F_AllQuestions({@required this.gangID, @required this.gangName});
  String gangID;
  String gangName;

  @override
  _F_AllQuestionsState createState() => _F_AllQuestionsState();
}

class _F_AllQuestionsState extends State<F_AllQuestions> {

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
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
                Navigator.pop(context, true);
              },
            ),
            centerTitle: true,
            title: GradientText(
              widget.gangName,
              style: boldStyle,
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
    floatingActionButton: Builder(
    builder: (context) => FabCircularMenu(
    key: fabKey,
    // Cannot be `Alignment.center`
    alignment: Alignment.bottomRight,
    ringColor: Colors.black.withOpacity(0.2),
    ringDiameter: 500.0,
    ringWidth: 150.0,
    fabSize: 64.0,
    fabElevation: 20.0,

    // Also can use specific color based on wether
    // the menu is open or not:
     fabOpenColor: Colors.black54,
    fabCloseColor: Colors.grey,
    // These properties take precedence over fabColor
    fabColor: Colors.white,
    fabOpenIcon: Icon(Icons.menu, color: Colors.white),
    fabCloseIcon: Icon(Icons.close, color: primaryColor),
    fabMargin: const EdgeInsets.all(16.0),
    animationDuration: const Duration(milliseconds: 800),
    animationCurve: Curves.easeInOutCirc,
    onDisplayChange: (isOpen) {
    _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
    },
    children: <Widget>[
    RawMaterialButton(
    onPressed: () {
    _showSnackBar(context, "Edit Post");
    },
    shape: CircleBorder(),
    padding: const EdgeInsets.all(24.0),
    child: Container(
      height: 140,
      child: Column(
        children: [
          Image.asset("images/people.png",height: 70,width: 70,),
          SizedBox(height: getDynamicHeight(5),),
          Text("Edit Post",style: answerStyle,)

        ],
      ),
    )
    ),
    RawMaterialButton(
    onPressed: () {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rotate,
              duration: Duration(seconds: 1),
              child: GangMembers()));
    _showSnackBar(context, "View Gang");
    },
    shape: CircleBorder(),
    padding: const EdgeInsets.all(24.0),
    child: Container(
      height: 110,
      child: Column(
        children: [
          Image.asset("images/team.png",height: 70,width: 70,),
          SizedBox(height: getDynamicHeight(5),),
          Text("View Gang",style: answerStyle,)

        ],
      ),
    )
    ),
    RawMaterialButton(
    onPressed: () {
      FlutterOpenWhatsapp.sendSingleMessage("",
          "I want you to join our gang in Tell The Truth! Please install from Android: https://play.google.com/store/apps/details?id=com.ludo.king iOS: https://itunes.apple.com/in/app/ludo-king/id993090598 .Click on ‘+’ go to join gang and enter gang code '12345'.Believe me this is awesome game!");
    _showSnackBar(context, "Share Via WhatsApp");
    },
    shape: CircleBorder(),
    padding: const EdgeInsets.all(24.0),
    child: Container(
      height: 100,
      child: Column(
        children: [
          Image.asset("images/wha.png",height: 70,width: 70,),
          SizedBox(height: getDynamicHeight(5),),
          Text("Share",style: answerStyle,)

        ],
      ),
    )
    ),
    ],
    ),
    ),

        ),
      ),
    );

  }

  void _showSnackBar (BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message,style: questionStyle1),
          duration: const Duration(milliseconds: 1000),
        )
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<QuestionDetails>>(
      stream: DBreference.readQuestions(widget.gangID),
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
            : null;
      },
    );
  }

  Widget _QuestionListCard(QuestionDetails questionData) {
    return StreamBuilder<InsightsDetails>(
      stream: DBreference.myInsight(widget.gangID, questionData.questionID),
      builder: (context, snapshot) {
        final insightsData = snapshot.data;
        return ExpandPageTransition(
          navigateToPage: SingleQuestion(
            gangID: widget.gangID,
            questionDetails: questionData,
            insightsDetails: insightsData != null ? insightsData : null,
          ),
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return FlatButton(
              disabledColor: Colors.white,
              onPressed: openContainer,
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: Container(
                height: getDynamicHeight(300),
                width: getDynamicWidth(200.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(height: getDynamicHeight(300.0)),
                        Positioned(
                          child: Container(
                            height: getDynamicHeight(300),
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
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                      text: [
                                        'Ready',
                                        'Get Set',
                                        'Your Question',
                                        '${questionData.question}?'
                                            .capitalize(),
                                      ],
                                      textStyle: questionStyle,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage:
                                                  AssetImage('images/seen.png'),
                                              radius: 14,
                                            ),
                                            SizedBox(
                                              width: getDynamicWidth(5),
                                            ),
                                            Text(
                                              questionData.viewCount.toString(),
                                              style: countStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: getDynamicWidth(20),
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage:
                                                  AssetImage('images/poll.png'),
                                              radius: 12,
                                            ),
                                            SizedBox(
                                              width: getDynamicWidth(5),
                                            ),
                                            Text(
                                              '${questionData != null ? (questionData.optionOnePolledCount + questionData.optionTwoPolledCount + questionData.optionThreePolledCount + questionData.optionFourPolledCount).toString() : '0'}',
                                              style: countStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
