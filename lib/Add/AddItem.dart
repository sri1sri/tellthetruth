import 'dart:io';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:interactive_add_button_layout/interactive_add_button_layout.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:swipe_up_menu/swipe_up_menu.dart';
import 'package:tellthetruth/Add/QuestionEntry.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/Add/add_gang_name.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/home/groupMembers.dart';

import 'join_gang.dart';

class AddItemPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddItemPage(),
    );
  }
}

class F_AddItemPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_AddItemPageState createState() => _F_AddItemPageState();
}

class _F_AddItemPageState extends State<F_AddItemPage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
    final primaryColor = Theme.of(context).primaryColor;
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
                  children: [

                    Container(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              width: getDynamicWidth(200),
                              height: getDynamicHeight(200),
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
                                "Good evening $USER_NAME, ready to do something exiciting ?",
                              ],
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: getDynamicTextSize(26),decoration: TextDecoration.none),
                              textAlign: TextAlign.center,
                              alignment: AlignmentDirectional.topCenter,
                              isRepeatingAnimation: false,// or Alignment.topLeft
                            ),
                          ),
                          SizedBox(height: getDynamicHeight(40),),

                        ],
                      ),
                    ),

//                    SizedBox(height: getDynamicHeight(100),),
                    ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0)),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.rippleLeftDown, duration: Duration(seconds: 1),alignment: Alignment.bottomCenter, child: JoinGang()));
                                print("Tap Event");
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: getDynamicHeight(140),
                                  ),
                                  Positioned(
                                    top: 18,
                                    child:FadeAnimatedTextKit(
                                        text: ["Gang", "Banda", "Pandilla","गिरोह","Burcad","Geng","Bando","Cohors"],
                                        textStyle: backgroundText,
                                        textAlign: TextAlign.center,
                                        alignment: AlignmentDirectional.center // or Alignment.topLeft
                                    ),
                                    //Text("Question",style: backgroundText,),
                                  ),
                                  Positioned(
                                    child: GradientText(
                                      'Join your gang...',
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
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightDown, duration: Duration(seconds: 1),alignment: Alignment.bottomCenter, child: QuestionEntryPage()));

                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: getDynamicHeight(140),
                                  ),
                                  Positioned(
                                    top: 18,
                                    child:FadeAnimatedTextKit(
                                        text: ["Question", "Frage", "Domanda","प्रश्न","Funso","Pertanyaan","Quaestio","Demando"],
                                        textStyle: backgroundText,
                                        textAlign: TextAlign.center,
                                        alignment: AlignmentDirectional.center // or Alignment.topLeft
                                    ),
                                    //Text("Question",style: backgroundText,),
                                  ),
                                  Positioned(
                                    child: GradientText(
                                      'Wanna ask a question?',
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
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightUp, duration: Duration(seconds: 1),alignment: Alignment.bottomCenter, child: AddGangName()));

                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: getDynamicHeight(140),
                                  ),
                                  Positioned(
                                    top: 18,
                                    child:FadeAnimatedTextKit(
                                        text: ["Gang", "Banda", "Pandilla","गिरोह","Burcad","Geng","Bando","Cohors"],
                                        textStyle: backgroundText,
                                        textAlign: TextAlign.center,
                                        alignment: AlignmentDirectional.center // or Alignment.topLeft
                                    ),
                                  ),
                                  Positioned(
                                    child: GradientText(
                                      'Create a new gang & have fun.',
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
                            ),
                            Container(
                              height: getDynamicHeight(60),
                              color: Colors.redAccent,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}



//
//////////
//////////////
     //Please dont clear this
//////////////
/////////
//


//ScreenshotController screenshotController = ScreenshotController();
//File _imageFile;
//
//
//@override
//Widget build(BuildContext context) {
//  return Screenshot(child: offlineWidget(context), controller: screenshotController,);
//}

//Widget _buildContent(BuildContext context) {
//  return new MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: new Scaffold(
//        backgroundColor:Colors.white,
//        body: Row(
//          children: <Widget>[
//            Container(
//              decoration: new BoxDecoration(
//                  gradient: new LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    colors: [
//                      Color(0XffFD8B1F),
//                      Color(0XffD152E0),
//                      Color(0Xff30D0DB),
//                    ],
//                  )),
//            ),
//            InkWell(onTap: (){
//              screenshotController.capture().then((File image) {
//                //Capture Done
//                setState(() {
//                  print(_imageFile);
//                  _imageFile = image;
//                  print(_imageFile);
//                  final result = ImageGallerySaver.saveImage(_imageFile.readAsBytesSync());
//                  print(result);
//                });
//              }).catchError((onError) {
//                print(onError);
//              });
//            },
//              child: Text('take screenshot'),),
//
//            _imageFile != null ? Image.file(_imageFile) : Container(height: 10,width: 10,color: Colors.red,),
//
//          ],
//        )
//    ),
//  );
//}