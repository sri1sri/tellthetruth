import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/Add/add_gang_icon.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/button_widget/to_do_button.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/database_model/gang_id_model.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/home/Profile.dart';

class AddGangName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddGangName(),
    );
  }
}

class F_AddGangName extends StatefulWidget {
  @override
  _F_AddGangNameState createState() => _F_AddGangNameState();
}

class _F_AddGangNameState extends State<F_AddGangName> {

  final _formKey = GlobalKey<FormState>();
  String _gangName;
  bool isLoading = false;
  int generateGroupID;


  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {

    setState(() {
      isLoading = true;
    });

    if (_validateAndSaveForm()) {
      print(_gangName);
      print(generateGroupID);

      GoToPage(context, AddGangIcon());


      setState(() {
        isLoading = false;
      });

    }else{
      setState(() {
        isLoading = false;
      });
    }

  }



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

  @override
  Widget _buildContent(BuildContext context) {
    return StreamBuilder<GangCode>(
        stream: DBreference.getGangCode(),
        builder: (context, snapshot) {
          final groupID = snapshot.data;
        return TransparentLoading(
          loading: isLoading,
          child: ControlledAnimation(
            playback: Playback.MIRROR,
            tween: tween,
            duration: tween.duration,
            builder: (context, animation) {
              return Container(
                child: new Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [animation["color1"], animation["color2"],animation["color3"], animation["color4"]])),
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        IconButton(
                                          icon: Icon(Icons.clear,color: Colors.white,size: 30,),
                                          color: Colors.white,
                                          onPressed: () {Navigator.pop(context, true);},
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      backgroundImage: AssetImage("images/male.png"),
                                      radius: 40,
                                      backgroundColor: Colors.transparent,

                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TyperAnimatedTextKit(
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                      text: [
                                        "Good evening $USER_NAME, Create a new gang.",
                                      ],
                                      textStyle:  TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          fontSize: getDynamicTextSize(24),decoration: TextDecoration.none),
                                      textAlign: TextAlign.start,
                                      alignment: AlignmentDirectional.topStart,
                                      isRepeatingAnimation: false,// or Alignment.topLeft
                                    ),
                                  ],
                                ),
                              ),

                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  onChanged: (value) => _gangName = value,
                                  textInputAction: TextInputAction.done,
                                  autocorrect: true,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  keyboardAppearance: Brightness.light,
                                  autofocus: true,
                                  cursorColor: Colors.white,
                                  maxLength: 15,
                                  onEditingComplete: _submit,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,decoration: TextDecoration.none),
                                  decoration: const InputDecoration(
                                    counterStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Add gang name',
                                    hintStyle: TextStyle(
                                        color: Colors.white30,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 26,decoration: TextDecoration.none),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                      return 'Please enter gang name';
                                    }
                                    return null;
                                  },
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
                                      setState(() {
                                        generateGroupID = groupID.groupID+1;
                                      });
                                      _submit();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              );
            },
          ),
        );
      }
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }


}