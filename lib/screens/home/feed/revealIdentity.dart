import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class RevealIdentity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_RevealIdentity(),
    );
  }
}

class F_RevealIdentity extends StatefulWidget {
  @override
  _F_RevealIdentity createState() => _F_RevealIdentity();
}

class _F_RevealIdentity extends State<F_RevealIdentity> {
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
          primaryText: "Reveal Identity",
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

            _Notificationcard("Vasanthakumar","Option A","images/boy.png"),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("Sivatsav","Option C","images/boy.png"),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("Vamsi Pesala","Option A","images/girl.png"),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("Rockstar","Option C","images/boy.png"),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("Nandithaa","Option D","images/girl.png"),
              SizedBox(height: getDynamicHeight(10),),

            ],
          ),
        ),
      ),
    );
  }

  _Notificationcard(String name, String option,String imgPath)
  {
    return Container(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(imgPath),
                      radius: 25,
                    ),
                  ],
                ),
                SizedBox(width: getDynamicWidth(15) ,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name,style: answerStyleBlur1,),
                    ]
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(option,style: answerStyleBlur,),
                ]
            ),
          ],
        ),
      ),
    );
  }
}