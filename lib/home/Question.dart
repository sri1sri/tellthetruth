import 'dart:async';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/firebase/auth.dart';

import '../landing_page.dart';

class QuestionDetailPage extends StatelessWidget {

  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_QuestionDetailPage(),
    );
  }
}

class F_QuestionDetailPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_QuestionDetailPageState createState() => _F_QuestionDetailPageState();
}

class _F_QuestionDetailPageState extends State<F_QuestionDetailPage> {
  static const duration = const Duration( seconds: 1 );

  int secondsPassed = 10;
  bool isActive = true;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState( () {
        if(secondsPassed>0){
          secondsPassed = secondsPassed - 1;
        }

      } );
    }
  }


  @override
  Widget build(BuildContext context) {
    return offlineWidget( context );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0, 0, 0, 0 ),
        child: Scaffold(
          body: _buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic( duration, (Timer t) {
        handleTick( );
      } );
    }
//    int seconds = secondsPassed % 60;
//    int minutes = secondsPassed ~/ 60;
//    int hours = secondsPassed ~/ (60 * 60);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          body: Container(
              width: MediaQuery
                  .of( context )
                  .size
                  .width,
              height: MediaQuery
                  .of( context )
                  .size
                  .height,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color( 0XffFD8B1F ),
                      Color( 0XffD152E0 ),
                      Color( 0Xff30D0DB ),
                      Color( 0Xff12c2e9 ),
                    ],
                  ) ),
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.spaceAr,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox( height: 40 ),
                          Padding(
                            padding: const EdgeInsets.all( 15.0 ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector( child: Icon(
                                  Icons.arrow_back_ios, color: Colors.white, ),
                                  onTap: () {
                                    Navigator.pop( context, true );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    LabelText(
                                        label: 'HRS',
                                        value: convertSeconds(secondsPassed)[0].toString( ).padLeft( 2, '0' ) ),
                                    LabelText(
                                        label: 'MIN',
                                        value: convertSeconds(secondsPassed)[1].toString( ).padLeft(
                                            2, '0' ) ),
                                    LabelText(
                                        label: 'SEC',
                                        value: convertSeconds(secondsPassed)[2].toString( ).padLeft(
                                            2, '0' ) ),
                                  ],
                                ),
                                Container(
                                  child: Text(".....",style: TextStyle(color: Colors.transparent),),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all( 10.0 ),
                      child: SlimyCard(
                        color: Colors.transparent,
                        borderRadius: 30,
                        slimeEnabled: true,
                        topCardWidget: topCardWidget( "images/male.png" ),
                        width: MediaQuery
                            .of( context )
                            .size
                            .width,
                        bottomCardWidget: bottomCardWidget( ),
                        bottomCardHeight: 270,
                        topCardHeight: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all( 15.0 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                    'images/seen.png' ),
                                radius: 14,
                              ),
                              SizedBox( width: 5, ),
                              Text( "200", style: countStyle, ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                    'images/poll.png' ),
                                radius: 12,
                              ),
                              SizedBox( width: 5, ),
                              Text( "150", style: countStyle, ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              showFancyCustomDialog( context );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.share, color: Colors.white, ),
                                ),
                                SizedBox( width: 5, ),
                                Text( "Share", style: countStyle, ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),

            ),

      ),
    );
  }

  Widget topCardWidget(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 5 ),
      ),
      child: Padding(
        padding: const EdgeInsets.all( 10.0 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular( 5 ),
                image: DecorationImage( image: AssetImage( imagePath ) ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity( 0.2 ),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            SizedBox( height: 15 ),
            GradientText(
              "Who invented the mac Book Air and in which year Book Air and in which year?",
              textAlign: TextAlign.center,
              style: mediumStyle,
              gradient: LinearGradient(
                colors: [
                  Color( 0XffFD8B1F ),
                  Color( 0XffD152E0 ),
                  Color( 0Xff30D0DB ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            SizedBox( height: 10 ),
          ],
        ),
      ),
    );
  }

// This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular( 5 ),
            ),
            child: Padding(
              padding: const EdgeInsets.only( left: 15.0, right: 15.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    "Vasanthakumar - 1996",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  GradientText(
                    "40 votes",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: 10, ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular( 5 ),
            ),
            child: Padding(
              padding: const EdgeInsets.only( left: 15.0, right: 15.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    "SrivatsavKonda - 1960",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  GradientText(
                    "35 votes",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: 10, ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular( 5 ),
            ),
            child: Padding(
              padding: const EdgeInsets.only( left: 15.0, right: 15.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    "Vamsipesala - 1967",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  GradientText(
                    "88 votes",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: 10, ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular( 5 ),
            ),
            child: Padding(
              padding: const EdgeInsets.only( left: 15.0, right: 15.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    "Rockstarumesh - 1667",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  GradientText(
                    "5 votes",
                    style: answerStyle,
                    gradient: LinearGradient(
                      colors: [
                        Color( 0XffFD8B1F ),
                        Color( 0XffD152E0 ),
                        Color( 0Xff30D0DB ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }


  Future<T> showGeneralDialog<T>({
    @required BuildContext context,
    @required RoutePageBuilder pageBuilder,
    bool barrierDismissible,
    String barrierLabel,
    Color barrierColor,
    Duration transitionDuration,
    RouteTransitionsBuilder transitionBuilder,
  }){}


}

  class LabelText extends StatelessWidget {
    LabelText({this.label, this.value});

    final String label;
    final String value;

    @override
    Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric( horizontal: 5 ),
        padding: EdgeInsets.all( 10 ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( 15 ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GradientText(
              '$value',
              textAlign: TextAlign.center,
              style: boldStyle,
              gradient: LinearGradient(
                colors: [
                  Color( 0XffFD8B1F ),
                  Color( 0XffD152E0 ),
                  Color( 0Xff30D0DB ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            GradientText(
              '$label',
              style: answerStyle,
              gradient: LinearGradient(
                colors: [
                  Color( 0XffFD8B1F ),
                  Color( 0XffD152E0 ),
                  Color( 0Xff30D0DB ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ],
        ),
      );
    }

  }





void showFancyCustomDialog(BuildContext context) {

  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: 300.0,
                width: 300.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 100,),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('images/whatsapp.png',height: 70,width: 70,),
                                  Image.asset('images/fb.png',height: 60,width: 60,),
                                  Image.asset('images/insta.png',height: 60,width: 60,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Share",
                          style: questionStyle
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Okay let's go!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(1.05, -1.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}