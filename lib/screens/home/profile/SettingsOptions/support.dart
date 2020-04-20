import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:url_launcher/url_launcher.dart';


void customLaunch(command) async{
  if(await canLaunch(command)){
    await launch(command);

  }else{
    print('could not launch $command');
  }
}

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_Support(),
    );
  }
}

class F_Support extends StatefulWidget {
  @override
  _F_Support createState() => _F_Support();
}

class _F_Support extends State<F_Support> {
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
          primaryText: 'Support',
          secondaryText: null,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard(),
              SizedBox(height: getDynamicHeight(20),),

            ],
          ),
        ),
      ),

    );
  }

  _Notificationcard()
  {
    return Container(

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Center(
            child: Column(
              children: [
                Text(
                  "For any queries please contact us",
                  style: answerStyleBlur,
                ),
                SizedBox(height: getDynamicHeight(20),),
                Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: getDynamicHeight(60.0),
                        width: getDynamicWidth(MediaQuery.of(context).size.width),
                        child: GestureDetector(
                          onTap: () {
                            customLaunch('mailto:209tellthetruth@gmail.com?Subject=Query%20regarding%20application.&body=Write%20your%20query%20here.%20');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: backgroundColor,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.mail,color: backgroundColor,),
                                Center(
                                  child: GradientText(
                                    '209tellthetruth@gmail.com',
                                    style: regularStyle,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );

  }

}