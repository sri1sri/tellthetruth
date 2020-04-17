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
        child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: MyAppBar(),
                  pinned: true,
                  expandedHeight: getDynamicHeight(400.0),
                  flexibleSpace: FlexibleSpaceBar(
                    background: MyFlexiableAppBar(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","Vasanthakumar",),
                                SizedBox(height: 10,),
                                MemberCard("images/girl.png","Srivatsav",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","VamsiPesala",),
                                SizedBox(height: 10,),
                                MemberCard("images/girl.png","Rockstar",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","Nandithaa",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","Vasanthakumar",),
                                SizedBox(height: 10,),
                                MemberCard("images/girl.png","Srivatsav",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","VamsiPesala",),
                                SizedBox(height: 10,),
                                MemberCard("images/girl.png","Rockstar",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","Nandithaa",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","Vasanthakumar",),
                                SizedBox(height: 10,),
                                MemberCard("images/girl.png","Srivatsav",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","VamsiPesala",),
                                SizedBox(height: 10,),
                                MemberCard("images/girl.png","Rockstar",),
                                SizedBox(height: 10,),
                                MemberCard("images/boy.png","Nandithaa",),
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

                    ],
                  ),
                ),
              ],
            )
        ),
      ),
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
                      SizedBox(width: getDynamicWidth(15) ,),
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

class MyFlexiableAppBar extends StatelessWidget {

  final double appBarHeight = 66.0;

  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: new Center(
          child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(height: getDynamicHeight(30),),
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
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {

  final double barHeight = 66.0;

  const MyAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GradientText(
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

        ],
      ),
    );
  }
}