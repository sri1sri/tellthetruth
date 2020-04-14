import 'dart:io';
import 'dart:typed_data';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:interactive_add_button_layout/interactive_add_button_layout.dart';
import 'package:screenshot/screenshot.dart';
import 'package:swipe_up_menu/swipe_up_menu.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/home/AddGroup.dart';
import 'package:tellthetruth/home/groupMembers.dart';

class AddItemPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddItemPage(),
    );
  }
}

class F_AddItemPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_AddItemPageState createState() => _F_AddItemPageState();
}

class _F_AddItemPageState extends State<F_AddItemPage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
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
      child: AddButtonLayout(
        color: Colors.white,
        btnColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(top: 80, left: 10),
          child: Column(
            children: <Widget>[
              myWidget(),
              myWidget(),
              myWidget(),
              myWidget(),
            ],
          ),
        ),
        row: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 150,),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.rippleRightDown, duration: Duration(seconds: 1), child: GangName()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 110,
                height: 130,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Container(
                  child: Column(
                    children: [
                      Image( image: AssetImage("images/male.png"),height: 55,width: 55,),
                      Text("Add Group",textAlign: TextAlign.center,style: regularStyle,),
                      ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10,),
              child: Container(
                width: 110,
                height: 130,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Container(
                  child: Column(
                    children: [
                      Image( image: AssetImage("images/female.png"),height: 55,width: 55,),
                      Text("Add Question",textAlign: TextAlign.center,style: regularStyle,),
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 110,
              height: 130,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Container(
                child: Column(
                  children: [
                    Image( image: AssetImage("images/girl.png"),height: 55,width: 55,),
                    Text("Add Group",textAlign: TextAlign.center,style: regularStyle,),
                  ],
                ),
              ),
            ),
          )
        ],
        column: <Widget>[
        ],
      ));
  }

  Widget myWidget() {
    return Container(
        height: 120,
        width: 350,
        padding: EdgeInsets.all(5),
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30, left: 10),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffEBC0D2).withOpacity(0.5),
                      shape: BoxShape.circle),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Container(
                    height: 150,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffEBC0D2).withOpacity(0.2)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: Container(
                            width: 200,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Color(0xfdedede).withOpacity(0.4),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Container(
                            width: 220,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Color(0xfdedede).withOpacity(0.3),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Container(
                            width: 220,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Color(0xfdedede).withOpacity(0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        )


    );
  }

}



//
//////////
//////////////
     //Please dont clear this
//////////////
/////////
//


//ScreenshotController screenshotController = ScreenshotController();
//File _imageFile;
//
//
//@override
//Widget build(BuildContext context) {
//  return Screenshot(child: offlineWidget(context), controller: screenshotController,);
//}

//Widget _buildContent(BuildContext context) {
//  return new MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: new Scaffold(
//        backgroundColor:Colors.white,
//        body: Row(
//          children: <Widget>[
//            Container(
//              decoration: new BoxDecoration(
//                  gradient: new LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    colors: [
//                      Color(0XffFD8B1F),
//                      Color(0XffD152E0),
//                      Color(0Xff30D0DB),
//                    ],
//                  )),
//            ),
//            InkWell(onTap: (){
//              screenshotController.capture().then((File image) {
//                //Capture Done
//                setState(() {
//                  print(_imageFile);
//                  _imageFile = image;
//                  print(_imageFile);
//                  final result = ImageGallerySaver.saveImage(_imageFile.readAsBytesSync());
//                  print(result);
//                });
//              }).catchError((onError) {
//                print(onError);
//              });
//            },
//              child: Text('take screenshot'),),
//
//            _imageFile != null ? Image.file(_imageFile) : Container(height: 10,width: 10,color: Colors.red,),
//
//          ],
//        )
//    ),
//  );
//}