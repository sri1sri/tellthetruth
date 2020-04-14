import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_variables/sizeConfig.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/home/all_questions.dart';
import 'package:tellthetruth/home/groupMembers.dart';

class DashboardPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DashboardPage(),
    );
  }
}

class F_DashboardPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_DashboardPageState createState() => _F_DashboardPageState();
}

class _F_DashboardPageState extends State<F_DashboardPage> {

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
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffD38312), end: Color(0XffD152E0))),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0XffD152E0), end: Color(0Xff30D0DB))),
      Track("color3").add(Duration(seconds: 3),
          ColorTween(begin: Color(0Xff30D0DB), end: Color(0Xff12c2e9))),
      Track("color4").add(Duration(seconds: 3),
          ColorTween(begin: Color(0Xff12c2e9), end: Color(0xffD38312))),
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          child: new Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [animation["color1"], animation["color2"],animation["color3"], animation["color4"]])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("........",style: TextStyle(color: Colors.transparent),),
                            Row(
                              children: [
                                Text("T",style: titleStyle,),
                                Text("ell",style: titleStyle,),
                                SizedBox(width: 5,),
                                Text("T",style: titleStyle,),
                                Text("he",style: titleStyle,),
                                SizedBox(width: 5,),
                                Text("T",style: titleStyle,),
                                Text("ruth",style: titleStyle,),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.notifications,color: Colors.white,),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(context, PageTransition(type: PageTransitionType.slideZoomUp, duration: Duration(seconds: 1), child: ViewMembersPage()));
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("images/boy.png"),
                            radius: 35,
                          ),
                          SizedBox(height: 20,),
                          Text("Hello, Vasanthakumar",style: boldStyleLight,),
                          SizedBox(height: 10,),
                          Text("Hey today you got 3 more questions to\n answer in your groups.",style: answerStyleBlur,)
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text(
                                  "My gangs",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      fontSize: getDynamicTextSize(19),decoration: TextDecoration.none),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                                child: GestureDetector(
                                  child: Text(
                                    "Show all",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: getDynamicTextSize(16),decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                            child: Container(
                                height: getDynamicHeight(350.0) ,
                                width: MediaQuery.of(context).size.width ,
                                padding: EdgeInsets.only(top: 10.0),
                                child: GridView.count(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1.45,
                                    scrollDirection: Axis.horizontal,
                                    children: [
//                                          Container(width: 10, color: Colors.transparent,),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json',"Winner winner winn","6 new questions"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_VCStus.json',"srivatsav","the good one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_uwmgvS.json',"vamsi","the great one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_CFgBAP.json',"jake","the worst one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_OyFTHm.json',"rajaa","the greatest one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_BonJMC.json',"eldooo","the great one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_RWZde1.json',"sainath","the naughty one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_KMustJ.json',"nanditha","the perfect one"),

                                    ])),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        );
      },
    );


