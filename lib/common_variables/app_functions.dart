import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void GoToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );

//  Navigator.of(context).push(
//    MaterialPageRoute<void>(
//      fullscreenDialog: true,
//      builder: (context) => page,
//    ),
//  );
}

String USER_ID;
String USER_NAME;
String USER_GENDER;

ImageSource IMAGE_SOURCE = ImageSource.gallery;
Size SCREEN_SIZE;
double IPHONE_11_PRO_MAX_HEIGHT = 896;
double IPHONE_11_PRO_MAX_Width = 414;

String getDateTime(int timestamp) {
  var format = new DateFormat('dd MMM yyyy, hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

String getDate(int timestamp) {
  var format = new DateFormat('dd MMMM, yyyy');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

String getTime(int timestamp) {
  var format = new DateFormat('hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  return timestamp == 0 ? '--' : format.format(date);
}


double getDynamicHeight( double height,){
  double actualHeightPercentage = height/IPHONE_11_PRO_MAX_HEIGHT;
  double dynamicHeight = actualHeightPercentage * SCREEN_SIZE.height;

  return dynamicHeight;
}

double getDynamicWidth( double width){
  double actualHeightPercentage = width/IPHONE_11_PRO_MAX_Width;
  double dynamicWidth = actualHeightPercentage * SCREEN_SIZE.width;

  return dynamicWidth;
}

double getDynamicTextSize(double size){
  double actualSizePercentage = size/IPHONE_11_PRO_MAX_Width;
  double dynamicTextSize = actualSizePercentage * SCREEN_SIZE.width;

  return dynamicTextSize;
}

List<int> convertSeconds(int seconds) {
  double sec = seconds.toDouble();
  double min;
  double hours;
  double secondsAfterHours;
  double secondsAfterMinutes;

  secondsAfterHours = sec%3600;

  hours = (sec - secondsAfterHours)/3600;

  secondsAfterMinutes = secondsAfterHours%60;

  min = (secondsAfterHours - secondsAfterMinutes)/60;

  sec = secondsAfterMinutes;

  return [hours.toInt(), min.toInt(), sec.toInt() ];
}

List<String> CONTACT_NUMBERS = new List();

  getAllContacts() async {
  await Contacts.streamContacts().forEach((contact) {
    contact.phones.forEach((phone){
      String spaceRmoved = phone.value.replaceAll(" ", "");
      String con = spaceRmoved.replaceAll("-", "");
      if(con.length>10){
        String onlycon = con.replaceAll(new RegExp(r'[^\w\s]+'),'');

        if(!CONTACT_NUMBERS.contains(onlycon)){
          CONTACT_NUMBERS.add(onlycon);
        }
      }
    });

  }).whenComplete((){
    return CONTACT_NUMBERS;
//      print('contacts ${ContactNumber}');
//      setState(() {
//
//      });
  });
}


