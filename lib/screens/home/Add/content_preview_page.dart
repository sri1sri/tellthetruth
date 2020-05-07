import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finite_coverflow/finite_coverflow.dart';
import 'package:tellthetruth/database_model/gang_notification_model.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/custom_cloud_messaging.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import '../../../landing_page.dart';

class ContentPreview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ContentPreview(),
    );
  }
}

class F_ContentPreview extends StatefulWidget {

  @override
  _F_ContentPreviewState createState() => _F_ContentPreviewState();
}

class _F_ContentPreviewState extends State<F_ContentPreview> {

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionOneController = TextEditingController();
  final TextEditingController _optionTwoController = TextEditingController();
  final TextEditingController _optionThreeController = TextEditingController();
  final TextEditingController _optionFourController = TextEditingController();

  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _optionOneFocusNode = FocusNode();
  final FocusNode _optionTwoFocusNode = FocusNode();
  final FocusNode _optionThreeFocusNode = FocusNode();
  final FocusNode _optionFourFocusNode = FocusNode();


  int _questionCountIndex = 0;

  List<String> questions = [
    "",
    "What are your plans for spring?",
    "How to keep your immune system healthy?",
    "How do you spend your weekends?",
    "How do you feel around me?",
    "Which of these four followings things would you do?",
    "When was your last kiss?",
    "Would you date someone younger than you?",
    "What do you like about me?",
    "What do you prefer?",
    "How are you feeling about 2020?",
    "which is your favorite game?",
    "How much time you spend washing your hands?"
    "Are you afraid of CORONAVIRUS/?"
  ];



  changeQuestion() {
    int questionCount = questions.length;

    setState(() {
      if (_questionCountIndex == questionCount - 1) {
        _questionCountIndex = 0;
      } else {
        _questionCountIndex += 1;
      }
      _questionController.text = questions[_questionCountIndex];
    });
  }


  int _currentColorIndex = 0;
  bool isLoading = false;
  bool isAnonymous = true;
  bool isGangSelected = false;

  List _colors1 = [
    //Get list of colors
    '0XffFD8B1F', '0XffD152E0', '0Xff30D0DB', '0Xff0F2027', '0Xff1f4037', '0Xffc31432', '0Xfff953c6', '0Xff009FFF', '0Xff654ea3', '0Xffa8ff78', '0XffED213A', '0Xff00B4DB', '0Xff005AA7',
    '0Xff636363', '0Xffad5389', '0Xff3E5151', '0Xff11998e', '0XffFC466B', '0Xffc94b4b', '0Xff00F260', '0Xff6D6027', '0Xffff9966', '0Xff7F00FF', '0Xff000000', '0Xff45a247', '0Xff159957',
    '0Xff000046', '0Xffcbb4d4', '0Xff34e89e', '0Xff000428', '0Xff5a3f37', '0Xffba8b02', '0XffFDFC47', '0Xffb6fbff', '0Xff9D50BB', '0Xff780206', '0XffADD100', '0Xff649173', '0Xffff9472',
    '0Xff5D4157', '0Xffe4e4d9', '0Xffc21500', '0Xffcbad6d', '0Xff4b6cb7', '0Xff0ABFBC', '0Xff5f2c82', '0XffED4264', '0Xff283048', '0XffD7DDE8', '0Xff5C258D', '0Xff8E54E9', '0XffFF8008',
    '0XffF45C43', '0Xff4CB8C4', '0Xff1A2980', '0XffAA076B', '0XffFF512F', '0Xff314755', '0Xff1488CC', '0XffFF0099', '0Xffec2F4B',

  ];

  List _colors2 = [
    //Get list of colors
    '0Xff30DD76', '0XffFF871F', '0XffFF3FE0', '0Xff2C5364', '0Xff99f2c8', '0Xff240b36', '0Xffb91d73', '0Xffec2F4B', '0Xffeaafc8', '0Xff78ffd6', '0Xff93291E', '0Xff0083B0',
    '0XffFFFDE4', '0Xffa2ab58', '0Xff3c1053', '0XffDECBA4', '0Xff38ef7d', '0Xff3F5EFB', '0Xff4b134f', '0Xff0575E6', '0XffD3CBB8', '0Xffff5e62',
    '0XffE100FF', '0Xff0f9b0f', '0Xff283c86', '0Xff155799', '0Xff1CB5E0', '0Xff20002c', '0Xff0f3443', '0Xff004e92', '0Xff2c7744', '0Xff181818',
    '0Xff24FE41', '0Xff83a4d4', '0Xff6E48AA', '0Xff061161', '0Xff7B920A', '0XffDBD5A4', '0Xfff2709c', '0XffA8CABA', '0Xff215f00',
    '0Xffffc500', '0Xffd53369', '0Xff182848', '0XffFC354C', '0Xff49a09d', '0XffFFEDBC', '0Xff859398', '0Xff757F9A', '0Xff4389A2', '0Xff4776E6', '0XffFFC837',
    '0XffEB3349', '0Xff3CD3AD', '0Xff26D0CE', '0Xff61045F', '0XffDD2476', '0Xff26a0da', '0Xff2B32B2', '0Xff493240', '0Xff009FFF',

  ];
//
//  List gangIDs= ['2020-04-17 22:17:28.884711', '2020-04-17 22:19:09.291230','2020-04-17 22:17:28.884711', '2020-04-17 22:19:09.291230'];
//  List gangName = ['8 gang', 'Nara batch','8 gang', 'Nara batch'];