//      new MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Container(
//          child: new Scaffold(
//              backgroundColor:Colors.white,
//              body: Container(
//                decoration: new BoxDecoration(
//                    gradient: new LinearGradient(
//                      begin: Alignment.topCenter,
//                      end: Alignment.bottomCenter,
//                      colors: [
//                        Color(0XffFD8B1F),
//                        Color(0XffD152E0),
//                        Color(0Xff30D0DB),
//                        Color(0Xff12c2e9),
//                      ],
//                    )),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                        Column(
//                          children: <Widget>[
//                            SizedBox(height: 60,),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: [
//                                Text("........",style: TextStyle(color: Colors.transparent),),
//                                Row(
//                                  children: [
//                                    Text("T",style: titleStyle,),
//                                    Text("ell",style: titleStyle,),
//                                    SizedBox(width: 5,),
//                                    Text("T",style: titleStyle,),
//                                    Text("he",style: titleStyle,),
//                                    SizedBox(width: 5,),
//                                    Text("T",style: titleStyle,),
//                                    Text("ruth",style: titleStyle,),
//                                  ],
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.notifications,color: Colors.white,),
//                                  color: Colors.white,
//                                  onPressed: () {
//                                    Navigator.push(context, PageTransition(type: PageTransitionType.slideZoomUp, duration: Duration(seconds: 1), child: ViewMembersPage()));
//                                  },
//                                ),
//
//                              ],
//                            ),
//                          ],
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left:20.0,right: 20),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                              CircleAvatar(
//                                backgroundImage: AssetImage("images/boy.png"),
//                                radius: 35,
//                              ),
//                              SizedBox(height: 20,),
//                              Text("Hello, Vasanthakumar",style: boldStyleLight,),
//                              SizedBox(height: 10,),
//                              Text("Hey today you got 3 more questions to\n answer in your groups.",style: answerStyleBlur,)
//                            ],
//                          ),
//                        ),
//                        Container(
//                          color: Colors.transparent,
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
//                                    child: Text(
//                                      "My gangs",
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontFamily: 'Montserrat',
//                                          fontWeight: FontWeight.w800,
//                                          fontSize: getDynamicTextSize(19),decoration: TextDecoration.none),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
//                                    child: GestureDetector(
//                                      child: Text(
//                                        "Show all",
//                                        style: TextStyle(
//                                            color: Colors.white,
//                                            fontFamily: 'Montserrat',
//                                            fontWeight: FontWeight.w600,
//                                            fontSize: getDynamicTextSize(16),decoration: TextDecoration.none),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
//                                child: Container(
//                                    height: getDynamicHeight(350.0) ,
//                                    width: MediaQuery.of(context).size.width ,
//                                    padding: EdgeInsets.only(top: 10.0),
//                                    child: GridView.count(
//                                        crossAxisCount: 1,
//                                        crossAxisSpacing: 1,
//                                        mainAxisSpacing: 20,
//                                        childAspectRatio: 1.45,
//                                        scrollDirection: Axis.horizontal,
//                                        children: [
////                                          Container(width: 10, color: Colors.transparent,),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json',"Winner winner winn","6 new questions"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_VCStus.json',"srivatsav","the good one"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_uwmgvS.json',"vamsi","the great one"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_CFgBAP.json',"jake","the worst one"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_OyFTHm.json',"rajaa","the greatest one"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_BonJMC.json',"eldooo","the great one"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_RWZde1.json',"sainath","the naughty one"),
//                                          _buildImage('https://assets7.lottiefiles.com/packages/lf20_KMustJ.json',"nanditha","the perfect one"),
//
//                                        ])),
//                              ),
//                            ],
//                          ),
//                        ),
//                  ],
//                ),
//              )
//          ),
//        )
//    );

  }

  Widget _buildImage(String lottiePath, String groupName, String description) {
    return ExpandPageTransition(
      navigateToPage: QuestionsPage(),
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {

      return GestureDetector(
          onTap: (){
            Navigator.of(context).push(PageTransition(type: PageTransitionType.slideUp, child: QuestionsPage()));
            //GoToPage(context, QuestionsPage());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Lottie.network(lottiePath,height: getDynamicHeight(150),width: getDynamicWidth(150)),

                SizedBox(height: 20,),

                Text(
                  description,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: getDynamicTextSize(17),decoration: TextDecoration.none),
                ),
                Text(
                  groupName,
                  style: TextStyle(
                      color: Color(0xFF1F4B6E),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),
                ),

//            Stack(children: [
//              Container(
//                height: getDynamicHeight(230.0) ,
//                width: getDynamicWidth(170) ,
//              ),
//              Positioned(
//                  left: 5.0,
//                  right: 5.0,
//                  top: 5.0,
//                  bottom: 10.0,
//                  child: Container(
//                      padding: EdgeInsets.only(
//                          left: 0.0, right: 0.0, top: getDynamicHeight(160), bottom: 0.0),
//                      height: getDynamicHeight(175.0) ,
//                      width: getDynamicWidth(180.0),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(5.0),
//                          color: Colors.white),
//                      child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            SizedBox(height: getDynamicHeight(20) ,),
//                            Text(
//                              groupName,
//                              style: TextStyle(
//                                  fontFamily: 'nunito',
//                                  fontSize: getDynamicTextSize(14),
//                                  fontWeight: FontWeight.w900,
//                                  color: Color(0xFF1F4B6E)),
//                            ),
//                            SizedBox(height: getDynamicHeight(5.0) ),
//                            Text(
//                              description,
//                              style: TextStyle(
//                                  fontFamily: 'nunito',
//                                  fontSize: getDynamicTextSize(12),
//                                  fontWeight: FontWeight.w700,
//                                  color: Color(0Xff12c2e9).withOpacity(0.75)),
//                            ),
//
//                          ]))),
//
//              Positioned(
//                  left: 0,
//                  right: 0,
//                  top: 0,
//                  bottom: 0,
//                  child: Lottie.network(lottiePath,height: getDynamicHeight(30),width: getDynamicWidth(85)))
//            ]
//
//            ),
          ]));},
    );
  }

}