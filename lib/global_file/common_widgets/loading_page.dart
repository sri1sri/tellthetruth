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
            loading ? Center(child: Lottie.network("https://assets1.lottiefiles.com/packages/lf20_5Y4qjB.json",
                height: getDynamicHeight(210),
                width: getDynamicWidth(210)),) : Container()
          ],
        ));
  }
}
