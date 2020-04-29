
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class TermsAndServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_TermsAndServices(),
    );
  }
}

class F_TermsAndServices extends StatefulWidget {
  @override
  _F_TermsAndServices createState() => _F_TermsAndServices();
}

class _F_TermsAndServices extends State<F_TermsAndServices> {
  int _n = 0;

  @override
  void initState() {
//    Ads.hideBannerAd();
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
            child: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          leftAction: () {
            Navigator.pop(context, true);
          },
          rightActionBar: Container(
              child: Text("",style: TextStyle(color: Colors.white ),)
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Terms & Conditions',
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
              _Notificationcard("WELCOME","Welcome to Tell The Truth.\nTell The Truth provide app features to you subject to the following conditions. If you visit Tell The Truth, you accept these conditions. Please read them carefully. If you do not accept these conditions, do not use Tell The Truth."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("PRIVACY","Tell The Truth collects basic personal data (including but not limited to name, email, and IP address) from users to aid with certain app functions. Tell The Truth respects your privacy and we strive to keep your information completely confidential. If you do not want your basic information stored on Tell The Truth, do not use the app. Please review our Privacy Policy, which also governs your visit to Tell The Truth, to understand our practices."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("ELECTRONIC COMMUNICATIONS","When you visit Tell The Truth or send e-mails to us, you are communicating with us electronically. You consent to receive communications from us electronically. We will communicate with you by e-mail or by posting notices on this site. You agree that all agreements, notices, disclosures and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("COPYRIGHT", "All content included on this Application, such as text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, is the property of Tell The Truth  or its content suppliers and protected by FireBase. All software used on this application is the property of Tell The Truth or its software suppliers and protected by firebase."),
              SizedBox(height: getDynamicHeight(10),),
              _Notificationcard("YOUR ACCOUNT","If you use this Application, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your device, and you agree to accept responsibility for all activities that occur under your account or password. If you are under 10, you may use Tell The Truth only with involvement of a parent or guardian. Tell The Truth reserves the right to refuse service, terminate accounts, remove or edit content, or cancel orders in their sole discretion. Tell The Truth is designed for single user use only. Tell The Truth reserves the right to shut down any accounts that are used by multiple people, in order to preserve the integrity of the performance statistics."),
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