
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/button_widget/backForeText.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'add_gang_name_page.dart';
import 'content_preview_page.dart';
import 'join_gang_page.dart';

class AddPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddPage(),
    );
  }
}

class F_AddPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_AddPageState createState() => _F_AddPageState();
}

class _F_AddPageState extends State<F_AddPage> {

  @override
  void initState() {
//    Ads.hideBannerAd();
    super.initState();
  }

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
                  preferredSize: Size.fromHeight(getDynamicHeight(342)),
                  child: ControlledAnimation(
                    playback: Playback.MIRROR,
                    tween: tween,
                    duration: tween.duration,
                    builder: (context, animation) {
                      return Container(
                        color: Colors.transparent,
                        child:  Column(
                          children: <Widget>[
                            Center(
                              child: SizedBox(
                                width: getDynamicWidth(180),
                                height: getDynamicHeight(180),
                                child: Container(
                                    child: FlareActor("images/welcome.flr",
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: 'Animations')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                              child: TyperAnimatedTextKit(
                                onTap: () {
                                  print("Tap Event");
                                },
                                text: [
                                  "${greeting()} $USER_NAME, ready to do something exiciting ?",
                                ],
                                textStyle:foregroundTextStyleLight,
                                textAlign: TextAlign.center,
                                alignment: AlignmentDirectional.topCenter,
                                isRepeatingAnimation: false,// or Alignment.topLeft
                              ),
                            ),
                            SizedBox(height: getDynamicHeight(20),),

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
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: getDynamicHeight(20),),
            BackForeText(
              backText: ["Join Gang", "ముఠాలో చేరండి", "गिरोह में शामिल हों","கும்பலில் சேருங்கள்","സംഘത്തിൽ ചേരുക","ಗ್ಯಾಂಗ್ ಸೇರಲು"],
              foreText: 'Join your gang',
              route: JoinGang(),
            ),
            BackForeText(
              backText: ["Tell The Truth", "నిజమ్ చెప్పు", "सच बताओ","உண்மையை கூறவும்","സത്യം പറയൂ","ನಿಜ ಹೇಳು"],
              foreText: 'Wanna ask a question?',
              route: ContentPreview(),
            ),
            BackForeText(
              backText: ["Create Gang", "గ్యాంగ్ సృష్టించండి", "गैंग बनाएं","கும்பலை உருவாக்குங்கள்","ഗാംഗ് സൃഷ്ടിക്കുക","ಗ್ಯಾಂಗ್ ರಚಿಸಿ"],
              foreText: 'Create a new gang & have fun',
              route: AddGangName(),
            ),
//            Container(
//              height: getDynamicHeight(60),
//              color: Colors.redAccent,
//              width: MediaQuery.of(context).size.width,
//            ),
          ],
        ),
    );
  }
}
