
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/button_widget/backForeText.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'content_preview_page.dart';

class AddOptions extends StatelessWidget {
  AddOptions({@required this.question});
  String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddOptions(question: question,),
    );
  }
}

class F_AddOptions extends StatefulWidget {
  F_AddOptions({@required this.question});
  String question;

  @override
  _F_AddOptionsState createState() => _F_AddOptionsState();
}

class _F_AddOptionsState extends State<F_AddOptions> {

  final _formKey = GlobalKey<FormState>();

  String _optionOne;
  String _optionTwo;
  String _optionThree;
  String _optionFour;

  final FocusNode _optionOneFocusNode = FocusNode();
  final FocusNode _optionTwoFocusNode = FocusNode();
  final FocusNode _optionThreeFocusNode = FocusNode();
  final FocusNode _optionFourFocusNode = FocusNode();

  bool isLoading = false;

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
          PageTransition(type: PageTransitionType.rippleRightDown,
              duration: Duration(seconds: 1),
              alignment: Alignment.bottomCenter,
              child: ContentPreview(question: widget.question,
                optionOne: _optionOne,
                optionTwo: _optionTwo,
                optionThree: _optionThree,
                optionFour: _optionFour,
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
  void dispose() {
    // TODO: implement initState
    _optionOneFocusNode.dispose();
    _optionTwoFocusNode.dispose();
    _optionThreeFocusNode.dispose();
    _optionFourFocusNode.dispose();
    super.dispose();
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
            padding: const EdgeInsets.fromLTRB(15, 18, 15, 0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 30,),
                        color: Colors.white,
                        onPressed: () {Navigator.pop(context, true);},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TranslationAnimatedWidget(
                          enabled: true,
                          duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                          values: [
                            Offset(0, -250), // disabled value value
                            Offset(0, -250), //intermediate value
                            Offset(0, 0) //enabled value
                          ],
                          child:  BackForeTextInput(
                            backText: ["Option 1","Opzione 1","Možnost 1","Opción 1","विकल्प 1","Doorasho 1","Pilihan 1","Optionem 1"],
                            onChanged: (value) => _optionOne = value,
                            textInputAction: TextInputAction.next,
                            focusNode: _optionOneFocusNode,
                            onFieldSubmitted: (value) => value == ''
                                ? null
                                : FocusScope.of(context)
                                .requestFocus(_optionTwoFocusNode),
                            lines:2,
                            length:48,
                            textFont:16,
                            validationText:"Add your Options",
                            hintText:"Add your Options",
                            topPadding:20,
                            hintFont: 16,
                            backTextStyle: backgroundText1,
                            height: 40,
                            showCounterStyle: false,

                          ),
                        ),
//                        SizedBox(height: getDynamicHeight(5),),
                        TranslationAnimatedWidget(
                          enabled: true,
                          duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                          values: [
                            Offset(-200, 250), // disabled value value
                            Offset(-200, 250), //intermediate value
                            Offset(0, 0) //enabled value
                          ],
                          child: BackForeTextInput(
                            backText: ["Option 2","Opzione 2","Možnost 2","Opción 2","विकल्प 2","Doorasho 2","Pilihan 2","Optionem 2"],
                            onChanged: (value) => _optionTwo = value,
                            textInputAction: TextInputAction.next,
                            focusNode: _optionTwoFocusNode,
                            onFieldSubmitted: (value) => value == ''
                                ? null
                                : FocusScope.of(context)
                                .requestFocus(_optionThreeFocusNode),
                            lines:2,
                            length:48,
                            textFont:16,
                            validationText:"Add your options",
                            hintText:"Add your options",
                            topPadding:20,
                            hintFont: 16,
                            backTextStyle: backgroundText1,
                            height: 50,
                            showCounterStyle: false,

                          ),
                        ),
//                        SizedBox(height: getDynamicHeight(5),),
                        TranslationAnimatedWidget(
                          enabled: true,
                          duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                          values: [
                            Offset(400, -250), // disabled value value
                            Offset(400, -250),  //intermediate value
                            Offset(0, 0) //enabled value
                          ],
                          child:  BackForeTextInput(
                            backText: ["Option 3","Opzione 3","Možnost 3","Opción 3","विकल्प 3","Doorasho 3","Pilihan 3","Optionem 3"],
                            onChanged: (value) => _optionThree = value,
                            textInputAction: TextInputAction.next,
                            focusNode: _optionThreeFocusNode,
                            onFieldSubmitted: (value) => value == ''
                                ? null
                                : FocusScope.of(context)
                                .requestFocus(_optionFourFocusNode),
                            lines:2,
                            length:48,
                            textFont:16,
                            validationText:"Add your options",
                            hintText:"Add your options",
                            topPadding:20,
                            hintFont: 16,
                            backTextStyle: backgroundText1,
                            height: 50,
                            showCounterStyle: false,

                          ),/* your widget */
                        ),
//                        SizedBox(height: getDynamicHeight(5),),
                        TranslationAnimatedWidget(
                          enabled: true,
                          duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                          values: [
                            Offset(0, 250), // disabled value value
                            Offset(0, 250), //intermediate value
                            Offset(0, 0) //enabled value
                          ],
                          child:  BackForeTextInput(
                            backText: ["Option 4","Opzione 4","Možnost 4","Opción 4","विकल्प 4","Doorasho 4","Pilihan 4","Optionem 4"],
                            onChanged: (value) => _optionFour = value,
                            textInputAction: TextInputAction.done,
                            focusNode: _optionFourFocusNode,
                            onEditingComplete: _submit,
                            lines:2,
                            length:48,
                            textFont:16,
                            validationText:"Add your options",
                            hintText:"Add your options",
                            topPadding:20,
                            hintFont: 16,
                            backTextStyle: backgroundText1,
                            height: 50,
                            showCounterStyle: false,

                          ),/* your widget */
                        ),
                      ],
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