  List gangIDs = USER_GANG_ID;
  List gangName = USER_GANG_NAMES;
  List gangNotificationTokens = USER_GANG_NOTIFICATION_TOKENS;


  String selectedGangID = '';
  String selectedGangName = '';
  String selectedGangNotificationTokens = '';


  Color selectGangBackgroundColor = Colors.black54;

  changeBackground() {
    //update with a new color when the user taps button
    int _colorCount = _colors1.length;

    setState(() {
      if (_currentColorIndex == _colorCount - 1) {
        _currentColorIndex = 0;
      } else {
        _currentColorIndex += 1;
      }
      print(_currentColorIndex);
    });
  }


  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });

    final gangNotifications = GangNotifications(
        topic: selectedGangNotificationTokens,
        title: "Hurray..!! It's a ${USER_GENDER == 'Male' ? 'boy' : 'girl'}",
        message: 'New question has been added to $selectedGangName',
        navigateTo: 'question asked',
        from : USER_DEVICE_TOKEN,
    );

    final createQuestion = QuestionDetails(
      createdAt: Timestamp.fromDate(DateTime.now()),
      createdBy: USER_ID,
      endsAt: Timestamp.fromDate(DateTime.now().add(Duration(days: 1))),
      options: [
        _optionOneController.text.capitalize(),
        _optionTwoController.text.capitalize(),
        _optionThreeController.text.capitalize(),
        _optionFourController.text.capitalize(),
      ],
      viewedBy: [],
      deleteAt: Timestamp.fromDate(DateTime.now().add(Duration(days: 2))),
      question: '${_questionController.text}?'.capitalize(),
      isAnonymous: isAnonymous,
//      viewCount: 0,
      optionTwoPolledCount: 0,
      optionThreePolledCount: 0,
      optionFourPolledCount: 0,
      optionOnePolledCount: 0,
      color1: _colors1[_currentColorIndex].toString(),
      color2: _colors2[_currentColorIndex].toString(),
      createByGender: USER_GENDER,
      createdByUsername: USER_NAME,
    );

    await DBreference.createQuestion(createQuestion, selectedGangID);



    await DBreference.createNotification(gangNotifications);


    setState(() {
      isLoading = false;
    });


    CustomAlertBox(context, 'Success', 'Question posted !!!!!', true, () {
      GoToPage(context, LandingPage(), true);
    });
  }

  @override
  void initState() {
    setState(() {
      selectedGangID = gangIDs[0];
      selectedGangName = gangName[0];
      selectedGangNotificationTokens = gangNotificationTokens[0];
    });
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(int.parse(_colors1[_currentColorIndex])),
          Color(int.parse(_colors2[_currentColorIndex])),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: getDynamicHeight(30),),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            isAnonymous ? 'Anonymous mode' : 'Reveal identity',
                            style: mediumTextStyleLight,
                          )
                        ),
                        Text('Tap here to change',
                            style: verySmallTextStyleLight)
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        isAnonymous = !isAnonymous;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: getDynamicWidth(40),
                      height: getDynamicHeight(40),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                          Color(int.parse(_colors1[_currentColorIndex])),
                          Color(int.parse(_colors2[_currentColorIndex])),
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        border: Border.all(
                          color:
                          Colors.white, //                   <--- border color
                          width: getDynamicWidth(3),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onTap: () {
                      changeBackground();
                    },
                  ),
                ],
              ),
            ),
