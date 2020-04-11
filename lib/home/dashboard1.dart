import 'package:flutter/material.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/home/all_questions.dart';

class DashboardPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DashboardPage(),
    );
  }
}

class F_DashboardPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_DashboardPageState createState() => _F_DashboardPageState();
}

class _F_DashboardPageState extends State<F_DashboardPage> {

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
        home: Container(
          child: new Scaffold(
              backgroundColor:Colors.white,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 200,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(
                              "My gangs / squads",
                              style: TextStyle(
                            color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        fontSize: 17.0,decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                              height: 480.0,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 10.0),
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 1.45,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    _buildImage("images/car-insurance.png","vasanth","the best one"),
                                    _buildImage("images/co2.png","srivatsav","the good one"),
                                    _buildImage("images/garage.png","vamsi","the great one"),
                                    _buildImage("images/helpline.png","jake","the worst one"),
                                    _buildImage("images/motorcycle-2.png","rajaa","the greatest one"),
                                    _buildImage("images/parking.png","eldooo","the great one"),
                                    _buildImage("images/sos.png","sainath","the naughty one"),
                                    _buildImage("images/travel-insurance.png","nanditha","the perfect one"),

                                  ])),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              )
          ),
        )
    );

  }

  Widget _buildImage(String imgPath, String name, String description) {
    return GestureDetector(

        onTap: () {
          GoToPage(context, QuestionsPage());
        },
        child: Column(children: <Widget>[
          Stack(children: [
            Container(
              height: 230.0,
              width: 180,
            ),
            Positioned(
                left: 5.0,
                right: 5.0,
                top: 5.0,
                bottom: 0.0,
                child: Container(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 145.0, bottom: 0.0),
                    height: 145.0,
                    width: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Text(
                            name,
                            style: TextStyle(
                                fontFamily: 'nunito',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1F4B6E)),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            description,
                            style: TextStyle(
                                fontFamily: 'nunito',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0Xff12c2e9).withOpacity(0.75)),
                          ),

                        ]))),
            Positioned(
                left: 15.0,
                right: 15.0,
                top: 5.0,
                bottom: 60.0,
                child: Container(
                    height: 30.0,
                    width: 85.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0)),
                        image: DecorationImage(
                            image: AssetImage(imgPath), fit: BoxFit.contain))))
          ]),
        ]));
  }

}