import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
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
          body: _buildContent(context),
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
