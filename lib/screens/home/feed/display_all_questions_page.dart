import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

import 'diaplay_single_question_page.dart';
import 'disaply_gang_members_page.dart';


const backgroundGradient = LinearGradient(colors: <Color>[
  Color(0XffFD8B1F),
  Color(0XffD152E0),
  Color(0Xff30D0DB),
], begin: Alignment.topLeft, end: Alignment.bottomRight);
const activeGradient = LinearGradient(
  colors: <Color>[
    Color(0XffD152E0),
    Color(0Xff30D0DB),
    Color(0XffFD8B1F),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const backgroundGradient1 = LinearGradient(colors: <Color>[
  Color(0XffD152E0),
  Color(0Xff30D0DB),
], begin: Alignment.topLeft, end: Alignment.bottomRight);
const backgroundGradient2 = LinearGradient(colors: <Color>[
  Color(0XffFD8B1F),
  Color(0XffD152E0),
], begin: Alignment.topLeft, end: Alignment.bottomRight);



class AllQuestions extends StatelessWidget {
  AllQuestions({@required this.gangID, @required this.gangName});
  String gangID;
  String gangName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AllQuestions(gangID: gangID,gangName: gangName),
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

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              color: Colors.white,
              onPressed: () {Navigator.pop(context, true);},
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
            actions: [
              IconButton(
                icon: Icon(Icons.list,color: Colors.black,),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1), child: GangMembers()));
                },
              ),
              GestureDetector(
                  onTap: (){},
                  child: Image.asset('images/what.jpeg',height: getDynamicHeight(30),width: getDynamicWidth(30),)
              ),
              IconButton(
                icon: Icon(Icons.person_add,color: Colors.black,),
                color: Colors.white,
                onPressed: () {
                  //Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1), child: GangMembers()));
                },
              ),

            ],
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
        stream: DBreference.readQuestions(widget.gangID),
        builder: (context, snapshot) {
          print('count ${snapshot.data.length}');
          return ListItemsBuilder<QuestionDetails>(
              snapshot: snapshot,
              itemBuilder: (context, data) =>
              
              StreamBuilder<InsightsDetails>(
            stream: DBreference.myInsight(widget.gangID, data.questionID),
            builder: (context, snapshot) { 
              
              final insightData = snapshot.data;
              
              return Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      SafeArea(
                        child: Container(
                          height: MediaQuery.of(context).size.height/1.2,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(0.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 0,
                                      childAspectRatio: 0.57,
                                      children: [
                                        _QuestionListCard(data, insightData),
                                      ]
                                  )
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }

          ),
          
    );
    },
    );
  }



  Widget _QuestionListCard(QuestionDetails questionData, InsightsDetails insightsData) {
    return ExpandPageTransition(

      navigateToPage: SingleQuestion(),
      transitionType: ContainerTransitionType.fade,

      closedBuilder: (BuildContext _, VoidCallback openContainer) {

       return FlatButton(
            disabledColor: Colors.white,
            onPressed: openContainer,
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Container(
                height: 300.0,
                width: getDynamicWidth(200.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                        children: [
                          Container(

                              height: getDynamicHeight(300.0)
                          ),
                          Positioned(

                            child:  Container(
                              height: 300.0,
                              width: getDynamicWidth(200.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    gradient: LinearGradient(colors: <Color>[
                                      Color(int.tryParse(questionData != null ? questionData.color1 : 0Xff30DD76)),
                                      Color(int.tryParse(questionData != null ? questionData.color2 : 0Xff30DD76)),
                                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(),

                                              Row(
                                                children: [

                                                   CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    backgroundImage: questionData != null ? questionData.createByGender == 'male' ? AssetImage(
                                                        'images/boy.png') : AssetImage(
                                                        'images/girl.png') : Container(height: 0, width: 0,),
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
                                              '${questionData.question}?'.capitalize(),
                                            ],
                                            textStyle: questionStyle,
                                            textAlign: TextAlign.center,
                                            alignment: AlignmentDirectional.topCenter,
                                            isRepeatingAnimation: false,// or Alignment.topLeft
                                          ),
                                          insightsData == null ? BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5,
                                              sigmaY: 5,
                                            ),
                                            child: Container(
                                              height: getDynamicHeight(1),
                                              width: getDynamicWidth(1),
                                              color: Colors.black.withOpacity(0.0),
                                            ),
                                          ) : Container(
                                            height: 0,
                                            width: 0,
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        'images/seen.png'),
                                                    radius: 14,
                                                  ),
                                                  SizedBox(width: getDynamicWidth(5),),
                                                  Text(questionData.viewCount.toString(),style: countStyle,),
                                                ],
                                              ),
                                              SizedBox(width: getDynamicWidth(20),),

                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        'images/poll.png'),
                                                    radius: 12,
                                                  ),
                                                  SizedBox(width: getDynamicWidth(5),),
                                                  Text(questionData.answeredCount.toString(),style: countStyle,),
                                                ],
                                              ),
                                            ],
                                          ),

                                        ]
                                    ),
                                  )
                              ),
                            ),

                          ),
                        ]
                    ),
                  ],
                )
            )
        );
      }
      );
  }
}