import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/firebase/auth.dart';
import '../common_widgets/ExpandPageTransition.dart';
import '../landing_page.dart';

class OptionEntryPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OptionEntryPage(),
    );
  }
}

class F_OptionEntryPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_OptionEntryPageState createState() => _F_OptionEntryPageState();
}

class _F_OptionEntryPageState extends State<F_OptionEntryPage> {

  final _formKey = GlobalKey<FormState>();


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

  final PageController ctrl = PageController(viewportFraction: 0.2,);

  Widget _buildContent(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          backgroundColor:Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 50),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      IconButton(
                        icon: Icon(Icons.clear,color: Colors.black,size: 30,),
                        color: Colors.white,
                        onPressed: () {Navigator.pop(context, true);},
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: getDynamicWidth(200),
                      height: getDynamicHeight(200),
                      child: Container(
                          child: FlareActor("images/options.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: 'option')),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: getDynamicHeight(50),
                            ),
                            Positioned(
                              top: 0,
                              child:FadeAnimatedTextKit(
                                  text: ["Option 1","Opzione 1","Možnost 1","Opción 1","विकल्प 1","Doorasho 1","Pilihan 1","Optionem 1"],
                                  textStyle: backgroundText,
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center // or Alignment.topLeft
                              ),
                              //Text("Question",style: backgroundText,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30.0),
                              child: Positioned(
                                child: TextFormField(
                                  //onChanged: (value) => _gangName = value,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  autocorrect: true,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  keyboardAppearance: Brightness.dark,
                                  autofocus: true,
                                  cursorColor: Colors.blue,
                                 // maxLength: 100,
                                  //onEditingComplete: _submit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()..shader = linearGradient),
                                  decoration: const InputDecoration(
                                    counterStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    hintText: "Add your 1'st Option",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24, ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                      return 'Please enter Question';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: getDynamicHeight(50),
                            ),
                            Positioned(
                              top: 0,
                              child:FadeAnimatedTextKit(
                                  text: ["Option 2","Opzione 2","Možnost 2","Opción 2","विकल्प 2","Doorasho 2","Pilihan 2","Optionem 2"],
                                  textStyle: backgroundText,
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center // or Alignment.topLeft
                              ),
                              //Text("Question",style: backgroundText,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30.0),
                              child: Positioned(
                                child:TextFormField(
                                  //onChanged: (value) => _gangName = value,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  autocorrect: true,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  keyboardAppearance: Brightness.dark,
                                  autofocus: true,
                                  cursorColor: Colors.blue,
                                  //maxLength: 100,
                                  //onEditingComplete: _submit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()..shader = linearGradient),
                                  decoration: const InputDecoration(
                                    counterStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    hintText: "Add your 2'nd Option",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24, ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                      return 'Please enter Question';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: getDynamicHeight(50),
                            ),
                            Positioned(
                              top: 0,
                              child:FadeAnimatedTextKit(
                                  text: ["Option 3","Opzione 3","Možnost 3","Opción 3","विकल्प 3","Doorasho 3","Pilihan 3","Optionem 3"],
                                  textStyle: backgroundText,
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center // or Alignment.topLeft
                              ),
                              //Text("Question",style: backgroundText,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30.0),
                              child: Positioned(
                                child:TextFormField(
                                  //onChanged: (value) => _gangName = value,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  autocorrect: true,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  keyboardAppearance: Brightness.dark,
                                  autofocus: true,
                                  cursorColor: Colors.blue,
                                 // maxLength: 100,
                                  //onEditingComplete: _submit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()..shader = linearGradient),
                                  decoration: const InputDecoration(
                                    counterStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    hintText: "Add your 3'rd Option",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24, ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                      return 'Please enter Question';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: getDynamicHeight(50),
                            ),
                            Positioned(
                              top: 0,
                              child:FadeAnimatedTextKit(
                                  text: ["Option 4","Opzione 4","Možnost 4","Opción 4","विकल्प 4","Doorasho 4","Pilihan 4","Optionem 4"],
                                  textStyle: backgroundText,
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center // or Alignment.topLeft
                              ),
                              //Text("Question",style: backgroundText,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30.0),
                              child: Positioned(
                                child: TextFormField(
                                  //onChanged: (value) => _gangName = value,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  autocorrect: true,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  keyboardAppearance: Brightness.dark,
                                  autofocus: true,
                                  cursorColor: Colors.blue,
                                  //maxLength: 100,
                                  //onEditingComplete: _submit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()..shader = linearGradient),
                                  decoration: const InputDecoration(
                                    counterStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    hintText: "Add your 4'th Option",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24, ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                      return 'Please enter Question';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                                  Container(
//                                    child: Text(""),
//                                  ),
                      GestureDetector(
                        child: Container(
                          width: getDynamicWidth(180.0),
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(),
                                    GradientText(
                                      'Continue',
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
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.blue,
                                      size: getDynamicTextSize(30),
                                    ),
                                    Container(),
                                  ])),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
//                            gradient: LinearGradient(
//                                colors: <Color>[
//                                Color(0XffFD8B1F),
//                            Color(0XffD152E0),
//                            Color(0Xff30D0DB),
//                            ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(2, 1),
                                    blurRadius: 6.0,
                                    spreadRadius: 1.0),
                              ]),
                        ),
                        onTap: () {
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}