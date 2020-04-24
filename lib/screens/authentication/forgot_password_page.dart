import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:tellthetruth/global_file/common_widgets/loading_page.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/global_file/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:tellthetruth/landing_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return F_ForgotPasswordPage();
  }
}

class F_ForgotPasswordPage extends StatefulWidget {
  @override
  _F_ForgotPasswordPageState createState() => _F_ForgotPasswordPageState();
}

class _F_ForgotPasswordPageState extends State<F_ForgotPasswordPage> {

  final _formKey = GlobalKey<FormState>();

  String _email;
  final FocusNode _emailFocusNode = FocusNode();
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
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        setState(() {
          isLoading = false;
        });


        CustomAlertBox(context, 'Success...', 'Reset password link has been sent to ${_email}.',true, (){
          GoToPage(context, LandingPage());
        });

      } on PlatformException catch (e) {
        setState(() {
          isLoading = false;
        });
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }else{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
//    Ads.hideBannerAd();
    super.initState();
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


  Widget _buildContent(BuildContext context) {
    return TransparentLoading(
      loading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: getDynamicHeight(70),
                      ),
                      GradientText(
                        'Forgot Password',
                        style: backgroundTextStyleLight,
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
                      Center(
                        child: SizedBox(
                          width: getDynamicWidth(300),
                          height: getDynamicHeight(300),
                          child: Container(
                              child: FlareActor("images/welcome.flr",
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                  animation: 'Animations')),
                        ),
                      ),
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 10.0, right: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, 0.1),
                                              offset: Offset(3, 3),
                                              blurRadius: 1.0,
                                              spreadRadius: 2.0),
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.9),
                                              offset: Offset(-2, -2),
                                              blurRadius: 1.0,
                                              spreadRadius: 2.0)
                                        ]),
                                    child: new TextFormField(
                                      onChanged: (value) => _email = value,
                                      textInputAction: TextInputAction.done,
                                      autocorrect: true,
                                      obscureText: false,
                                      focusNode: _emailFocusNode,
                                      onEditingComplete: _submit,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: subBackgroundColor,
                                        ),
                                        labelText: "Enter registered email",
                                        labelStyle: smallTextStyleDark,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ),
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                      keyboardType: TextInputType.text,
                                      keyboardAppearance: Brightness.dark,
                                      validator: (value) {
                                        print(value);
                                        if (value.isEmpty) {
                                          return 'Please enter email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(20),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: getDynamicHeight(45)),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(""),
                        ),
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
                                        'Submit',
                                        style: foregroundTextStyleDark,
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2, 1),
                                      blurRadius: 6.0,
                                      spreadRadius: 1.0),
                                ]),
                          ),
                          onTap: () {
                            _submit();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getDynamicHeight(15.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: GradientText(
                            'Go back to login',
                            style: mediumTextStyleDark,
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}