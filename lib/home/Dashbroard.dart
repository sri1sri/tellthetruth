import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_variables/sizeConfig.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/home/all_questions.dart';
import 'package:tellthetruth/home/groupMembers.dart';


class Dashboard1Page extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_Dashboard1Page(),
    );
  }
}

class F_Dashboard1Page extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_Dashboard1PageState createState() => _F_Dashboard1PageState();
}

class _F_Dashboard1PageState extends State<F_Dashboard1Page> {

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
                  children: <Widget>[
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: <Widget>[
                            SizedBox(height: 60,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("........",style: TextStyle(color: Colors.transparent),),
                                Row(
                                  children: [
                                    Text( 'T',
                                      style: logoStyle1,),
                                    Text( 'ell',
                                        style: logoStyle2),

                                    SizedBox(width: 5,),
                                    Text( 'T',
                                      style: logoStyle1,),
                                    Text( 'he',
                                      style: logoStyle2,),

                                    SizedBox(width: 5,),
                                    Text( 'T',
                                      style: logoStyle1,),
                                    Text( 'ruth',
                                      style: logoStyle2,),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.notifications,color: Colors.grey,),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightDown, duration: Duration(seconds: 1), child: ViewMembersPage()));
                                  },
                                ),

                              ],
                            ),
                            // SizedBox(height: 30,),


                          ],
                        ),
                        SizedBox(height: getDynamicHeight(10),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Good Morning',style: TextStyle(
                                  color: Colors.white38,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                  fontSize: getDynamicTextSize(40),decoration: TextDecoration.none)
                              ),
                              SizedBox(height: getDynamicHeight(10),),
                              Text("$USER_NAME",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none),),
                            ],
                          ),
                        ),
                        SizedBox(height: getDynamicHeight(20),),
                      ],
                    ),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                                height: getDynamicHeight(530.0) ,
                                width: MediaQuery.of(context).size.width ,
                                child: SingleChildScrollView(
                                  child:Column(
                                    children: [
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json',".Net 791","6 new questions"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_VCStus.json',"Family","the good one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_uwmgvS.json',"LTI Pune","the great one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_CFgBAP.json',"Caseu","the worst one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_OyFTHm.json',"rajaa","the greatest one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_BonJMC.json',"eldooo","the great one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_RWZde1.json',"sainath","the naughty one"),
                                      _buildImage('https://assets7.lottiefiles.com/packages/lf20_KMustJ.json',"nanditha","the perfect one"),

                                    ],
                                  ) ,
                                )
                            ),
                          ),
                        ],
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
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(PageTransition(type: PageTransitionType.rippleMiddle, child: QuestionsPage()));
        //GoToPage(context, QuestionsPage());
      },
      child: ExpandPageTransition(
        navigateToPage: QuestionsPage(),
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {

          return


            Container(
               height: getDynamicHeight(120),
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