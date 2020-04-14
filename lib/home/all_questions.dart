import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tellthetruth/common_variables/sizeConfig.dart';
import 'package:tellthetruth/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/home/Question.dart';
import 'package:tellthetruth/home/groupMembers.dart';


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



class QuestionsPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_QuestionsPage(),
    );
  }
}

class F_QuestionsPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_QuestionsPageState createState() => _F_QuestionsPageState();
}

class _F_QuestionsPageState extends State<F_QuestionsPage> {

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
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
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          backgroundColor:Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              color: Colors.white,
              onPressed: () {Navigator.pop(context, true);},
            ),
            title: GradientText(
              'Tell Truth',
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
                  Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1), child: ViewMembersPage()));
                  },
              ),

            ],
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
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
                                      _QuestionListCard(backgroundGradient, "who is our father of our nation","images/boy.png","383","230",true),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","images/boy.png","5","30",false),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","images/girl.png","36","830",false),
                                      _QuestionListCard(backgroundGradient2, "who is our father of our nation","images/girl.png","5","200",false),
                                      _QuestionListCard(backgroundGradient1, "who is our father of our nation","images/boy.png","56","340",true),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","images/girl.png","64","210",false),
                                      _QuestionListCard(backgroundGradient2, "who is our father of our nation","images/girl.png","5756","850",false),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","images/girl.png","432","400",true),
                                      _QuestionListCard(backgroundGradient1, "who is our father of our nation","images/boy.png","423","420",false),
                                      _QuestionListCard(backgroundGradient2, "who is our father of our nation","images/boy.png","3423","700",true),
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
            ),
          ),
        )
    );

  }
  Widget _QuestionListCard(LinearGradient Gradiant, String Question,String imgPath,String views,String response, bool isBlur) {
    return ExpandPageTransition(

      navigateToPage: QuestionDetailPage(),
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
                                    gradient: Gradiant,
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
                                                    backgroundImage: AssetImage(
                                                        imgPath),
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
                                              "Ready",
                                              "Set",
                                              "Your Question",
                                              Question,
                                            ],
                                            textStyle: questionStyle,
                                            textAlign: TextAlign.center,
                                            alignment: AlignmentDirectional.topCenter,
                                            isRepeatingAnimation: false,// or Alignment.topLeft
                                          ),
                                          isBlur == true ? BackdropFilter(
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
                                                  Text(views,style: countStyle,),
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
                                                  Text(response,style: countStyle,),
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