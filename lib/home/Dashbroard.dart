import 'dart:math';

//import 'package:admob_flutter/admob_flutter.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:firebase_admob/firebase_admob.dart';
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
import 'package:tellthetruth/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/database.dart';
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
    FirebaseAdMob.instance.initialize(appId: getAppId());
//    createBannerAd()..load()..show(anchorType: AnchorType.bottom, anchorOffset: 40.0,);

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
                      colors: [
                    animation["color1"],
                    animation["color2"],
                    animation["color3"],
                    animation["color4"]
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "........",
                                style: TextStyle(color: Colors.transparent),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'T',
                                    style: logoStyle1,
                                  ),
                                  Text('ell', style: logoStyle2),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'T',
                                    style: logoStyle1,
                                  ),
                                  Text(
                                    'he',
                                    style: logoStyle2,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'T',
                                    style: logoStyle1,
                                  ),
                                  Text(
                                    'ruth',
                                    style: logoStyle2,
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rippleRightDown,
                                          duration: Duration(seconds: 1),
                                          child: ViewMembersPage()));
                                },
                              ),
                            ],
                          ),
                          // SizedBox(height: 30,),
                        ],
                      ),
                      SizedBox(
                        height: getDynamicHeight(10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Good Morning',
                                style: TextStyle(
                                    color: Colors.white38,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                    fontSize: getDynamicTextSize(40),
                                    decoration: TextDecoration.none)),
                            SizedBox(
                              height: getDynamicHeight(5),
                            ),
                            Text(
                              "$USER_NAME",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: getDynamicTextSize(26),
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                    child: StreamBuilder<List<GangDetails>>(
                      stream: DBreference.readGangs(),
                      builder: (context, snapshot) {
print(snapshot.data.length);
                        return ListItemsBuilder<GangDetails>(
                          snapshot: snapshot,
                          itemBuilder: (context, data) => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                height: getDynamicHeight(530.0),
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      _buildImage(
                                          data != null
                                              ? data.gangIconURL
                                              : '',
                                          data != null
                                              ? data.gangName
                                              : 'fetching...',
                                          "6 new questions"),
                                    ],
                                  ),
                                ),
                              ),
                              // AdmobBanner(adUnitId: 'ca-app-pub-9543395526409232/9656205735',adSize: AdmobBannerSize.BANNER,)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String lottiePath, String groupName, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rippleMiddle, child: QuestionsPage()));
        //GoToPage(context, QuestionsPage());
      },
      child: Container(
        height: getDynamicHeight(130),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Container(
                          height: getDynamicHeight(80),
                          width: getDynamicWidth(250),
                        ),
                        Positioned(
                          top: 5,
                          child: Text(
                            groupName,
                            style: backgroundText,
                          ),
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
                Lottie.network(lottiePath,
                    height: getDynamicHeight(100),
                    width: getDynamicWidth(100)),
              ]),
        ),
      ),
    );
  }
}
