
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

import 'add_question_page.dart';
import 'add_gang_name_page.dart';
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
//  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
                                Navigator.push(context, PageTransition(type: PageTransitionType.rippleLeftDown, duration: Duration(seconds: 0),alignment: Alignment.bottomCenter, child: JoinGang()));
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
                                Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightDown, duration: Duration(seconds: 1),alignment: Alignment.bottomCenter, child: AddQuestion()));

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
//    screens.home: new Scaffold(
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