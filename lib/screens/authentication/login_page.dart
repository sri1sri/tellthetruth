import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/firebase/custom_cloud_messaging.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/loading_page.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/global_file/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:tellthetruth/model/email_sign_in_change_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/screens/authentication/signup_page.dart';
import '../../landing_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_LoginPage.create(context),
    );
  }
}

class F_LoginPage extends StatefulWidget {
  F_LoginPage({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => F_LoginPage(model: model),
      ),
    );
  }

  @override
  _F_LoginPageState createState() => _F_LoginPageState();
}

class _F_LoginPageState extends State<F_LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();

      final cloudMessaging = CustomCloudMessaging();
      final userDetails = UserDetails(deviceToken: cloudMessaging.getDeviceToken().toString());
      DBreference.updateUserDetails(userDetails);

      GoToPage(context, LandingPage(), true);
    } on PlatformException catch (e) {
      if (_emailController.text != '' && _passwordController.text != '') {
        PlatformExceptionAlertDialog(
          title: 'SignIn Failed',
          exception: e,
        ).show(context);
      }
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;

    FocusScope.of(context).requestFocus(newFocus);
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
      loading: widget.model.isLoading,
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
                        height: getDynamicHeight(40),
                      ),
                      GradientText(
                        'LogIn',
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
//                        SizedBox(height: dynamicHeight(15), ),
//                        Text("Please enter your login details.",style: mediumStyle,)
                    ]),

//                SizedBox(height: dynamicHeight(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Lottie.network("https://assets5.lottiefiles.com/private_files/lf30_ONrIKs.json",height: getDynamicHeight(300),width: getDynamicWidth(300)),
                ],
              ),
SizedBox(height: getDynamicHeight(40),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
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
                                    controller: _emailController,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    focusNode: _emailFocusNode,
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    onEditingComplete: () =>
                                        _emailEditingComplete(),
                                    onChanged: model.updateEmail,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: subBackgroundColor,
                                      ),
                                      labelText: "Enter your email",
                                      labelStyle: smallTextStyleDark,
                                      errorText: model.emailErrorText,
                                      enabled: model.isLoading == false,
                                      //fillColor: Colors.redAccent,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    style: new TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getDynamicHeight(20),
                                ),
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
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    textInputAction: TextInputAction.done,
                                    onEditingComplete: _submit,
                                    onChanged: model.updatePassword,
                                    decoration: new InputDecoration(
                                      errorText: model.passwordErrorText,
                                      enabled: model.isLoading == false,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: subBackgroundColor,
                                      ),
                                      labelText: "Enter your Password",
                                      labelStyle: smallTextStyleDark,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getDynamicHeight(15.0),
                                ),
                                FlatButton(
                                  child: GradientText(
                                    'Forgot password?',
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPasswordPage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                SizedBox(height: getDynamicHeight(20)),

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
                            width: getDynamicWidth(170.0),
                            height: getDynamicHeight(60),
                            padding: EdgeInsets.all(7.0),
                            child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                  Container(),
                                  GradientText(
                                    'Login',
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
                                    size: getDynamicTextSize(25),
                                  ),
                                  Container(),
                                ])),
                            decoration: BoxDecoration(
                                color: Colors.white,
//                            gradient: LinearGradient(
//                                colors: <Color>[
//                                Color(0XffFD8B1F),
//                            Color(0XffD152E0),
//                            Color(0Xff30D0DB),
//                            ], begin: Alignment.topLeft, end: Alignment.bottomRight),

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
                        Text("Don't have an account?", style: mediumTextStyleDark),
                        FlatButton(
                          child: GradientText(
                            'Sign Up',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
//                  SizedBox(
//                    height: dynamicHeight(20),
//                  ),
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
