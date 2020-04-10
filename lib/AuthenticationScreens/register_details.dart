import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tellthetruth/HomeScreens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:tellthetruth/firebase/api_path.dart';
import 'package:tellthetruth/firebase/firestore_service.dart';
import 'package:tellthetruth/model/user_details.dart';
import 'package:intl/intl.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../landing_page.dart';

class RegisterDetails extends StatelessWidget {

  RegisterDetails({@required this.email});
  String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_RegisterDetails(email: email),
    );
  }
}

class F_RegisterDetails extends StatefulWidget {

  F_RegisterDetails({@required this.email});
  String email;

  @override
  _F_RegisterDetailsState createState() => _F_RegisterDetailsState();
}

class _F_RegisterDetailsState extends State<F_RegisterDetails> {

  final _formKey = GlobalKey<FormState>();

  int group = 1;
  String selectedGender;
  DateTime selectedDate = DateTime.now();
  var customFormat = DateFormat("dd MMMM yyyy 'at' HH:mm:ss 'UTC+5:30'");
  var customFormat2 = DateFormat("dd MMMM yyyy");

  String _username;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _aadharFocusNode = FocusNode();
  final FocusNode _panCardFocusNode = FocusNode();

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1930),
      lastDate: DateTime(2010),
    );
    if (picked != null) {
      setState(() {
        print(customFormat.format(picked));
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _ageFocusNode.dispose();
    _aadharFocusNode.dispose();
    _phoneFocusNode.dispose();
    _panCardFocusNode.dispose();

    super.dispose();
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {


        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        final userDetails = UserDetails(
          username: _username,
         // phoneNumber: '+91${_phoneNumber}',
          gender: group==1 ? 'male':'female',
          dateOfBirth: Timestamp.fromDate(selectedDate),
          joinedDate: Timestamp.fromDate(DateTime.now()),
        //  aadharCard: _aadharNumber,
         // panCard: _panCardNumber,
          emailID: widget.email,
        );

        await FirestoreService.instance.setData(
          path: APIPath.userDetails(user.uid),
          data: userDetails.toMap(),
        );
      //  GoToPage(context, LandingPage());

      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
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

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 80.0, bottom: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                      ),
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Signup", style: titleDark),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Please Sign Up with your details.",
                    style: descriptionDark,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    GenderSelection(
                      maleText: "Male", //default Male
                      femaleText: "Female", //default Female
                      //linearGradient: pinkRedGradient,
                      femaleImage: NetworkImage("https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
                      maleImage: NetworkImage("https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg"),
                      selectedGenderIconBackgroundColor: Colors.indigo, // default red
                      checkIconAlignment: Alignment.centerRight,   // default bottomRight
                      selectedGenderCheckIcon: null, // default Icons.check
                      onChanged: (Gender gender){
                        print(gender);
                      },
                      equallyAligned: true,
                      animationDuration: Duration(milliseconds: 400),
                      isCircular: true, // default : true,
                      isSelectedGenderIconCircular: true,
                      opacityOfGradient: 0.6,
                      padding: const EdgeInsets.all(3),
                      size: 120, //default : 120

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 10),
                      child: Container(
                        child: RaisedButton(
                          color: Colors.white,
                          child: Container(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Select your date of birth.',
                                  style: contentDark,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: backgroundColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              '${customFormat2.format(selectedDate)}',
                                              style: subTitleDark),
                                        ],
                                      ),
                                    ),
                                    Text('Change', style: subTitleDark),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          onPressed: () => showPicker(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            width: 400,
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                  Container(),
                                  Text("SignUp", style: titleDark),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                  Container(),
                                ])),
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: subBackgroundColor,
                                      offset: Offset(2, 1),
                                      blurRadius: 1.0,
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
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing, You accept the Terms & Conditions Of the',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' Terms of use',
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' and',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' Privacy Policies',
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}