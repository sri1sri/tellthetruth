import 'dart:async';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import '../../../landing_page.dart';

class ContentPreview extends StatelessWidget {

  ContentPreview({@required this.question,
    @required this.optionOne,
    @required this.optionTwo,
    @required this.optionThree,
    @required this.optionFour,
  });

  String question;
  String optionOne;
  String optionTwo;
  String optionThree;
  String optionFour;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ContentPreview(question: question,
        optionOne: optionOne,
        optionTwo: optionTwo,
        optionThree: optionThree,
        optionFour: optionFour,
      ),
    );
  }
}

class F_ContentPreview extends StatefulWidget {
  F_ContentPreview({@required this.question,
    @required this.optionOne,
    @required this.optionTwo,
    @required this.optionThree,
    @required this.optionFour,
  });

   String question;
   String optionOne;
   String optionTwo;
   String optionThree;
   String optionFour;

  @override
  _F_ContentPreviewState createState() => _F_ContentPreviewState();
}

class _F_ContentPreviewState extends State<F_ContentPreview> {

  int _currentColorIndex = 0;
  bool isLoading = false;
  bool isAnonymous = true;
  bool isGangSelected = false;

  List _colors1 = [ //Get list of colors
    '0XffFD8B1F',
    '0XffD152E0',
    '0Xff30D0DB',
  ];

  List _colors2 = [ //Get list of colors
    '0Xff30DD76',
    '0XffFF871F',
    '0XffFF3FE0',
  ];

  List gangIDs= ['2020-04-17 22:17:28.884711', '2020-04-17 22:19:09.291230'];
  List gangName = ['8 gang', 'Nara batch',];

  String selectedGangID;

  Color selectGangBackgroundColor = Colors.black54;

  changeBackground() { //update with a new color when the user taps button
    int _colorCount = _colors1.length;

    setState(() {
      if (_currentColorIndex == _colorCount - 1) {
        _currentColorIndex = 0;
      } else {
        _currentColorIndex += 1;
      }
      print(_currentColorIndex);
    }
    );
  }
  

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });


    final createQuestion = QuestionDetails(
      createdAt: Timestamp.fromDate(DateTime.now()),
      createdBy: USER_ID,
      endsAt: Timestamp.fromDate(DateTime.now().add(Duration(days: 1))),
      options: [widget.optionOne, widget.optionTwo, widget.optionThree, widget.optionFour],
      question: widget.question,
      isAnonymous: isAnonymous,
      viewCount: 0,
      optionTwoPolledCount: 0,
      optionThreePolledCount: 0,
      optionFourPolledCount: 0,
      optionOnePolledCount: 0,
      color1: _colors1[_currentColorIndex].toString(),
      color2: _colors2[_currentColorIndex].toString(),
      createByGender: USER_GENDER,
    );

    await DBreference.createQuestion(createQuestion, selectedGangID);
    setState(() {
      isLoading = false;
    });

    CustomAlertBox(context,
        'Success',
        'Question posted !!!!!',
        true, (){
      GoToPage(context, LandingPage());
    });


  }
  
  @override
  Widget build(BuildContext context) {
    return offlineWidget( context );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0, 0, 0, 0 ),
        child: Scaffold(
          body: _buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: MediaQuery.of( context ).size.width,
      height: MediaQuery.of( context ).size.height,
      decoration: new BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(int.parse(_colors1[_currentColorIndex])),
          Color(int.parse(_colors2[_currentColorIndex])),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:15.0,right: 15,top:20 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector( child: Icon(
                  Icons.close, color: Colors.white,size: 30, ),
                  onTap: () {
                    Navigator.pop( context, true );
                  },
                ),

                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: isAnonymous ? Text('Anonymous mode', style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),)
                            :
                        Text('Reveal identity ', style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),),
                      ),
                      Text('Tap here to change', style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: getDynamicTextSize(12),decoration: TextDecoration.none))
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isAnonymous ? isAnonymous = false : isAnonymous = true;
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
                        color: Colors.white, //                   <--- border color
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
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: getDynamicWidth(MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular( 5 ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all( 20.0 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GradientText(
                            widget.question,
                            textAlign: TextAlign.center,
                            style: mediumStyle,
                            gradient: LinearGradient(
                              colors: [
                                Color( 0XffFD8B1F ),
                                Color( 0XffD152E0 ),
                                Color( 0Xff30D0DB ),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        child: OptionCard(context ,widget.optionOne),
                      ),
                      SizedBox(height: getDynamicHeight(8),),
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(-200, 250), // disabled value value
                          Offset(-200, 250), //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionTwo),
                      ),
                      SizedBox(height: getDynamicHeight(8),),
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(400, -250), // disabled value value
                          Offset(400, -250),  //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionThree),/* your widget */
                      ),
                      SizedBox(height: getDynamicHeight(8),),
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(0, 250), // disabled value value
                          Offset(0, 250), //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionFour),/* your widget */
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                Text("Select Gang",style: TextStyle(
//                    color: Colors.white,
//                    fontFamily: 'Montserrat',
//                    fontWeight: FontWeight.w600,
//                    fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),),


                DropDownFormField(
                  titleText: '',
                  hintText: 'Please select gang name',
                  value: selectedGangId,
                  onSaved: (value) {
                    setState(() {
                      selectedGangId = gangIDs[value];
                    });
                    print(selectedGangID);
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedGangId = gangIDs[value];
                    });
                    print(selectedGangID);
                  },
                  dataSource: displayDropDownValues(gangName),
                  textField: 'display',
                  valueField: 'value',
                  validator: (value) =>
                  value.isNotEmpty ? null : 'company name cant\'t be empty.',
                )


//                Container(
//                    color: Colors.transparent,
//                    height: getDynamicHeight(80.0) ,
//                    width: MediaQuery.of(context).size.width ,
//                    child: SingleChildScrollView(
//                      scrollDirection: Axis.horizontal,
//                      child:Row(
//                        children: [
//                          for (var i = 0; i < gangName.length; i++)
//                            _buildImage(i, selectGangBackgroundColor),
//                        ],
//                      ) ,
//                    )
//                ),
              ],
            ),
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
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(),
                            GradientText(
                              'Ask',
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
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: getDynamicTextSize(15),
                            ),
                            Container(),
                          ])),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
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
        ],
      ),
    );
  }

  displayDropDownValues(gangNames){
    try{
      for(var i=0; i < gangName.length; i++){
        var x = {
          "display": gangName[i],
          "value": i,
        };
        dropDownValues.add(x);
      }
      return(dropDownValues.take([gangNames][0].length).toList());
    }finally{
      dropDownValues.clear();
    }
  }

  var dropDownValues = [];
  String selectedGangId;

