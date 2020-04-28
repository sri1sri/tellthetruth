import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_PrivacyPolicy(),
    );
  }
}

class F_PrivacyPolicy extends StatefulWidget {
  @override
  _F_PrivacyPolicy createState() => _F_PrivacyPolicy();
}

class _F_PrivacyPolicy extends State<F_PrivacyPolicy> {
  int _n = 0;

  @override
  void initState() {
    Ads.hideBannerAd();
    super.initState();
  }

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
          primaryText: 'Privacy Policy',
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
              _Notificationcard("DISCLAIMER","Tell The Truth is committed to honoring the privacy of its customers and visitors. Question & Answer which you are provided will not sell or share your personal information with third party organizations other than in the ways listed in this Privacy Policy. Question the Answer only collects some basic information to better their experience by communicating eachother, events and updating the knowledge. This Privacy Policy applies to the entire Question the Answer application: www.tellthetruth.com app."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("THIRD PARTY SERVICES","Tell The truth will not use any third party payment processor to accept payments when you use the application. Such third party processor's use of your personal information is not suppored and managed by their privacy policy. For these service providers, Question the Answer recommends that you read their privacy policy to better understand how they use your personal information. "),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("DISCLAIMER","Tell The Truth is committed to honoring the privacy of its customers and visitors. Question & Answer which you are provided will not sell or share your personal information with third party organizations other than in the ways listed in this Privacy Policy. Question the Answer only collects some basic information to better their experience by communicating eachother, events and updating the knowledge. This Privacy Policy applies to the entire Question the Answer application: www.tellthetruth.com app."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("SECURITY", "Tell The Truth – as a application hosted by Herms & Touth – stores all user information in a secure database protected by a variety of industry standard access controls. Secure passwords, SSL encryption, diskbased encryption, firewalls, and other measures are in place to help (Firebase) protect your data. However, no company, can fully eliminate security risks associated with the transmission of personal information through online transactions, and you do so at your own risk."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("COOKIES","While navigating the Tell The Truth application your web browser may use 'cookies' to analyze trends and track your movement to gather information about the site as a whole. Tell The Truth allows Firebase to use cookies for authentication, tracking user sessions, preferences, and movements around the site to understand the site's marketing and performance analytics. Users can control the use of cookies at the individual browser level. If you decide to reject cookies, it may limit your ability to use some features of the site."),
              SizedBox(height: getDynamicHeight(10),),
            ],
          ),
        ),
      ),

    );
  }

  _Notificationcard(String title,String description)
  {
    return Container(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
              style: mediumTextStyleDark,

            ),
            SizedBox(height: getDynamicHeight(10),),
            Text(description,
              style: smallTextStyleMedium,)
          ],
        ),
      ),
    );

  }

}