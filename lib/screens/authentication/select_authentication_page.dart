
import 'package:gradient_text/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/model/slide.dart';
import 'package:tellthetruth/screens/authentication/signup_page.dart';
import 'package:tellthetruth/widgets/slide_dots.dart';
import 'package:tellthetruth/widgets/slide_item.dart';
import 'login_page.dart';
import 'login_page_manager.dart';

class SelectAuthentication extends StatefulWidget {
  const SelectAuthentication(
      {Key key, @required this.manager, @required this.isLoading})
      : super(key: key);
  final LoginPageManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) =>
            Provider<LoginPageManager>(
              create: (_) =>
                  LoginPageManager(auth: auth, isLoading: isLoading),
              child: Consumer<LoginPageManager>(
                builder: (context, manager, _) =>
                    SelectAuthentication(
                      manager: manager, isLoading: isLoading.value,
                    ),
              ),
            ),
      ),
    );
  }

  @override
  _SelectAuthenticationState createState() => _SelectAuthenticationState();
}

class _SelectAuthenticationState extends State<SelectAuthentication> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
//    Ads.hideBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
//              Expanded(
//                child: Stack(
//                  alignment: AlignmentDirectional.bottomCenter,
//                  children: <Widget>[
//                    PageView.builder(
//                      scrollDirection: Axis.horizontal,
//                      controller: _pageController,
//                      onPageChanged: _onPageChanged,
//                      itemCount: slideList.length,
//                      itemBuilder: (ctx, i) => SlideItem(i),
//                    ),
//                    Stack(
//                      alignment: AlignmentDirectional.topStart,
//                      children: <Widget>[
//                        Container(
//                          margin: const EdgeInsets.only(bottom: 5),
//                          child: Row(
//                            mainAxisSize: MainAxisSize.min,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              for(int i = 0; i<slideList.length; i++)
//                                if( i == _currentPage )
//                                  SlideDots(true)
//                                else
//                                  SlideDots(false)
//                            ],
//                          ),
//                        )
//                      ],
//                    )
//                  ],
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: getDynamicHeight(50),),
                    Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Image.asset("images/logo1.png",height: getDynamicHeight(90),width: getDynamicWidth(130),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientText(
                              'T',
                              style: logoStyle1,
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
                            GradientText(
                              'ell',
                              style: logoStyle2,
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
                            SizedBox(
                              width: getDynamicWidth(5),
                            ),
                            GradientText(
                              'T',
                              style: logoStyle1,
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
                            GradientText(
                              'he',
                              style: logoStyle2,
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
                            SizedBox(
                              width: getDynamicWidth(5),
                            ),
                            GradientText(
                              'T',
                              style: logoStyle1,
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
                            GradientText(
                              'ruth',
                              style: logoStyle2,
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("images/anonymousIntro.png",height: getDynamicHeight(50),width: getDynamicWidth(50),),
                        SizedBox(width: getDynamicWidth(20),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Anonymous Q&A",style: mediumTextStyleDark,),
                            Text("Question & Answer anonymously\nLater reveal your identity if you\nchange your mind.",textAlign: TextAlign.start,style: TextStyle(color: Colors.black54,
                                fontWeight: FontWeight.w600,fontSize: getDynamicTextSize(16),decoration: TextDecoration.none),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: getDynamicHeight(40),),
                    Row(
                      children: [
                        Image.asset("images/groupsIntro.png",height: getDynamicHeight(50),width: getDynamicWidth(50),),
                        SizedBox(width: getDynamicWidth(20),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create Squads",style: mediumTextStyleDark,),
                            Text("Create you own squads and\nshare the squad code with\nyour friends to join.",textAlign: TextAlign.start,style: TextStyle(color: Colors.black54,
                                fontWeight: FontWeight.w600,fontSize: getDynamicTextSize(16),decoration: TextDecoration.none),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: getDynamicHeight(40),),
                    Row(
                      children: [
                        Image.asset("images/timelimitIntro.png",height: getDynamicHeight(50),width: getDynamicWidth(50),),
                        SizedBox(width: getDynamicWidth(20),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Timelimit",style: mediumTextStyleDark,),
                            Text("Answer it in 24hrs, Else you\nwil miss the chance.",textAlign: TextAlign.start,style: TextStyle(color: Colors.black54,
                                fontWeight: FontWeight.w600,fontSize: getDynamicTextSize(16),decoration: TextDecoration.none),)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: getDynamicHeight(55),
                    width: getDynamicWidth(180),
                    child: GestureDetector(
                      onTap: () {
                        GoToPage(context, LoginPage(), false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft, end: Alignment.bottomRight,
                              colors: [
                                Color(0XffFD8B1F),
                                Color(0XffD152E0),
                                Color(0Xff30D0DB),
                              ]),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: mainFontFamily,
                                    fontWeight: FontWeight.w700,
                                    fontSize: getDynamicTextSize(26),decoration: TextDecoration.none),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
SizedBox(height: 10,),
//                  Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        Text("___________________",style: smallTextStyleDark,),
//                        Text(" Or ",style: smallTextStyleDark,),
//                        Text("___________________",style: smallTextStyleDark,),
//                      ],
//                    ),
//                  ),
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
                          GoToPage(context, SignUpPage(), false);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: getDynamicHeight(20),)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


}
