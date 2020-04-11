import 'package:flutter/material.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';

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
                      Colors.white,
                      Color(0Xff30D0DB),
                    ],
                  )),
              child: Column(
                children: [
                  SizedBox(height: 200,),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54, width: 3),
                      borderRadius: BorderRadius.only(bottomLeft: const  Radius.circular(40.0),topLeft: const  Radius.circular(40.0),),
                    ),
                    child: Container(
                      height: 460,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: subBackgroundColor.withOpacity(0.1),
                        borderRadius: BorderRadius.only(bottomLeft: const  Radius.circular(40.0),topLeft: const  Radius.circular(40.0),),),
                      child: Column(
                        children: [
                          Container(
                              height: 460.0,
                              width: 350,
                              padding: EdgeInsets.only(top: 10.0),
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 1.5,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    _buildImage("images/car-insurance.png","vasanth","231"),
                                    _buildImage("images/co2.png","vasanth","231"),
                                    _buildImage("images/garage.png","vasanth","231"),
                                    _buildImage("images/helpline.png","vasanth","231"),
                                    _buildImage("images/motorcycle-2.png","vasanth","231"),
                                    _buildImage("images/parking.png","vasanth","231"),
                                    _buildImage("images/sos.png","vasanth","231"),
                                    _buildImage("images/travel-insurance.png","vasanth","231"),

                                  ])),
                        ],
                      ),
                    ),
                  ),
                ),

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
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => ),
//          );
        },
        child: Column(children: <Widget>[
          Stack(children: [
            Container(
              height: 200.0,
              width: 180,
            ),
            Positioned(
                left: 5.0,
                right: 5.0,
                top: 15.0,
                bottom: 3.0,
                child: Container(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 145.0, bottom: 0.0),
                    height: 145.0,
                    width: 180.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.9)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                                color: Color(0xFF1F4B6E).withOpacity(0.75)),
                          ),

                        ]))),
            Positioned(
                left: 15.0,
                right: 15.0,
                top: 20.0,
                bottom: 40.0,
                child: Container(
                    height: 10.0,
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