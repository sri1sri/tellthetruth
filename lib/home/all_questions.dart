import 'package:flutter/material.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';


const backgroundGradient = LinearGradient(colors: <Color>[
  Color(0XffFD8B1F),
  Color(0Xff30D0DB),
], begin: Alignment.topLeft, end: Alignment.bottomRight);
const activeGradient = LinearGradient(
  colors: <Color>[
    Colors.white,
    Color(0Xff30D0DB),
    Color(0XffFD8B1F),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const backgroundGradient1 = LinearGradient(colors: <Color>[
  Color(0XffD152E0),
  Color(0Xff30D0DB),
], begin: Alignment.topLeft, end: Alignment.bottomRight);
const backgroundGradient2 = LinearGradient(colors: <Color>[
  Color(0XffFD8B1F),
  Color(0XffD152E0),
], begin: Alignment.topLeft, end: Alignment.bottomRight);



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
                padding: const EdgeInsets.all(10.0),
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
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.6,
                                    children: [

                                      _QuestionListCard(backgroundGradient, "who is our father of our nation","https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png","383","230"),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg","5","30"),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png","36","830"),
                                      _QuestionListCard(backgroundGradient2, "who is our father of our nation","https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg","5","200"),
                                      _QuestionListCard(backgroundGradient1, "who is our father of our nation","https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png","56","340"),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg","64","210"),
                                      _QuestionListCard(backgroundGradient2, "who is our father of our nation","https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg","5756","850"),
                                      _QuestionListCard(activeGradient, "who is our father of our nation","https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png","432","400"),
                                      _QuestionListCard(backgroundGradient1, "who is our father of our nation","https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg","423","420"),
                                      _QuestionListCard(backgroundGradient2, "who is our father of our nation","https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png","3423","700"),


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
  Widget _QuestionListCard(LinearGradient Gradiant, String Question,String imgPath,String views,String response) {
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
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  gradient: Gradiant,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Row(
                                            children: [
                                          CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              imgPath),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                     Text(
                                          Question,
                                          style: questionStyle,
                                          textAlign: TextAlign.center,

                                        ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.remove_red_eye,color: Colors.white,),
                                                  SizedBox(width: 5,),
                                                  Text(views,style: mediumStyle,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.poll,color: Colors.white,),
                                                  SizedBox(width: 5,),
                                                  Text(response,style: mediumStyle,),
                                                ],
                                              ),
                                            ],
                                          ),

                                    ]
                                ),
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