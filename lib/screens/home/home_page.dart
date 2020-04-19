import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/screens/home/profile/profile_page.dart';
import 'Add/add_page.dart';
import 'feed/feed_page.dart';

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
  final FeedPage _dashboardPage = FeedPage();
  final AddPage _addItemPage = AddPage();
  final Profile _profilePage = Profile();

  Widget _showPage = new FeedPage();
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
    setState(() {
      DBreference = Provider.of<Database>(context, listen: false);
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<UserDetails>(
        stream: DBreference.getUserDetails(USER_ID),
        builder: (context, snapshot) {
          final userDetails = snapshot.data;
          USER_NAME = userDetails != null ? userDetails.username : 'fetching...';
          USER_GENDER = userDetails != null ? userDetails.gender : 'fetching...';
          USER_EMAIL = userDetails != null ? userDetails.emailID : 'fetching...';

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
        child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: pageIndex,
              height: getDynamicHeight(70),
              items: <Widget>[
                Icon(Icons.dashboard, size: 30),
                Icon(Icons.add, size: 30),
                Icon(Icons.account_circle, size: 30),
              ],
              color: Colors.black12,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (int tappedIndex) {
                setState(() {
                  _showPage = _pageChooser(tappedIndex);
                });
              },
            ),
            body: Container(
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