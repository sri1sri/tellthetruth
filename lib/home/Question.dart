import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
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
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.width/7),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back_ios,color: subBackgroundColor,),
              ),
              leftAction: () {
                Navigator.pop(context, true);
              },
              rightActionBar: Container(
                child: Icon(Icons.list,color: subBackgroundColor,),
              ),
              rightAction: () {

              },
              primaryText: "",
              secondaryText: null,
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0XffFD8B1F),
                    Color(0XffD152E0),
                    Color(0Xff30D0DB),
                    Color(0Xff12c2e9),
                  ],
                )),
            child:   SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SlimyCard(
                      color: Colors.transparent,
                      borderRadius: 30,
                      slimeEnabled: true,
                      topCardWidget: topCardWidget("images/male.png"),
                      width: MediaQuery.of(context).size.width,
                      bottomCardWidget: bottomCardWidget(),
                      bottomCardHeight: 500,
                      topCardHeight: 350,
                    ),
                  ),


                ],
              ),
            ),
          )
      ),
    );

  }
  Widget topCardWidget(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: AssetImage(imagePath)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          GradientText(
            "Who invented the macBook Air and in which year?",
            textAlign: TextAlign.center,
            style: boldStyle,
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
          SizedBox(height: 10),
        ],
      ),
    );
  }

// This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Container(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GradientText(
                    "Vasanthakumar - 1996",
                    style: mediumStyle,
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
                ],
              )
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientText(
                      "SrivatsavKonda - 1974",
                      style: mediumStyle,
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
                  ],
                )
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientText(
                      "VamsiPesalaa - 1974",
                      style: mediumStyle,
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
                  ],
                )
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientText(
                      "RockstarUmesh - 1932",
                      style: mediumStyle,
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
                  ],
                )
            ),
          ),
        ],
      ),

    );
  }

}

