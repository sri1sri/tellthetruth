import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/AuthenticationScreens/register_details.dart';
import 'package:tellthetruth/AuthenticationScreens/register_account_page_model.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'EmailAuth.dart';

class SignupPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SignupPage.create(context),
    );
  }
}

class F_SignupPage extends StatefulWidget {
  F_SignupPage({@required this.model});
  final RegisterAccountPageModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<RegisterAccountPageModel>(
      create: (context) => RegisterAccountPageModel(auth: auth),
      child: Consumer<RegisterAccountPageModel>(
        builder: (context, model, _) => F_SignupPage(model: model),
      ),
    );
  }
  
  @override
  _F_SignupPageState createState() => _F_SignupPageState();
}

class _F_SignupPageState extends State<F_SignupPage> {

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  
  RegisterAccountPageModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      GoToPage(context, RegisterDetails());
    } on PlatformException catch (e) {
      if(_emailController.text != '' && _passwordController.text != '') {
        PlatformExceptionAlertDialog(
          title: 'SignUp Failed',
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
      child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    GradientText(
                      'Sign Up',
                      style: heavyStyle,
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
                    SizedBox(height: 15.0,),
                    Text("Please register with your details.",style: mediumStyle,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350.0,
                          height: 350.0,
                          child: FlareActor("images/walk.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:'Untitled'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left:10.0,right: 10),
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
                                      child:new TextFormField(
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
                                          labelText: "Register your email",
                                          labelStyle: regularStyle,
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
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                                offset: Offset(3, 3),
                                                blurRadius: 1.0,
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
                                        textInputAction: TextInputAction.done,
                                        obscureText: true,
                                        focusNode: _passwordFocusNode,
                                        autocorrect: false,
                                        keyboardType: TextInputType.emailAddress,
                                        onEditingComplete: () => _submit(),
                                        onChanged: model.updatePassword,
                                        decoration: new InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: subBackgroundColor,
                                          ),
                                          labelText: "Enter your Password",
                                          labelStyle: regularStyle,
                                          errorText: model.passwordErrorText,
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

                                  ],
                                ),
                              ),
                            )


                          ],
                        ),

                      ],
                    ),


                    SizedBox(
                      height: 0,
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
                                        'Continue',
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
                                      Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),
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
                            "Already have an account?",
                            style: mediumStyle
                        ),
                        FlatButton(
                          child: GradientText(
                            'Login',
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmailAuthentication(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}