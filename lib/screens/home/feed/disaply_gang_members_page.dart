import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

import '../../../database_model/user_details.dart';
import '../../../firebase/api_path.dart';

class GangMembers extends StatelessWidget {
  GangMembers({@required this.gangDetails});
  GangDetails gangDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GangMembers(gangDetails: gangDetails),
    );
  }
}

class F_GangMembers extends StatefulWidget {
  F_GangMembers({@required this.gangDetails, @required this.questionsCount});
  GangDetails gangDetails;
  int questionsCount;

  @override
  _F_GangMembersState createState() => _F_GangMembersState();
}

class _F_GangMembersState extends State<F_GangMembers> {
  bool _dropdownShown = false;

  void _toggleDropdown() {
    setState(() {
      _dropdownShown = !_dropdownShown;
    });
  }

  bool scrollVisible = true;
  bool loading = true;
  List<UserDetails> users = [];
  BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Image.asset('images/people.png'),
            title: "List",
            titleColor: Colors.white,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.white,
            backgroundColor: Colors.pinkAccent,
            onTap: () => print('FOURTH CHILD'),
          ),
          MenuItem(
            child: Image.asset('images/people.png'),
            title: "Team",
            titleColor: Colors.grey[850],
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.grey[850],
            backgroundColor: Colors.grey[50],
            onTap: () => print('THIRD CHILD'),
          ),
          MenuItem(
            child: Image.asset('images/people.png'),
            title: "Profile",
            titleColor: Colors.white,
            subtitle: "Lorem ipsum dolor sit amet, consectetur",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () => print('FOURTH CHILD'),
          )
        ]);
  }

  @override
  void initState() {
    getUsersDetails(widget.gangDetails.gangUserIDS);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.gangDetails.gangUserIDS);

    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    onPressed: _toggleDropdown,
                    color: Colors.white,
                  ),
                  OverlayContainer(
                    show: _dropdownShown,
                    // Let's position this overlay to the right of the button.
                    position: OverlayContainerPosition(
                      // Left position.
                      -200,
                      -50,
                      // Bottom position.
                    ),
                    // The content inside the overlay.
                    child: Container(
                      height: getDynamicHeight(200),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 1,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever),
                                SizedBox(
                                  width: getDynamicWidth(5),
                                ),
                                Text(
                                  "Delete Group",
                                  style: answerStyleBlur,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              children: [
                                Icon(Icons.clear),
                                SizedBox(
                                  width: getDynamicWidth(5),
                                ),
                                Text(
                                  "Leave Group",
                                  style: answerStyleBlur,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  width: getDynamicWidth(5),
                                ),
                                Text(
                                  "Edit Name",
                                  style: answerStyleBlur,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                pinned: true,
                expandedHeight: getDynamicHeight(400.0),
                flexibleSpace: FlexibleSpaceBar(
                  background: MyFlexiableAppBar(
                    gangDetails: widget.gangDetails,
                    usersCount: users.length
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                        height: 500,
                        child: loading
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : _buildContent()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].username),
          );
        },
    );
  }

  getUsersDetails(usersList) async {
    usersList.forEach((f) async {
      print('user ID IS $f');
      var doc = await Firestore.instance
          .collection(APIPath.usersList())
          .document(f)
          .get();
      if (doc.exists) {
        setState(() {
          users.add(UserDetails.fromMap(doc.data, doc.documentID));
          loading = false;
        },
        );
      }
    },
    );
  }

  Widget MemberCard(String imgPath, String name) {
    return GestureDetector(
      child: Card(
        elevation: 0,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(imgPath),
                            radius: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: getDynamicWidth(15),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              name,
                              style: answerStyleBlur1,
                            ),
                          ]),
                    ],
                  ),
                ]),
          ),
        ),
      ),
      onTap: () {
      },
    );
  }
}

class MyFlexiableAppBar extends StatelessWidget {
  MyFlexiableAppBar({@required this.gangDetails, @required this.usersCount});
  GangDetails gangDetails;
  int usersCount;

  final double appBarHeight = 66.0;


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: getDynamicHeight(30),
            ),
            Lottie.network(gangDetails.gangIconURL,
                height: getDynamicHeight(150), width: getDynamicWidth(150)),
            GradientText(
              gangDetails.gangName,
              style: heavyStyle,
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
            Text(
              gangDetails.gangCode,
              style: answerStyleBlur,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.art_track,
                      size: 30,
                      color: Colors.black54,
                    ),
                    Text(
                      gangDetails.gangUserIDS.length.toString(),
                      style: boldStyle,
                    )
                  ],
                ),
                SizedBox(
                  width: getDynamicWidth(50),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.black54,
                    ),
                    Text(
                      usersCount.toString(),
                      style: boldStyle,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}

void showFancyCustomDialog(BuildContext context) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Padding(
              padding: const EdgeInsets.only(left: 150.0, bottom: 400),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: getDynamicHeight(250.0),
                  width: getDynamicWidth(250.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: getDynamicHeight(250),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_forever),
                                      SizedBox(
                                        width: getDynamicWidth(5),
                                      ),
                                      Text(
                                        "Delete Group",
                                        style: answerStyleBlur,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black54,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(Icons.clear),
                                      SizedBox(
                                        width: getDynamicWidth(5),
                                      ),
                                      Text(
                                        "Leave Group",
                                        style: answerStyleBlur,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black54,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: getDynamicWidth(5),
                                      ),
                                      Text(
                                        "Edit Name",
                                        style: answerStyleBlur,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(1.05, -1.05),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}
