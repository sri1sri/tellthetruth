import 'dart:async';

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
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
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
      int seconds = secondsPassed % 60;
      int minutes = secondsPassed ~/ 60;
      int hours = secondsPassed ~/ (60 * 60);
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: AppBar(
              leading: GestureDetector( child: Icon( Icons.arrow_back_ios, ),
                onTap: () {
                  Navigator.pop( context, true );
                },
              ),
              backgroundColor: Color( 0XffFD8B1F ),
              elevation: 0,
            ),
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
                children: <Widget>[
              Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LabelText(
                          label: 'HRS', value: hours.toString().padLeft(2, '0')),
                      LabelText(
                          label: 'MIN',
                          value: minutes.toString().padLeft(2, '0')),
                      LabelText(
                          label: 'SEC',
                          value: seconds.toString().padLeft(2, '0')),
                    ],
                  ),
                  SizedBox(height: 60),
                  Container(
                    width: 200,
                    height: 47,
                    margin: EdgeInsets.only(top: 30),
                    child: RaisedButton(
                      color: Colors.pink[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(isActive ? 'STOP' : 'START'),
                      onPressed: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                    ),
                  )
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
                      bottomCardHeight: 300,
                      topCardHeight: 350,
                    ),
                  ),


                ],
              ),
            )
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
                height: 70,
                width: 70,
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
  }

  class LabelText extends StatelessWidget {
    LabelText({this.label, this.value});

    final String label;
    final String value;

    @override
    Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric( horizontal: 5 ),
        padding: EdgeInsets.all( 20 ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( 25 ),
          color: Colors.teal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.bold ),
            ),
            Text(
              '$label',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      );
    }

  }