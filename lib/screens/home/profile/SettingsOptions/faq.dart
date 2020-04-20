import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_FAQ(),
    );
  }
}

class F_FAQ extends StatefulWidget {
  @override
  _F_FAQ createState() => _F_FAQ();
}

class _F_FAQ extends State<F_FAQ> {
  int _n = 0;
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);

  }

  Widget offlineWidget (BuildContext context){
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          leftActionBar: Container(
            child: Icon(Icons.arrow_back_ios,color: subBackgroundColor,),
          ),
          leftAction: () {
            Navigator.pop(context, true);
          },
          rightActionBar: Container(
              child: Text("......",style: TextStyle(color: Colors.white),)
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: "FAQ's",
          secondaryText: null,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              _Notificationcard("Things to remember",
                  "ALl questions will be available to poll for 24hours. After 24hours questions cant be polled but can be viewed. After 48hours questions will be removed permenantly."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How to Create gang?",
                  "Go to + tab. Click on Create gang, Add your gang name gang icon. That\'s it your gang will be created."
              ),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How to add question?",
                  "Go to + tab. Click on create question. Now add your question, options and select in which group you need to post it. Also add mode (Anonymous or public)."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How to reveal question identity?",
                  "In polling the question at bottom center you will find an anonymous icon. If you click on that your question identity will be revealed."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How to reveal answer identity?",
                  "In polling the question at top right you will find an anonymous icon. If you click on that your answered identity will be revealed."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("Where can I find gang code?",
                  "In home screen behind gang name you will find the gang code."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How can I share my gang code?",
                  "In home page click on gang names. Bottom right you will fing more icon click on that. Later you will be provided with 3 options. View gang, Share, My questions. Here if you click on share it will navigate you to whtsapp so that you can share you gang code with your friends and family."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How can I see who are there in my gang?",
                  "In home page click on gang names. Bottom right you will fing more icon click on that. Later you will be provided with 3 options. View gang, Share, My questions.  Here click on View gang. Here you will find all the users in you gang."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How to join gang?",
                  "Go to + tab. Click on Join gang, Add your gang code. That\'s it you will be joined in that gang."),

              SizedBox(height: getDynamicHeight(5),),
              _Notificationcard("How to add question?",
                  "Go to + tab. Click on create question. Now add your question, options and select in which group you need to post it. Also add mode (Anonymous or public)."),

            ],
          ),
        ),
      ),
    );
  }

  _Notificationcard(String step, String description)
  {
    return Container(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(step,
              style: answerStyleBlur1,

            ),
            SizedBox(height: getDynamicHeight(10),),
            Text(description,
              style: answerStyleBlur,)
          ],
        ),
      ),
    );
  }
}