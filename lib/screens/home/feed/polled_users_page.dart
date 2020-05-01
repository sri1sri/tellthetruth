import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/empty_polled_users.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class RevealIdentity extends StatelessWidget {
  RevealIdentity({@required this.gangID, @required this.questionID, @required this.pageTitle});
  String gangID;
  String questionID;
  String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_RevealIdentity(gangID: gangID, questionID: questionID, pageTitle: pageTitle,),
    );
  }
}

class F_RevealIdentity extends StatefulWidget {
  F_RevealIdentity({@required this.gangID, @required this.questionID, @required this.pageTitle});
  String gangID;
  String questionID;
  String pageTitle;

  @override
  _F_RevealIdentity createState() => _F_RevealIdentity();
}

class _F_RevealIdentity extends State<F_RevealIdentity> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  @override
  void initState() {
    Ads.showInterstitialAd();
//    Ads.showRewardedVideoAd();
//    Ads.showBannerAd();
    super.initState();
  }

  Widget offlineWidget (BuildContext context){
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
        leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context, true);
        },
      ),
      centerTitle: true,
      title: GradientText(
        widget.pageTitle,
        style: mediumTextStyleLight,
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
      elevation: 0,
      backgroundColor: Colors.white,
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

                    Lottie.network(
                        userData.gender != null ? userData.gender == 'Male' ? maleIcon : femaleIcon : maleIcon,
                        height: getDynamicHeight(50),
                        width: getDynamicWidth(50)),


//                    CircleAvatar(
//                      backgroundImage: AssetImage(userData.gender != null ? userData.gender == 'Male' ? 'images/boy.png' : 'images/girl.png' : 'images/girl.png'),
//                      radius: 25,
//                    ),
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