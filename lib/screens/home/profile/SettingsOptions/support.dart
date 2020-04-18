import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getDynamicHeight(80)),
        child: CustomAppBar(
          leftActionBar: Container(
            child: Icon(Icons.arrow_back_ios,color: subBackgroundColor,),
          ),
          leftAction: () {
            Navigator.pop(context, true);
          },
          rightActionBar: Container(
              child: Text(".............",style: TextStyle(color: Colors.white),)
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Notifications',
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
            child: Text(
              "Support",
              style: answerStyleBlur,
            ),
          ),
        ),
      ),

    );

  }

}