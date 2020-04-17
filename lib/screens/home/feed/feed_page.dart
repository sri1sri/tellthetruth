
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

import 'disaply_gang_members_page.dart';
import 'display_all_questions_page.dart';

class FeedPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_FeedPage(),
    );
  }
}

class F_FeedPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_FeedPageState createState() => _F_FeedPageState();
}

class _F_FeedPageState extends State<F_FeedPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: getAppId());
    createBannerAd()..load()..show(anchorType: AnchorType.bottom, anchorOffset: 40.0,);

    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ControlledAnimation(
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
                  child:
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(getDynamicHeight(270)),
                      child: ControlledAnimation(
                        playback: Playback.MIRROR,
                        tween: tween,
                        duration: tween.duration,
                        builder: (context, animation) {
                          return Container(
                            color: Colors.transparent,
                            child: new Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Container(
                                color: Colors.transparent,
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: getDynamicHeight(50),
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
                                                  width: getDynamicWidth(5),
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
                                                  width: getDynamicWidth(5),
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
                                                        child: GangMembers()));
                                              },
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 30,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getDynamicHeight(30),
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
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    body: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0)),
                        child: _buildContent(context)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {

    return Container(
      color: Colors.white,
      child: StreamBuilder<List<GangDetails>>(
        stream: DBreference.readGangs(),
        builder: (context, snapshot) {

          return ListItemsBuilder<GangDetails>(
            snapshot: snapshot,
            itemBuilder: (context, data) =>  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
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
    );
  }


  Widget _buildImage(String lottiePath, String groupName, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rippleLeftUp,duration: Duration(seconds: 1), child: AllQuestions()));
        //GoToPage(context, QuestionsPage());
      },
      child: Container(
        height: getDynamicHeight(110),
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
