import 'dart:io';
import 'dart:typed_data';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:swipe_up_menu/swipe_up_menu.dart';
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
      child: Scaffold(
        body: Container(
          color: const Color(0xFF192A56),
          child: Center(
            child: RaisedButton(
              onPressed: () {
                // The menu can be handled programatically using a key
                if (fabKey.currentState.isOpen) {
                  fabKey.currentState.close();
                } else {
                  fabKey.currentState.open();
                }
              },
              color: Colors.white,
              child: Text('Toggle menu programatically', style: TextStyle(color: primaryColor)),
            ),
          ),
        ),
          floatingActionButton: Builder(
            builder: (context) => FabCircularMenu(
              key: fabKey,
              // Cannot be `Alignment.center`
              alignment: Alignment.bottomRight,
              ringColor: Colors.white.withAlpha(25),
              ringDiameter: 800.0,
              ringWidth: 250.0,
              fabSize: 84.0,
              fabElevation: 8.0,

              // Also can use specific color based on wether
              // the menu is open or not:
              // fabOpenColor: Colors.white
              // fabCloseColor: Colors.white
              // These properties take precedence over fabColor
              fabColor: Colors.white,
              fabOpenIcon: Icon(Icons.menu, color: primaryColor),
              fabCloseIcon: Icon(Icons.close, color: primaryColor),
              fabMargin: const EdgeInsets.all(16.0),
              animationDuration: const Duration(milliseconds: 800),
              animationCurve: Curves.easeInOutCirc,
              onDisplayChange: (isOpen) {
                _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
              },
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    _showSnackBar(context, "You pressed 1");
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.looks_one, color: Colors.white),
                ),
                RawMaterialButton(
                  onPressed: () {
                    _showSnackBar(context, "You pressed 2");
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.looks_two, color: Colors.white),
                ),
                RawMaterialButton(
                  onPressed: () {
                    _showSnackBar(context, "You pressed 3");
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.looks_3, color: Colors.white),
                ),
                RawMaterialButton(
                  onPressed: () {
                    _showSnackBar(context, "You pressed 4. This one closes the menu on tap");
                    fabKey.currentState.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.looks_4, color: Colors.white),
                ),
                RawMaterialButton(
                  onPressed: () {
                    _showSnackBar(context, "You pressed 4. This one closes the menu on tap");
                    fabKey.currentState.close();
                  },
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.looks_4, color: Colors.white),
                )
              ],
            ),
          )
      )


    );
  }
  void _showSnackBar (BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1000),
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