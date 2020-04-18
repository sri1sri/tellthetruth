import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/global_file/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/how_to_use.dart';
import 'package:tellthetruth/screens/home/profile/SettingsOptions/privacy_policy.dart';
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
                                  Text("$USER_NAME",
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
                                    "v.g.vasanthakumar@gmail.com",
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
                                          Text("29",style: heavyStyle,),
                                          SizedBox(
                                            height: getDynamicHeight(10),
                                          ),
                                          Text("Questions Posted",style: answerStyle,),
                                        ],
                                      ),
                                      SizedBox(width: getDynamicWidth(50),),
                                      Column(
                                        children: [
                                          Text("10",style: heavyStyle,),
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
                _settingsCard(context,"Notifications","images/not.png",HowToUse()),
                _settingsCard(context,"FAQ's","images/faq.png",HowToUse()),
                _settingsCard(context,"Privacy Policy","images/policy.png",PrivacyPolicy()),
                _settingsCard(context,"Terms & Conditions","images/t&c.png",TermsAndServices()),
                _settingsCard(context,"Support","images/sup.png",HowToUse()),
                _settingsCard(context,"Log Out","images/logout.png",HowToUse()),
              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB( 30,20,30,20 ),
                child: Column(

                  children: <Widget>[

                    RaisedButton(
                      onPressed: () => _confirmSignOut(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular( 80.0 ) ),
                      padding: const EdgeInsets.all( 0.0 ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: Color(0xFF253949),
                          borderRadius: BorderRadius.all( Radius.circular(
                              10 ) ),
                        ),
                        child: Container(
                          constraints: const BoxConstraints( minWidth: 88.0,
                              minHeight: 50.0 ),
                          // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
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

}

Widget _settingsCard(BuildContext context,String title,String imgPath,Widget route) {
  return Container(
    width: double.infinity,
    child: FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => route ),
        );
      },
      padding: EdgeInsets.only(left:40.0 ,top: 30),
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
            radius: 25,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: getDynamicWidth(20),),
          Text(title,
            style: TextStyle(
              color: Colors.black87,
              letterSpacing: 1.5,
              fontSize: getDynamicTextSize(22),
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