//            SizedBox(height: getDynamicHeight(20),),



            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
               child: Form(
                 child: Column(
                   children: [

                     Padding(
                       padding: const EdgeInsets.only(top: 15.0),
                       child: GestureDetector(
                           onTap: (){
                             print(questions[_questionCountIndex]);
                             changeQuestion();
                           },
                           child: Image(image: AssetImage('images/dice.png'),height: getDynamicHeight(50),width: getDynamicWidth(50),)),
                     ),

                     Padding(
                       padding: const EdgeInsets.fromLTRB(25,10,25,0),
                       child: TextFormField(
                         controller: _questionController,
                         textInputAction: TextInputAction.next,
                         focusNode: _questionFocusNode,
                         onFieldSubmitted: (value) => value == ''
                             ? null
                             : FocusScope.of(context)
                             .requestFocus(_optionOneFocusNode),
                         keyboardType: TextInputType.text,
                         keyboardAppearance: Brightness.light,
                         autofocus: true,
                         autocorrect: false,
                         obscureText: false,
                         cursorColor: Colors.black54,
                         maxLines: 2,
                         maxLength: 64,
                         textAlign: TextAlign.center,
                         style: mediumTextStyleDark,
                         decoration:  InputDecoration(
                           counterText: "",
                           focusedBorder: UnderlineInputBorder(
                             borderSide: const BorderSide(color: Colors.transparent),
                           ),
                           hintText: "Add your Question",
                           hintStyle: mediumTextStyleMedium,
                           enabledBorder: const OutlineInputBorder(
                             borderSide:
                             const BorderSide(color: Colors.transparent, width: 0.0),
                           ),
                         ),
                         validator: (value) {
                           print(value);
                           if (value.isEmpty) {
                             return "Please enter question";
                           }
                           return null;
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20)
                         ),
                         child: Column(
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.only(topLeft: const Radius.circular(30.0),topRight: const Radius.circular(30.0)),
                                 color: Colors.grey.withOpacity(0.4),
                               ),

                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20,),
                                 child: TextFormField(
                                   controller: _optionOneController,
                                   textInputAction: TextInputAction.next,
                                   focusNode: _optionOneFocusNode,
                                   onFieldSubmitted: (value) => value == ''
                                       ? null
                                       : FocusScope.of(context)
                                       .requestFocus(_optionTwoFocusNode),
                                   keyboardType: TextInputType.text,
                                   keyboardAppearance: Brightness.light,
                                   autofocus: true,
                                   autocorrect: false,
                                   obscureText: false,
                                   cursorColor: Colors.black54,
                                   maxLines: 2,
                                   maxLength: 48,
                                   textAlign: TextAlign.center,
                                   style: mediumTextStyleDark,
                                   decoration:  InputDecoration(
                                       counterText: "",
                                     focusedBorder: UnderlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.transparent),
                                     ),
                                     hintText: "Add your option",
                                     hintStyle: mediumTextStyleDark,
                                     enabledBorder: const OutlineInputBorder(
                                       borderSide:
                                       const BorderSide(color: Colors.transparent, width: 0.0),
                                     ),
                                   ),
                                   validator: (value) {
                                     print(value);
                                     if (value.isEmpty) {
                                       return "Please enter option";
                                     }
                                     return null;
                                   },
                                 ),
                               ),
                             ),
                             SizedBox(height: getDynamicHeight(2),),
                             Container(

                               color: Colors.grey.withOpacity(0.4),

                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20),
                                 child: TextFormField(
                                   controller: _optionTwoController,
                                   textInputAction: TextInputAction.next,
                                   focusNode: _optionTwoFocusNode,
                                   onFieldSubmitted: (value) => value == ''
                                       ? null
                                       : FocusScope.of(context)
                                       .requestFocus(_optionThreeFocusNode),
                                   keyboardType: TextInputType.text,
                                   keyboardAppearance: Brightness.light,
                                   autofocus: true,
                                   autocorrect: false,
                                   obscureText: false,
                                   cursorColor: Colors.black54,
                                   maxLines: 2,
                                   maxLength: 48,
                                   textAlign: TextAlign.center,
                                   style: mediumTextStyleDark,
                                   decoration:  InputDecoration(
                                     counterText: "",
                                     focusedBorder: UnderlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.transparent),
                                     ),
                                     hintText: "Add your option",
                                     hintStyle: mediumTextStyleDark,
                                     enabledBorder: const OutlineInputBorder(
                                       borderSide:
                                       const BorderSide(color: Colors.transparent, width: 0.0),
                                     ),
                                   ),
                                   validator: (value) {
                                     print(value);
                                     if (value.isEmpty) {
                                       return "Please enter option";
                                     }
                                     return null;
                                   },
                                 ),
                               ),
                             ),
                             SizedBox(height: getDynamicHeight(2),),
                             Container(
                               color: Colors.grey.withOpacity(0.4),
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20),
                                 child: TextFormField(
                                   controller: _optionThreeController,
                                   textInputAction: TextInputAction.next,
                                   focusNode: _optionThreeFocusNode,
                                   onFieldSubmitted: (value) => value == ''
                                       ? null
                                       : FocusScope.of(context)
                                       .requestFocus(_optionFourFocusNode),
                                   keyboardType: TextInputType.text,
                                   keyboardAppearance: Brightness.light,
                                   autofocus: true,
                                   autocorrect: false,
                                   obscureText: false,
                                   cursorColor: Colors.black54,
                                   maxLines: 2,
                                   maxLength: 48,
                                   textAlign: TextAlign.center,
                                   style: mediumTextStyleDark,
                                   decoration:  InputDecoration(
                                     counterText: "",
                                     focusedBorder: UnderlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.transparent),
                                     ),
                                     hintText: "Add your option",
                                     hintStyle: mediumTextStyleDark,
                                     enabledBorder: const OutlineInputBorder(
                                       borderSide:
                                       const BorderSide(color: Colors.transparent, width: 0.0),
                                     ),
                                   ),
                                   validator: (value) {
                                     print(value);
                                     if (value.isEmpty) {
                                       return "Please enter option";
                                     }
                                     return null;
                                   },
                                 ),
                               ),
                             ),
                             SizedBox(height: getDynamicHeight(2),),
                             Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(bottomRight: const Radius.circular(30.0),bottomLeft: const Radius.circular(30.0)),
                                 color: Colors.grey.withOpacity(0.4),
                               ),

                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20),
                                 child: TextFormField(
                                   controller: _optionFourController,
                                   textInputAction: TextInputAction.done,
                                   focusNode: _optionFourFocusNode,
                                   keyboardType: TextInputType.text,
                                   keyboardAppearance: Brightness.light,
                                   onEditingComplete: (){
                                     FocusScope.of(context).unfocus();
                                   },
                                   autofocus: true,
                                   autocorrect: false,
                                   obscureText: false,
                                   cursorColor: Colors.black54,
                                   maxLines: 2,
                                   maxLength: 48,
                                   textAlign: TextAlign.center,
                                   style: mediumTextStyleDark,
                                   decoration:  InputDecoration(
                                     counterText: "",
                                     focusedBorder: UnderlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.transparent),
                                     ),
                                     hintText: "Add your option",
                                     hintStyle: mediumTextStyleDark,
                                     enabledBorder: const OutlineInputBorder(
                                       borderSide:
                                       const BorderSide(color: Colors.transparent, width: 0.0),
                                     ),
                                   ),
                                   validator: (value) {
                                     print(value);
                                     if (value.isEmpty) {
                                       return "Please enter option";
                                     }
                                     return null;
                                   },
                                 ),
                               ),
                             ),

                           ],

                         )

                       ),
                     )
                   ],
                 ),
               ),

              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Select Gang",
                    style: mediumTextStyleLight,),
                  SizedBox(height: getDynamicHeight(10),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    height: getDynamicHeight(140),
                    width: getDynamicWidth(380),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height:100,
                              child: getVariableScaleCrousel(gangName),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getDynamicHeight(30),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: getDynamicWidth(150.0),
                    padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 5, bottom: 5),
                    child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(),
                              GradientText(
                                'Ask',
                                style: foregroundTextStyleLight,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(int.parse(_colors1[_currentColorIndex])),
                                    Color(int.parse(_colors2[_currentColorIndex])),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              Container(),
                            ])),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                  ),
                  onTap: () {
                    _submit();
                  },
                ),
              ],
            ),
            SizedBox(height: getDynamicHeight(30),),
          ],
        ),
      ),
    );
  }

  Widget getVariableScaleCrousel(gangName) {
    return FinitePager(
      scaleX: 0.8,
      scaleY: 0.7,
      rotationY: 30,
      scrollDirection: Axis.vertical,
      onPageChanged: (index){
        setState(() {
          selectedGangID = gangIDs[index];
          selectedGangName = gangName[index];
          selectedGangNotificationTokens = gangNotificationTokens[index];
        });
        print(selectedGangID);
      },
      children: <Widget>[
        for (var name in gangName)
          _buildImage(name),

      ],
    );
  }


  Widget _buildImage(String gangName) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      height: getDynamicHeight(50),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(gangName,style:mediumTextStyleDark)
            ]),
      ),
    );
  }
}

