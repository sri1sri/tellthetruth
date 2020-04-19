import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/global_file/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/faq.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/notification.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/privacy_policy.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/support.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/terms_conditions.dart';

import '../../../landing_page.dart';

class Profile extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_Profile(),
    );
  }
}

class F_Profile extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_ProfileState createState() => _F_ProfileState();
}

class _F_ProfileState extends State<F_Profile> {

  @override
  Widget build(BuildContext context) {
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
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(getDynamicHeight(350)),
                  child: ControlledAnimation(
                    playback: Playback.MIRROR,
                    tween: tween,
                    duration: tween.duration,
                    builder: (context, animation) {
                      return Container(
                        color: Colors.transparent,
                        child:  Column(
                          children: <Widget>[
                            Lottie.network('https://assets6.lottiefiles.com/packages/lf20_bRHk7X.json',height: getDynamicHeight(200),width: getDynamicWidth(200)),
                            SizedBox(
                              height: getDynamicHeight(10),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(USER_NAME,
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w900,
                                          fontSize: getDynamicTextSize(40),
                                          decoration: TextDecoration.none)),
                                  SizedBox(
                                    height: getDynamicHeight(5),
                                  ),
                                  Text(
                                    USER_EMAIL,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: getDynamicTextSize(18),
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(20),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(USER_QUESTION_COUNT,style: heavyStyle,),
                                          SizedBox(
                                            height: getDynamicHeight(10),
                                          ),
                                          Text("Questions Posted",style: answerStyle,),
                                        ],
                                      ),
                                      SizedBox(width: getDynamicWidth(50),),
                                      Column(
                                        children: [
                                          Text(USER_POINTS,style: heavyStyle,),
                                          SizedBox(
                                            height: getDynamicHeight(10),
                                          ),
                                          Text("Poins Earned",style: answerStyle,),
                                        ],
                                      )
                                    ],

                                  )
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
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)),
                  child: Container(
                      color: Colors.white,
                      child: _buildContent(context)
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


    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child:   Column(
          children: <Widget>[
            SizedBox(
              height: getDynamicHeight(20),
            ),
            Column(
              children: <Widget>[
                _settingsCard("Notifications","images/settingsNotification.png",Notifications()),
                _settingsCard("FAQ's","images/settingsFAQ.png",FAQ()),
                _settingsCard("Privacy Policy","images/settingsTermsAndConditions.png",PrivacyPolicy()),
                _settingsCard("Terms & Conditions","images/settingsTermsAndConditions.png",TermsAndServices()),
                _settingsCard("Support","images/settingsSupport.png",Support()),
                _settingsCard("Log Out","images/settingsLogout.png",null),
              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB( 30,20,30,20 ),
                child: Column(
                  children: <Widget>[
                    SizedBox( height: getDynamicHeight(10), ),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'Montserrat',
                        fontSize: getDynamicTextSize(15),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox( height: getDynamicHeight(10), ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      GoToPage(context, LandingPage());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Widget _settingsCard(String title,String imgPath,Widget route) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          route == null ? _confirmSignOut(context) : GoToPage(context, route);
        },
        padding: EdgeInsets.only(left:40.0 ,top: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 0.0 ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage:
              AssetImage(imgPath),
              radius: 20,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: getDynamicWidth(20),),
            Text(title,
              style: TextStyle(
                color: Colors.black87,
                letterSpacing: 1.5,
                fontSize: getDynamicTextSize(20),
                fontWeight: FontWeight.w600,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}