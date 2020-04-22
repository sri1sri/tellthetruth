import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class TransparentLoading extends StatelessWidget {
  final Widget child;
  final bool loading;

  const TransparentLoading(
      {Key key, @required this.child, @required this.loading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            child,
            loading ? Center(
              child: Container(
                height: 180,
                width: 180,
                color: Colors.black26,
                child: Center(child: Lottie.network("https://assets6.lottiefiles.com/private_files/lf30_lfmwjU.json",
                    height: getDynamicHeight(160),
                    width: getDynamicWidth(160)),),
              ),
            ) : Container()
          ],
        ));
  }
}
