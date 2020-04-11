
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';


class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {
        this.primaryText,
        this.secondaryText,
        this.leftActionBar,
        this.rightActionBar,
        this.leftAction,
        this.rightAction,
        this.tabBarWidget,
        this.profile,
        this.color,
        this.brightness,
      });

  final Widget leftActionBar;
  final Widget rightActionBar;
  final String primaryText;
  final String secondaryText;
  final VoidCallback leftAction;
  final VoidCallback rightAction;
  final Widget tabBarWidget;
  final Widget profile;
  final Widget color;
  final Widget brightness;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 65,
                    left: 20,
                  ),
                  child: InkWell(
                    child: leftActionBar == null ? Container(
                      height: 0, width: 0,
                    ): leftActionBar,
                    onTap: leftAction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:65.0),
                  child: GradientText(
                    primaryText,
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
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 65,
                    right: 20,
                  ),
                  child: InkWell(
                    child: rightActionBar == null ? Container(
                      height: 0, width: 0,
                    ) : rightActionBar,
                    onTap: rightAction,
                  ),
                ),
              ],
            ),
          ),
          profile == null ? Container(height: 0,width: 0,) :profile,



        ],

      ),
    );
  }


}



