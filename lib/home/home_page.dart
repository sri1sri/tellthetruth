import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_variables/sizeConfig.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/Add/AddItem.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/home/Dashboard.dart';
import 'package:tellthetruth/home/Dashbroard.dart';
import 'package:tellthetruth/home/Profile.dart';
import 'package:tellthetruth/home/Settings.dart';

import '../landing_page.dart';
const backgroundGradient = LinearGradient(colors: <Color>[
  Color(0XffFD8B1F),
  Color(0XffD152E0),
  Color(0Xff30D0DB),
], begin: Alignment.topLeft, end: Alignment.bottomRight);
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_HomePage(),
    );
  }
}

class F_HomePage extends StatefulWidget {
  @override
  _F_HomePageState createState() => _F_HomePageState();
}

class _F_HomePageState extends State<F_HomePage> {
  int pageIndex = 0;
  final Dashboard1Page _dashboardPage = Dashboard1Page();
  final AddItemPage _addItemPage = AddItemPage();
  final ProfilePage _profilePage = ProfilePage();
//  final SettingsPage _settingsPage = SettingsPage();

  Widget _showPage = new DashboardPage();
  Widget _pageChooser(int page){
    switch(page){
      case 0:
        return _dashboardPage;
        break;
      case 1:
        return _addItemPage;
        break;
      case 2:
        return _profilePage;
        break;
//      case 3:
//        return _settingsPage;
//        break;
      default:
        return Container(
          child: Text("No Page"),
        );
    }
  }
  GlobalKey _bottomNavigationKey = GlobalKey();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final database = Provider.of<Database>(context, listen: false);
      DBreference = database;
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder<UserDetails>(
        stream: DBreference.getUserDetails(),
        builder: (context, snapshot) {
          final userDetails = snapshot.data;
          USER_NAME = userDetails != null ? userDetails.username : 'fetching...';
          USER_GENDER = userDetails != null ? userDetails.gender : 'fetching...';

        return offlineWidget(context);
      }
    );
  }

  Widget offlineWidget (BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ControlledAnimation(
          playback: Playback.MIRROR,
          tween: tween,
          duration: tween.duration,
    builder: (context, animation) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [animation["color1"], animation["color2"],animation["color3"], animation["color4"]])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: pageIndex,
              height: getDynamicHeight(70),
              items: <Widget>[
                Icon(Icons.dashboard, size: 30),
                Icon(Icons.add, size: 30),
                Icon(Icons.account_circle, size: 30),
                //   Icon(Icons.settings, size: 30),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (int tappedIndex) {
                setState(() {
                  _showPage = _pageChooser(tappedIndex);
                });
              },
            ),
            body: Container(
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
              child: Center(
                child: _showPage,
              ),
            )
        ),
      );
    }

        ),
      ),
    );
  }
}