import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/global_file/common_widgets/platform_alert/platform_alert_dialog.dart';

import '../../../landing_page.dart';

class Profile extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_Profile(),
    );
  }
}

class F_Profile extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_ProfileState createState() => _F_ProfileState();
}

class _F_ProfileState extends State<F_Profile> {

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

  final PageController ctrl = PageController(viewportFraction: 0.2,);

  Widget _buildContent(BuildContext context) {
    return Container(
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
      child:   Column(
        children: <Widget>[
          SizedBox(height: 100,),
          Center(
            child: InkWell(onTap: (){
              _confirmSignOut(context);
            },child: Text('logout')),
          ),
        ],
      ),
    );
  }


  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      GoToPage(context, LandingPage());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

}