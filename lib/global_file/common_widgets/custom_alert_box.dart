import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

CustomAlertBox(BuildContext context, String title, String desctiption, bool isSuccess, VoidCallback onPressed,){
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return ClipRRect(
          borderRadius: BorderRadius.all(new Radius.circular(15.0)),
        child: AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: isSuccess == true ?
                        Lottie.network("https://assets8.lottiefiles.com/packages/lf20_JAdC3V.json",height: getDynamicHeight(150),width: getDynamicWidth(150))
                            :
                        Lottie.network("https://assets8.lottiefiles.com/packages/lf20_BkscO3.json",height: getDynamicHeight(150),width: getDynamicWidth(150))
                    ),
                    SizedBox(height: getDynamicHeight(10),),
                    Text(title,textAlign: TextAlign.center,style: foregroundTextStyleDark,),
                    SizedBox(height: getDynamicHeight(20),),
                    Text(desctiption,textAlign: TextAlign.center,style: mediumTextStyleMedium,),
                    SizedBox(height: getDynamicHeight(20),),
                    GestureDetector(
                      onTap: onPressed,

                      child: Container(
                        child: isSuccess == true ? Text("OK Cool",style: TextStyle(color: Colors.green,
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: getDynamicTextSize(20),)) : Text("Try Again",style: TextStyle(color: Colors.red,
                          fontFamily: mainFontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: getDynamicTextSize(20),)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


