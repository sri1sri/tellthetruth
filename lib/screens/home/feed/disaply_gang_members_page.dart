import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

class GangMembers extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GangMembers(),
    );
  }
}

class F_GangMembers extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_GangMembersState createState() => _F_GangMembersState();
}

class _F_GangMembersState extends State<F_GangMembers> {

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XffFD8B1F),Colors.white],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter
              )
          ),
          child: SafeArea(
            child: Material(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(expandedHeight: getDynamicHeight(200)),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (_,index) {
                            return SingleChildScrollView(
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 30,),
                                      MemberCard("images/boy.png","Vasanthakumar",),
                                      SizedBox(height: 10,),
                                      MemberCard("images/girl.png","Srivatsav",),
                                      SizedBox(height: 10,),
                                      MemberCard("images/boy.png","VamsiPesala",),
                                      SizedBox(height: 10,),
                                      MemberCard("images/girl.png","Rockstar",),
                                      SizedBox(height: 10,),
                                      MemberCard("images/boy.png","Nandithaa",),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              color: Colors.white,
              onPressed: () {Navigator.pop(context, true);},
            ),
            title: GradientText(
              'Group Members',
              style: boldStyle,
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
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30,),
                    MemberCard("images/boy.png","Vasanthakumar",),
                    SizedBox(height: 10,),
                    MemberCard("images/girl.png","Srivatsav",),
                    SizedBox(height: 10,),
                    MemberCard("images/boy.png","VamsiPesala",),
                    SizedBox(height: 10,),
                    MemberCard("images/girl.png","Rockstar",),
                    SizedBox(height: 10,),
                    MemberCard("images/boy.png","Nandithaa",),
                  ],
                ),
              ),
            ),
          ),
        )
    );

  }

  Widget MemberCard(String imgPath,String name)
  {
    return GestureDetector(
      child: Card(
        elevation: 0,
        child: Container(
          child:Padding(
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
                      SizedBox(width: 15,),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        GradientText(
                        name,
                        style: mediumStyle,
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
                          ]
                      ),
                    ],
                  ),
                  Text("View",style: regularStyle,),
                ]
            ),
          ),
        ),
      ),
      onTap: (){
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => ViewPolicyDetails() ),
//        );
      },
    );
  }

}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XffFD8B1F),
                    Color(0XffD152E0),
                    Color(0Xff30D0DB),],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter
              )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),


            Center(
              child: Opacity(
                opacity: shrinkOffset / expandedHeight,
                child: Text(
                    "Group Members",
                    style: questionStyle1
                ),
              ),
            ),

            Container(),

          ],
        ),
        Positioned(
          top: expandedHeight / 4 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 12,
          right: MediaQuery.of(context).size.width / 12,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 25,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: getDynamicHeight(320),
                width: getDynamicWidth(500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.network("https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json",height: getDynamicHeight(150),width: getDynamicWidth(150)),
                    Text("RockStarts",style: heavyStyle,),
                    Text("6TFBJ73",style: answerStyleBlur,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.art_track,size: 30,color: Colors.black54,),
                            Text("29",style: boldStyle,)
                          ],
                        ),
                        SizedBox(width: getDynamicWidth(50),),
                        Column(
                          children: [
                            Icon(Icons.account_circle,size: 30,color: Colors.black54,),
                            Text("10",style: boldStyle,)
                          ],
                        )
                      ],

                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}