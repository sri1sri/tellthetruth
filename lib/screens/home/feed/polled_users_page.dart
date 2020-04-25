import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/empty_content.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/empty_polled_users.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class RevealIdentity extends StatelessWidget {
  RevealIdentity({@required this.gangID, @required this.questionID});
  String gangID;
  String questionID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_RevealIdentity(gangID: gangID, questionID: questionID),
    );
  }
}

class F_RevealIdentity extends StatefulWidget {
  F_RevealIdentity({@required this.gangID, @required this.questionID});
  String gangID;
  String questionID;

  @override
  _F_RevealIdentity createState() => _F_RevealIdentity();
}

class _F_RevealIdentity extends State<F_RevealIdentity> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);

  }

  Widget offlineWidget (BuildContext context){
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
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
              primaryText: "Polled Users",
              secondaryText: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<InsightsDetails>>(
      stream: DBreference.readQuestionsInsights(widget.gangID, widget.questionID),
      builder: (context, snapshot) {

        return ListItemsBuilder<InsightsDetails>(
            emptyContent : EmptyPolledContent(),
          snapshot: snapshot,
          itemBuilder: (context, insightData) => insightData.userID != null ? StreamBuilder<UserDetails>(
          stream: DBreference.getUserDetails(insightData.userID),
          builder: (context, snapshot) {
            final userDetails = snapshot.data;


            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _Notificationcard(insightData, userDetails),
                        SizedBox(height: getDynamicHeight(10),),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }) : Container(height: 0, width: 0,)
        );
      },
    );
  }


  _Notificationcard(InsightsDetails insightData, UserDetails userData) {
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
                      backgroundImage: AssetImage(userData.gender == 'Male' ? 'images/boy.png' : 'images/girl.png'),
                      radius: 25,
                    ),
                  ],
                ),
                SizedBox(width: getDynamicWidth(15) ,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userData.username,style: mediumTextStyleDark,),
                    ]
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Option ${insightData.optionSelected != null ? insightData.optionSelected.toString() : 'not selected'}',style: smallTextStyleDark,),
                ]
            ),
          ],
        ),
      ),
    );
  }
}