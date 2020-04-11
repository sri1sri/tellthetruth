import 'package:flutter/material.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';

class QuestionsPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_QuestionsPage(),
    );
  }
}

class F_QuestionsPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_QuestionsPageState createState() => _F_QuestionsPageState();
}

class _F_QuestionsPageState extends State<F_QuestionsPage> {

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
          backgroundColor:Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.width/7),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back_ios,color: subBackgroundColor,),
              ),
              leftAction: () {
                Navigator.pop(context, true);
              },
              rightActionBar: Container(
                child: Icon(Icons.list,color: subBackgroundColor,),
              ),
              rightAction: () {

              },
              primaryText: 'Tell truth',
              secondaryText: null,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height/1.2,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: GridView.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 0.6,
                                    children: [

                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),
                                      _QuestionListCard("", "who is our father of our nation"),


                                    ]
                                )
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        )
    );

  }
  Widget _QuestionListCard(String imgPath, String Question) {
    return FlatButton(
        disabledColor: Colors.white,
        onPressed: () {

          },
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Container(
            height: 300.0,
            width: 200.0,
            child: Column(
              children: <Widget>[
                Stack(
                    children: [
                      Container(

                          height: 300.0
                      ),
                      Positioned(

                        child:  Container(
                          height: 300.0,
                          width: 200.0,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(imgPath),
                                fit: BoxFit.fitHeight,
                              )
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black87.withOpacity(1.0),
                                        Colors.black54.withOpacity(.1),
                                      ]
                                  )
                              ),
                              child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[

                                    Text(
                                      Question,
                                      style: TextStyle(
                                        fontFamily: 'nunito',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 2.0,
                                          color: Colors.black87,
                                        ),

                                      ],),
                                    ),
                                    SizedBox(height: 10.0),

                                  ]
                              )
                          ),
                        ),

                      ),
                    ]
                ),
              ],
            )
        )
    );
  }

}