import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/home/AddItem.dart';
import 'package:tellthetruth/home/Dashboard.dart';
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
  final DashboardPage _dashboardPage = DashboardPage();
  final AddItemPage _addItemPage = AddItemPage();
  final ProfilePage _profilePage = ProfilePage();
  final SettingsPage _settingsPage = SettingsPage();

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
      case 3:
        return _settingsPage;
        break;
      default:
        return Container(
          child: Text("No Page"),
        );
    }
  }
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0, 0, 0, 0 ),
        child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: pageIndex,
              height: 70.0,
              items: <Widget>[
                Icon(Icons.dashboard, size: 30),
                Icon(Icons.add, size: 30),
                Icon(Icons.account_circle, size: 30),
                Icon(Icons.settings, size: 30),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Color(0Xff30D0DB),
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
                    ],
                  )),
              child: Center(
                child: _showPage,

//                Column(
//                  children: <Widget>[
//                    SizedBox(height: 100,),
//                    Center(
//                      child: InkWell(onTap: (){
//                        _confirmSignOut(context);
//                      },child: Text('logout')),
//                    ),
//                  ],
//                ),
              ),
            )
        ),
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



