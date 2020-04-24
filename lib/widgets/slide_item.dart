import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

import '../model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: getDynamicWidth(300),
          height: getDynamicHeight(300),
          child: Lottie.network(
              slideList[index].imageUrl,
              height: getDynamicHeight(300),
              width: getDynamicWidth(300)),
        ),

        Container(
          width: getDynamicWidth(350),
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  slideList[index].title,
                  style: foregroundTextStyleDark,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  slideList[index].description,
                  style: smallTextStyleDark,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