//  Widget _buildImage(int index, Color backgroundColor) {
//    return Padding(
//      padding: const EdgeInsets.only(left: 7, right: 7),
//      child: GestureDetector(
//        onTap: (){
//          setState(() {
//            selectGangBackgroundColor = Colors.white;
//            selectedGangID = gangIDs[index];
//          });
//        },
//        child: Container(
//          color: backgroundColor,
//          height: getDynamicHeight(50),
//          child: Padding(
//            padding: const EdgeInsets.only(left: 15,right: 15),
//            child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  GradientText(
//                    gangName[index],
//                    style: questionStyle1,
//                    gradient: LinearGradient(
//                      colors: selectedGangID == null ? [
//                        Colors.white,
//                        Colors.white,
//                        Colors.white,
//                      ] : [
//                        Color(0XffFD8B1F),
//                        Color(0XffD152E0),
//                        Color(0Xff30D0DB),
//                      ],
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight,
//                    ),
//                  ),
//                ]),
//          ),
//        ),
//      ),
//    );
//  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 5 ),
      padding: EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 15 ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GradientText(
            '$value',
            textAlign: TextAlign.center,
            style: boldStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          GradientText(
            '$label',
            style: answerStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}

Widget OptionCard(BuildContext context ,String Option)
{
  return Container(
    //height: getDynamicHeight(55),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular( 5 ),
    ),
    child: Padding(
      padding: const EdgeInsets.only( left: 15.0, right: 15.0 ,top:20,bottom:20 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: getDynamicWidth(MediaQuery.of(context).size.width/1.3),
            child: GradientText(
              Option,
              style: answerStyle,
              gradient: LinearGradient(
                colors: [
                  Color( 0XffFD8B1F ),
                  Color( 0XffD152E0 ),
                  Color( 0Xff30D0DB ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
    ),
  );

}