import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
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
          child: Container(
            color: Color(0xFF7E7ED5),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.brown,
                          ),

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Good morning sri,\nCreate a new gang.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                          ),
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
                      keyboardAppearance: Brightness.dark,
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
                          return 'Please enter gangname';
                        }
                        return null;
                      },
                    ),
                  ),

                  Center(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          generateGroupID = groupID.groupID+1;
                        });
                        _submit();
//                      MaterialApp(
//                        onGenerateRoute: (RouteSettings routeSettings){
//                          return new PageRouteBuilder<dynamic>(
//                              settings: routeSettings,
//                              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//                                    return SecondPage();
//                              },
//                              transitionDuration: const Duration(milliseconds: 300),
//                              transitionsBuilder: (BuildContext context, Animation<double> animation,
//                                  Animation<double> secondaryAnimation, Widget child) {
//                                return effectMap[PageTransitionType.slideInUp](Curves.linear, animation, secondaryAnimation, child);
//                              }
//                          );
//                        },
//                      );
//                    Navigator.of(context).push(_createRoute());
//                    Navigator.of(context).push(PageTransition(type: PageTransitionType.slideParallaxUp, child: SecondPage()));
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),

                    ),
                  )
                ],
              ),
            ),
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