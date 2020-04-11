import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';

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
          )),);
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