import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
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

import '../../../firebase/admobs.dart';
import '../../../global_file/common_variables/app_functions.dart';
import '../../../main.dart';
import 'display_gang_members_page.dart';
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
  void initState() {

//    show_interstitial_ad = show_interstitial_ad + 1;
//    show_interstitial_ad == 5 ? Ads.showInterstitialAd() : Container(height: 0, width: 0,);
//
//    Ads.showBannerAd();

//    String appId = getAppId();
//    print('hello world admob test$appId');
    // FirebaseAdMob.instance.initialize(appId: getAppId());

//    bannerAd
//      ..load().then((loaded) {
//        if (loaded && this.mounted) {
//          bannerAd
//            ..show(
//              anchorOffset: 80.0,
//            );
//        }
//      });
    super.initState();
  }

  @override
  void dispose() {
    print('disposed is called');
//    bannerAd?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          backgroundColor: Color(0Xff30D0DB),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(getDynamicHeight(260)),
            child: ControlledAnimation(
              playback: Playback.MIRROR,
              tween: tween,
              duration: tween.duration,
              builder: (context, animation) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            animation["color1"],
                            animation["color2"],
                            animation["color3"],
                            // animation["color4"]
                          ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
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
                                      type: PageTransitionType.rippleRightDown,
                                      duration: Duration(seconds: 1),
                                      child: GangMembers()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              child: Text(greeting(),
                                  style: backgroundTextStyleMedium),
                            ),
                            Text(
                              "$USER_NAME",
                              style: foregroundTextStyleLight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          body: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0)),
            child:
            Container(color: Colors.white, child: _buildContent(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<GangDetails>>(
      stream: DBreference.readGangs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<GangDetails> data = snapshot.data;
          List<String> gName = [];
          List<String> gId = [];
          data.forEach((f) {
            gName.add(f.gangName ?? '0');
            gId.add(f.gangID ?? '0');
          });
          USER_GANG_NAMES = gName;
          USER_GANG_ID = gId;
          USER_GANG_NAMES.forEach((f) {
            print(" USER GANG NAME : $f");
          });
          USER_GANG_ID.forEach((f) {
            print(" USER GANG ID : $f");
          });
        }
        print(USER_ID);

        return ListItemsBuilder<GangDetails>(
          snapshot: snapshot,
          itemBuilder: (context, data) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildImage(data),
                    ],
                  ),
                ),
              ),
              // AdmobBanner(adUnitId: 'ca-app-pub-9543395526409232/9656205735',adSize: AdmobBannerSize.BANNER,)
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(GangDetails data) {
//    USER_GANG_NAMES.add(data != null ? data.gangName : 'null');
//    USER_GANG_ID.add(data != null ? data.gangCode:'null');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.rippleLeftUp,
            duration: Duration(seconds: 1),
            child: AllQuestions(gangDetails: data),
          ),
        );
        //GoToPage(context, QuestionsPage());
      },
      child: Container(
        height: getDynamicHeight(140),
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
                          height: getDynamicHeight(100),
                          width: getDynamicWidth(270),
                        ),
                        Positioned(
                          top: 7,
                          child: Text(
                            data != null ? '${data.gangCode}' : 'fetching...',
                            style: backgroundTextStyleMedium,
                          ),
                          //Text("Question",style: backgroundText,),
                        ),
                        Positioned(
                          top: 40,
                          child: GradientText(
                            data != null ? data.gangName : 'fetching...',
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
                        )
                      ],
                    ),
                  ],
                ),
                Lottie.network(data != null ? data.gangIconURL : '',
                    height: getDynamicHeight(100), width: getDynamicWidth(100)),
              ]),
        ),
      ),
    );
  }
}
