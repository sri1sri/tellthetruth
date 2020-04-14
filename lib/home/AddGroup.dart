import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:tellthetruth/home/Profile.dart';

class GangName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GangName(),
    );
  }
}

class F_GangName extends StatefulWidget {
  @override
  _F_GangNameState createState() => _F_GangNameState();
}

class _F_GangNameState extends State<F_GangName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      'Nice to meet you! What do\nYour friends call you?',
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
              Container(
                child: Column(
                  children: <Widget>[

                    Container(
                        child: TextFormField(
                          cursorColor: Colors.white,
                          maxLength: 32,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat-Bold',

                          ),
                          decoration: const InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            hintText: 'Your Nick Name',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.transparent, width: 0.0),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Center(
                child: FlatButton(
                  onPressed: () {
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