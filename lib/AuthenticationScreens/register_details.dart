import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:tellthetruth/HomeScreens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_variables/sizeConfig.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:tellthetruth/firebase/api_path.dart';
import 'package:tellthetruth/firebase/firebase_common_variables.dart';
import 'package:tellthetruth/firebase/firestore_service.dart';
import 'package:tellthetruth/model/user_details.dart';
import 'package:intl/intl.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../landing_page.dart';

class RegisterDetails extends StatelessWidget {

  RegisterDetails({@required this.email, @required this.password});
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_RegisterDetails(email: email, password: password),
    );
  }
}

class F_RegisterDetails extends StatefulWidget {

  F_RegisterDetails({@required this.email, @required this.password});
  String email;
  String password;

  @override
  _F_RegisterDetailsState createState() => _F_RegisterDetailsState();
}

class _F_RegisterDetailsState extends State<F_RegisterDetails> {
  final _formKey = GlobalKey<FormState>();

  String _username;
  final FocusNode _usernameFocusNode = FocusNode();

  String selectedGender;

  DateTime selectedDate = DateTime.now();
  var customFormat2 = DateFormat("dd MMMM yyyy");

  bool isLoading = false;

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1930),
      lastDate: DateTime(2010),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
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

  Future<void> _saveData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    final userDetails = UserDetails(
      emailID: widget.email,
      password: widget.password,
      joinedDate: Timestamp.fromDate(DateTime.now()),
      username: _username,
      gender: selectedGender,
      dateOfBirth: Timestamp.fromDate(selectedDate),
    );

    await FirestoreService.instance.setData(
    path: APIPath.userDetails(user.uid),
    data: userDetails.toMap(),
    );
    GoToPage(context, LandingPage());

  }

  Future<void> _submit() async {

    setState(() {
      isLoading = true;
    });

    if (_validateAndSaveForm()) {
      if (selectedGender != null &&
          customFormat2.format(selectedDate) !=
              customFormat2.format(DateTime.now())) {
        try {
          await Firestore.instance
              .collection('${API_SUFFIX}users')
              .where('username',
              isEqualTo: _username)
              .snapshots()
              .listen((data) => {
          if (data.documents.length == 0){
            _saveData(),
          }else{
              setState(() {
            isLoading = false;
          }),
        print('username already taken'),
          }
          });
        } on PlatformException catch (e) {
          PlatformExceptionAlertDialog(
            title: 'Operation failed',
            exception: e,
          ).show(context);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('please fill details corretly');
        setState(() {
          isLoading = false;
        });
      }
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

  Widget _buildContent(BuildContext context) {
    return TransparentLoading(
      loading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: getDynamicHeight(50),
                ),
                GradientText(
                  'Register',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getDynamicWidth(250),
                      height: getDynamicHeight(250),
                      child: FlareActor("images/welcome.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: 'Animations'),
                    ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //  Text("Username",style: mediumStyle,),
                                  // SizedBox(height: 20,),
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
                                      onChanged: (value) => _username = value,
                                      textInputAction: TextInputAction.next,
                                      autocorrect: true,
                                      obscureText: false,
                                      focusNode: _usernameFocusNode,
                                      decoration: new InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: subBackgroundColor,
                                        ),
                                        labelText: "Enter username",
                                        labelStyle: regularStyle,
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
                                          return 'Please enter username';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(30),
                                  ),
                                  Text(
                                    "Date Of Birth",
                                    style: mediumStyle,
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(10),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0, bottom: 10),
                                    child: Container(
                                      child: RaisedButton(
                                        color: Colors.white,
                                        child: Container(
                                          height: getDynamicHeight(60),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                          width: getDynamicWidth(10),
                                                        ),
                                                        Text(
                                                            customFormat2.format(
                                                                        selectedDate) ==
                                                                    customFormat2
                                                                        .format(DateTime
                                                                            .now())
                                                                ? 'Add birthday'
                                                                : '${customFormat2.format(selectedDate)}',
                                                            style: regularStyle),
                                                      ],
                                                    ),
                                                  ),
                                                  GradientText(
                                                    'Change',
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
                                                ],
                                              ),
                                              SizedBox(
                                                width: getDynamicWidth(10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          //FocusScope.of(context).unfocus();
                                          showPicker(context);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(30),
                                  ),
                                  Text(
                                    "Gender",
                                    style: mediumStyle,
                                  ),
//                              SizedBox(height: 20,),
                                  GenderSelection(
                                    maleText: "Male", //default Male
                                    femaleText: "Female", //default Female
                                    //linearGradient: pinkRedGradient,
                                    femaleImage: NetworkImage(
                                        "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
                                    maleImage: NetworkImage(
                                        "https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg"),
                                    selectedGenderIconBackgroundColor:
                                        Colors.green, // default red
                                    checkIconAlignment: Alignment
                                        .centerRight, // default bottomRight
                                    selectedGenderCheckIcon:
                                        null, // default Icons.check
                                    onChanged: (gender) {
                                      selectedGender =
                                          gender.toString().substring(7);
                                    },
                                    equallyAligned: true,
                                    animationDuration:
                                        Duration(milliseconds: 400),
                                    isCircular: true, // default : true,
                                    isSelectedGenderIconCircular: true,
                                    opacityOfGradient: 0.4,
                                    padding: const EdgeInsets.all(3),
                                    size: 120, //default : 120
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(30),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(""),
                    ),
                    GestureDetector(
                      child: Container(
                        width: getDynamicWidth(200),
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                              Container(),
                              GradientText(
                                'Submit',
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
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 30,
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
                  height: getDynamicHeight(30),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'By continuing, You accept the Terms & Conditions Of the',
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
                SizedBox(
                  height: getDynamicHeight(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
