//import 'dart:html';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/database_model/gang_notification_model.dart';
import 'package:tellthetruth/database_model/notification_topic_model.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/custom_cloud_messaging.dart';
import 'package:tellthetruth/global_file/common_variables/app_colors.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:tellthetruth/global_file/common_widgets/loading_page.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/firebase/firebase_common_variables.dart';
import 'package:tellthetruth/landing_page.dart';

class JoinGang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return F_JoinGang();
  }
}

class F_JoinGang extends StatefulWidget {
  @override
  _F_JoinGangState createState() => _F_JoinGangState();
}

class _F_JoinGangState extends State<F_JoinGang> {
  final _formKey = GlobalKey<FormState>();
  String _gangCode;
  bool isLoading = false;
  bool check = true;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
//    Ads.hideBannerAd();
    super.initState();
  }

  Future<void> addUserToNotificatios() async{
    Firestore.instance
        .collection('${API_SUFFIX}gangs')
        .where('gang_code', isEqualTo: _gangCode).getDocuments().then((gangData) async {

          final topic = await gangData.documents[0]['gang_notification_token'];
          CustomCloudMessaging().registerToGroupNotCreate(topic);
    });
  }

  Future<void> getNotificationsTokenList(String topic) async {
    var updateNotificationTopic;
    List<dynamic> keysSubscribed;

    Firestore.instance
        .collection('topic_')
        .where('topic', isEqualTo: topic).getDocuments().then((topicData) async {
            keysSubscribed = topicData.documents[0]['keysSubscribed'];
            keysSubscribed.add(USER_DEVICE_TOKEN);

            updateNotificationTopic = NotificationTopic(keysSubscribed: keysSubscribed);
          await DBreference.updateTopic(updateNotificationTopic,topicData.documents[0].documentID);

            await addUserToNotificatios();

          });
  }

  Future<void> _submit() async {
    List usersList;
    var gangDetails;
    String gangID;


    setState(() {
      isLoading = true;
    });

    if (_validateAndSaveForm()) {

      Firestore.instance
          .collection('${API_SUFFIX}gangs')
          .where('gang_code', isEqualTo: _gangCode)
          .getDocuments().then((data) async => {
                if (data.documents.length == 1)
                  {
                    usersList = data.documents[0]['gang_user_ids'],
                    gangID = data.documents[0].documentID.toString(),
                    if (usersList.contains(USER_ID))
                      {
                        check ? CustomAlertBox(
                            context,
                            'Oops...',
                            'You are already member in this gang. Please join in new gang.',
                            false, () {
                          Navigator.pop(context);
                        }) : null,
                      }
                    else
                      {
                        usersList.add(USER_ID),
                        gangDetails = GangDetails(
                            gangUserIDS:
                                usersList.cast<String>().toSet().toList()),
                        await DBreference.updateGang(gangDetails, gangID),

                        await getNotificationsTokenList(data.documents[0]['gang_notification_token']),

                      setState(() {
                      check = false;
                      }),
                        CustomAlertBox(
                            context,
                            'Success...',
                            'You have entered into this gang.',
                            true, () {
                          GoToPage(context, LandingPage(), true);
                        }),

                      }
                  }
                else
                  {
                    check ? CustomAlertBox(
                        context,
                        'Oops...',
                        'You have entered wrong gang code. Please check the you entered.',
                        false, () {
                      Navigator.pop(context);
                    }) : null,
                  }
              });

      setState(() {
        isLoading = false;
      });
    } else {
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
      child: ControlledAnimation(
        playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
        builder: (context, animation) {
          return Container(
            child: new Scaffold(
                body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    animation["color1"],
                    animation["color2"],
                    animation["color3"],
                    animation["color4"]
                  ])),
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              ],
                            ),
//                            CircleAvatar(
//                              backgroundImage: AssetImage("images/male.png"),
//                              radius: 40,
//                              backgroundColor: Colors.transparent,
//                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TyperAnimatedTextKit(
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [
                                "${greeting()} $USER_NAME, Let's join a new gang....!",
                              ],
                              textStyle: foregroundTextStyleLight,
                              textAlign: TextAlign.start,
                              alignment: AlignmentDirectional.topStart,
                              isRepeatingAnimation:
                                  false, // or Alignment.topLeft
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          onChanged: (value) => _gangCode = value,
                          textInputAction: TextInputAction.done,
                          autocorrect: true,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.dark,
                          autofocus: true,
                          cursorColor: Colors.white,
                          onEditingComplete: _submit,
                          style: foregroundTextStyleLight,
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            hintText: 'Add gang code',
                            hintStyle: foregroundTextStyleLight,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                          ),
                          validator: (value) {
                            print(value);
                            if (value.isEmpty) {
                              return 'Please enter gang code';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              width: getDynamicWidth(150.0),
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                              child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                    Container(),
                                    GradientText(
                                      'Join',
                                      style: foregroundTextStyleLight,
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
                                      size: getDynamicTextSize(30),
                                    ),
                                    Container(),
                                  ])),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(45.0),),
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
              ),
            )),
          );
        },
      ),
    );
  }
}
