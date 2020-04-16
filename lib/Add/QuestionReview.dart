import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/home/all_questions.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';

class QuestionReviewPage extends StatelessWidget {

  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_QuestionReviewPage(),
    );
  }
}

class F_QuestionReviewPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_QuestionReviewPageState createState() => _F_QuestionReviewPageState();
}

class _F_QuestionReviewPageState extends State<F_QuestionReviewPage> {
  static const duration = const Duration( seconds: 1 );

  int secondsPassed = 5000;
  bool isActive = true;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState( () {
        secondsPassed = secondsPassed - 1;
      } );
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
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);
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
                      padding: const EdgeInsets.only(left:15.0,right: 15,top:30 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector( child: Icon(
                            Icons.close, color: Colors.white,size: 30, ),
                            onTap: () {
                              Navigator.pop( context, true );
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: getDynamicWidth(50.0),
                              height: getDynamicHeight(50),
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(

                            gradient: LinearGradient(
                                colors: <Color>[
                                Color(0XffFD8B1F),
                            Color(0XffD152E0),
                            Color(0Xff30D0DB),
                            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                border: Border.all(
                                  color: Colors.white, //                   <--- border color
                                  width: getDynamicWidth(1),
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onTap: () {
                              //Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightDown, duration: Duration(seconds: 1),alignment: Alignment.bottomCenter, child: QuestionReviewPage()));
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0 ),
                child: SlimyCard(
                  color: Colors.transparent,
                  borderRadius: 30,
                  slimeEnabled: true,
                  topCardWidget: topCardWidget(),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  bottomCardWidget: bottomCardWidget(),
                  bottomCardHeight: getDynamicHeight(250),
                  topCardHeight: getDynamicHeight(200),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Gang",style: questionStyle1,),
                    SizedBox(height: getDynamicHeight(5),),
                    Container(
                          color: Colors.transparent,
                          height: getDynamicHeight(120.0) ,
                          width: MediaQuery.of(context).size.width ,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:Row(
                              children: [
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json',".Net 791","6 new questions"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_VCStus.json',"Family","the good one"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_uwmgvS.json',"LTI Pune","the great one"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_CFgBAP.json',"Caseu","the worst one"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_OyFTHm.json',"rajaa","the greatest one"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_BonJMC.json',"eldooo","the great one"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_RWZde1.json',"sainath","the naughty one"),
                                SizedBox(width: getDynamicWidth(8),),
                                _buildImage('https://assets7.lottiefiles.com/packages/lf20_KMustJ.json',"nanditha","the perfect one"),
                                SizedBox(width: getDynamicWidth(8),),
                              ],
                            ) ,
                          )
                      ),
                  ],
                ),
              )


            ],
          ),

        ),

      ),
    );
  }

  Widget topCardWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 5 ),
      ),
      child: Padding(
        padding: const EdgeInsets.all( 10.0 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GradientText(
              "Who invented the mac Book Air and in which year Book Air and in which year?",
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
    );
  }

// This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Container(
      child: Column(
        children: [
          Container(
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
                    "Vasanthakumar - 1996",
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
                    "40 votes",
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
          ),
          SizedBox( height: getDynamicHeight(10), ),
          Container(
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
                    "SrivatsavKonda - 1960",
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
                    "35 votes",
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
          ),
          SizedBox( height: getDynamicHeight(10), ),
          Container(
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
                    "Vamsipesala - 1967",
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
                    "88 votes",
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
          ),
          SizedBox( height: getDynamicHeight(10), ),
          Container(
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
                    "Rockstarumesh - 1667",
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
                    "5 votes",
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
          ),
        ],
      ),

    );
  }

  Widget _buildImage(String lottiePath, String groupName, String description) {
    return GestureDetector(
      onTap: (){
        //GoToPage(context, QuestionsPage());
      },
      child: ExpandPageTransition(
        navigateToPage: QuestionsPage(),
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {

          return


            Container(
              height: getDynamicHeight(130),
              child: Padding(
                padding: const EdgeInsets.only(top:20,left: 20,right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height: getDynamicHeight(80),
                                width: getDynamicWidth(250),
                              ),
                              Positioned(
                                top: 5,
                                child:Text(groupName,style: backgroundText,),
                                //Text("Question",style: backgroundText,),
                              ),
                              Positioned(
                                top: 40,
                                child: GradientText(
                                  description,
                                  style: questionStyle1,
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
                              )
                            ],
                          ),
                        ],

                      ),
                      Lottie.network(lottiePath,height: getDynamicHeight(100),width: getDynamicWidth(100)),
                    ]),
              ),
            );
        },
      ),
    );
  }


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

