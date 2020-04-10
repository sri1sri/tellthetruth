//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clip_shadow/clip_shadow.dart';
import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/AuthenticationScreens/signup_page.dart';
//import 'package:tellthetruth/HomeScreens/home_page.dart';
//import 'package:covidapp/AuthenticationScreens/Verify_Otp.dart';
//import 'package:covidapp/Models/phone_number_page_model.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/button_widget/to_do_button.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/model/email_sign_in_change_model.dart';
//import 'package:covidapp/firebase/auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/widgets/Style.dart';
import 'package:tellthetruth/widgets/icon_button.dart';

class EmailAuthenticationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_EmailAuthenticationPage.create(context),
    );
  }
}

class F_EmailAuthenticationPage extends StatefulWidget {
  F_EmailAuthenticationPage({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) => F_EmailAuthenticationPage(model: model),
      ),
    );
  }


  @override
  _F_EmailAuthenticationPageState createState() => _F_EmailAuthenticationPageState();
}

class _F_EmailAuthenticationPageState extends State<F_EmailAuthenticationPage> {

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
      Navigator.of(context).pop();
      //                        GoToPage(context, LandingPage());
    } on PlatformException catch (e) {
      if(_emailController.text != '' && _passwordController.text != ''){
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
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0, 0, 0, 0 ),
        child: Scaffold(
          body:_buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {

    return TransparentLoading(
      loading: widget.model.isLoading,
      child:Scaffold(
        backgroundColor: Color(0XffCDDEEC),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, //                   <--- border color
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFEFF4F8),
                        boxShadow: softUiShadow,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                    ),


                    //CustomIconButton(iconName: Icons.arrow_back_ios,),
                  onTap:() {Navigator.pop(context, true);},
                ),
                ClipShadow(
                  clipper: RoundedDiagonalPathClipper(),
                  boxShadow: softUiShadow,
                  child: Container(
                    height: 610,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(36.0)),
                      color: Colors.white70,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Positioned(
                          child: SizedBox(
                            width: 350.0,
                            height: 350.0,
                            child: FlareActor("images/welcome.flr", alignment:Alignment.bottomCenter, fit:BoxFit.contain, animation:'Animations'),
                          ),

                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(10.0),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              Text("Welcome",style: contentDark),
//                              Text("Login",style: bigTitleStyle,),
//                            ],),
//                        ),
//                        SizedBox(
//                          height: 60,
//                        ),
                        GradientText(
                          'LogIn',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 40.0,decoration: TextDecoration.none),
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
                        SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(left:20.0,right: 20),
                               child: Column(
                                 children: <Widget>[
                                   Container(
                                     decoration: BoxDecoration(
                                         color: Color(0XFFEFF3F6),
                                         borderRadius: BorderRadius.circular(10.0),
                                         boxShadow: [
                                           BoxShadow(
                                               color: Color.fromRGBO(0, 0, 0, 0.1),
                                               offset: Offset(3, 3),
                                               blurRadius: 2.0,
                                               spreadRadius: 2.0
                                           ),
                                           BoxShadow(
                                               color: Color.fromRGBO(255, 255, 255, 0.9),
                                               offset: Offset(-2, -2),
                                               blurRadius: 1.0,
                                               spreadRadius: 2.0
                                           )
                                         ]
                                     ),
                                     child: new TextFormField(
                                       controller: _emailController,
                                       textInputAction: TextInputAction.next,
                                       obscureText: false,
                                       focusNode: _emailFocusNode,
                                       autocorrect: false,
                                       keyboardType: TextInputType.emailAddress,
                                       onEditingComplete: () => _emailEditingComplete(),
                                       onChanged: model.updateEmail,
                                       decoration: new InputDecoration(
                                         prefixIcon: Icon(
                                           Icons.mail,
                                           color: subBackgroundColor,
                                         ),
                                         labelText: "Enter your email",
                                         errorText: model.emailErrorText,
                                         enabled: model.isLoading == false,
                                         //fillColor: Colors.redAccent,
                                         border: new OutlineInputBorder(
                                           borderRadius: new BorderRadius.circular(5.0),
                                           borderSide: new BorderSide(),
                                         ),
                                       ),
                                       style: new TextStyle(
                                         fontFamily: "Poppins",
                                       ),
                                     ),
                                   ),
                                   SizedBox(height: 30.0,),
                                   Container(
                                     decoration: BoxDecoration(
                                         color: Color(0XFFEFF3F6),
                                         borderRadius: BorderRadius.circular(10.0),
                                         boxShadow: [
                                           BoxShadow(
                                               color: Color.fromRGBO(0, 0, 0, 0.1),
                                               offset: Offset(3, 3),
                                               blurRadius: 2.0,
                                               spreadRadius: 2.0
                                           ),
                                           BoxShadow(
                                               color: Color.fromRGBO(255, 255, 255, 0.9),
                                               offset: Offset(-2, -2),
                                               blurRadius: 1.0,
                                               spreadRadius: 2.0
                                           )
                                         ]
                                     ),
                                     child: new TextFormField(
                                       controller: _passwordController,
                                       focusNode: _passwordFocusNode,
                                       obscureText: true,
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
                                         border: new OutlineInputBorder(
                                           borderRadius: new BorderRadius.circular(5.0),
                                           borderSide: new BorderSide(),
                                         ),
                                       ),
                                       keyboardType: TextInputType.text,
                                       style: new TextStyle(
                                         fontFamily: "Poppins",
                                       ),
                                     ),
                                   ),
                                   SizedBox(height: 30.0,),

                                 ],
                               ),
                             ),
                           )


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(child: Text(""),),
                    GestureDetector(
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(),
                                  GradientText(
                                    'Login',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30.0,decoration: TextDecoration.none),
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
                                  Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),
                                  Container(),
                                ])),
                        decoration: BoxDecoration(
                            color: Colors.white70,
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
                                  offset: Offset(2,1),
                                  blurRadius: 6.0,
                                  spreadRadius: 1.0
                              ),

                            ]
                        ),
                      ),
                      onTap: (){

                        _submit();
                      },
                    ),

                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "Don't have an account?",
                        style: descriptionDark
                    ),
                    FlatButton(
                      child: GradientText(
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 25.0,decoration: TextDecoration.none),
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
                            builder: (context) =>
                                SignupPage(
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}