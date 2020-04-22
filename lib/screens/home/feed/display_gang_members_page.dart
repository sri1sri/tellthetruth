import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/landing_page.dart';
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
//  List<dynamic> gangUsersID = [];

  bool showRemove = false;

  @override
  void initState() {
//    gangUsersID = widget.gangDetails.gangUserIDS;
    getUsersDetails(widget.gangDetails.gangUserIDS);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          backgroundColor: Colors.white,
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
                      height: getDynamicHeight(widget.gangDetails.createBy == USER_ID ? 250 : 100),
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

                          widget.gangDetails.createBy == USER_ID ? GestureDetector(
                            onTap: () {
                              setState(() {
                                showRemove = true;
                                _dropdownShown = false;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever),
                                SizedBox(
                                  width: getDynamicWidth(5),
                                ),
                                Text(
                                  "Remove people",
                                  style: answerStyleBlur,
                                ),
                              ],
                            ),
                          ) : Container(height: 0, width: 0,),
                          Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),



                          widget.gangDetails.createBy == USER_ID ? GestureDetector(
                            onTap: () {
                              DBreference.deleteGang(widget.gangDetails.gangID);
                              setState(() {
                                _dropdownShown = false;
                              });
                              GoToPage(context, LandingPage());
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
                          ) : Container(height: 0, width: 0,),
                          Divider(
                            thickness: 1,
                            color: Colors.black54,
                          ),
                          GestureDetector(
                            onTap: () async {
                              widget.gangDetails.gangUserIDS.remove(USER_ID);
                              setState(() {
                                _dropdownShown = false;
                              });
                              final updateGangDetails = GangDetails(gangUserIDS: widget.gangDetails.gangUserIDS);
                              DBreference.updateGang(updateGangDetails, widget.gangDetails.gangID);

                              GoToPage(context, LandingPage());
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
                          widget.gangDetails.createBy == USER_ID ? GestureDetector(
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
                          ) : Container(height: 0, width: 0,)
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
                        height: getDynamicHeight(500),
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(users[index].gender == 'Male' ? "images/boy.png" : "images/girl.png"),
              title: Text(users[index].username,style: answerStyleBlur1,),
              trailing: showRemove ?
              GestureDetector(
                onTap: (){

                  widget.gangDetails.gangUserIDS.remove(users[index].userID);

                  final gangDetails = GangDetails(gangUserIDS: widget.gangDetails.gangUserIDS);
                  DBreference.updateGang(gangDetails, widget.gangDetails.gangID);

//                  setState(() {
//                    gangUsersID = widget.gangDetails.gangUserIDS;
//                  });

                },
                  child: Text('remove'))
                  :
              Container(height: 0, width: 0,),
            ),
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