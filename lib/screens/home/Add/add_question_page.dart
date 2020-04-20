
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/global_file/common_widgets/button_widget/backForeText.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'add_options_page.dart';

class AddQuestion extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddQuestion(),
    );
  }
}

class F_AddQuestion extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_AddQuestionState createState() => _F_AddQuestionState();
}

class _F_AddQuestionState extends State<F_AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  String _question;
  bool isLoading = false;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0XffFD8B1F),
      Color(0XffD152E0),
      Color(0Xff30D0DB),],
  ).createShader(Rect.fromLTWH(150.0, 250.0, 50.0,100));

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
      Navigator.push(context,
          PageTransition(type: PageTransitionType.rippleMiddle,
              duration: Duration(seconds: 2),
              alignment: Alignment.bottomCenter,
              child: AddOptions(question: '${_question}?'.capitalize(),
              ),
          ),
      );

    } else {
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

  final PageController ctrl = PageController(viewportFraction: 0.2,);

  Widget _buildContent(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
          backgroundColor:Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.clear,color: Colors.black,size: 30,),
                            color: Colors.white,
                            onPressed: () {Navigator.pop(context, true);},
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
                                          MainAxisAlignment.end,
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
                                          ])),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      ),
                                ),
                                onTap: () {
                                  _submit();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Lottie.network("https://assets8.lottiefiles.com/packages/lf20_ssIwdK.json",height: getDynamicHeight(210),width: getDynamicWidth(210)),
                      Form(
                        key: _formKey,
                        child: BackForeTextInput(
                          backText: ["Question", "Frage", "Domanda","प्रश्न","Funso","Pertanyaan","Quaestio","Demando"],
                          onChanged: (value)=> _question = value,
                          onEditingComplete: _submit,
                          textInputAction: TextInputAction.done,
                          lines:3,
                          length:64,
                          textFont:24,
                          validationText:"Please enter question",
                          hintText:"Add your Question",
                          topPadding:25,
                          hintFont: 24,
                          backTextStyle: backgroundText,
                          height: 180,
                          showCounterStyle: true,
                        ),
                      ),
                ],
              ),
            ),
          )
      ),
    );
  }
}