import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:finite_coverflow/finite_coverflow.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:tellthetruth/home/dashboard.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/database_model/gang_id_model.dart';
import 'package:tellthetruth/firebase/database.dart';

class AddGangIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddGangIcon(),
    );
  }
}

class F_AddGangIcon extends StatefulWidget {
  @override
  _F_AddGangIconState createState() => _F_AddGangIconState();
}

class _F_AddGangIconState extends State<F_AddGangIcon> {

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Container(),
//                                          IconButton(
//                                            icon: Icon(Icons.clear,color: Colors.white,size: 30,),
//                                            color: Colors.white,
//                                            onPressed: () {Navigator.pop(context, true);},
//                                          ),
//                                        ],
//                                      ),
                                      SizedBox(
                                        height: getDynamicHeight(20),
                                      ),
                                      TyperAnimatedTextKit(
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                        text: [
//                "Good evening Vasanth,",
//                "Ready to create something exiciting ?",
                                          "Hey $USER_NAME, Select your group icon.",
                                        ],
                                        textStyle: questionStyleThin,
                                        textAlign: TextAlign.start,
                                        alignment: AlignmentDirectional.topStart,
                                        isRepeatingAnimation: false,// or Alignment.topLeft
                                      ),
                                      SizedBox(
                                        height: getDynamicHeight(20),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child:SizedBox(
                                    child: getVariableScaleCrousel(),
                                  ),
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Container(
                                        width: getDynamicWidth(200.0),
                                        padding: EdgeInsets.all(15.0),
                                        child: Center(
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(),
                                                  GradientText(
                                                    'Create',
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
                                        showFancyCustomDialog( context );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

  Widget icon(String imgpath )
  {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Card(
          color: Colors.transparent,
          child:GestureDetector(
             onTap: (){
               print(imgpath);
             },
              child: Lottie.network(imgpath,height: getDynamicHeight(200),width: getDynamicWidth(200))),
        ),
      ),
    );

  }

  Widget getVariableScaleCrousel() {
    return FinitePager(
      scaleX: 0.8,
      scaleY: 0.7,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        icon("https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_VCStus.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_uwmgvS.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_CFgBAP.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_OyFTHm.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_BonJMC.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_RWZde1.json"),
        icon("https://assets7.lottiefiles.com/packages/lf20_KMustJ.json"),
      ],
    );
  }


}


void showFancyCustomDialog(BuildContext context) {

  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: getDynamicHeight(600.0),
                width: getDynamicWidth(320.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: getDynamicHeight(600),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: getDynamicHeight(60),),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: getDynamicWidth(200),
                                      height: getDynamicHeight(200),
                                      child: Container(
                                          child: FlareActor("images/success-2.flr",
                                              alignment: Alignment.topRight,
                                              fit: BoxFit.contain,
                                              animation: 'check-success')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(color: Colors.black54,thickness: 1,),
                            ),
                            Column(
                              children: [
                                Text("2DS6AHA",style: boldStyle,),
                                 Lottie.network("https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json",height: getDynamicHeight(100),width: getDynamicWidth(100)),
                                Text("ROCKSTARS",style: boldStyle,)
                              ],
                            ),
                            SizedBox(
                              height: getDynamicHeight(20),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text("Note : The group code has been sent to your group members, then can access the group by it.",style: regularStyle,),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: getDynamicHeight(50),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Success",
                            style: questionStyle
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, PageTransition(type: PageTransitionType.rippleLeftUp, duration: Duration(seconds: 1), child: DashboardPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: getDynamicHeight(50),
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Okay let's go!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(1.05, -1.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}