
import 'package:flutter/cupertino.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';



class OfflinePage extends CustomOfflinePage{
  OfflinePage({
    @required String text,
  }) : assert(text != null),
        super(
        text: text,
      );
}

class CustomOfflinePage extends StatelessWidget {

  CustomOfflinePage({this.text});

  final text;

  @override



  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getDynamicHeight(100.0),),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GradientText(
                'Tell The Truth',
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
            ),
            SizedBox(
              width: getDynamicWidth(400.0),
              height: getDynamicHeight(500.0),
              child: FlareActor("images/no internet.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:'no_netwrok'),
            ),
            //Splash(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('No Internet connection.\nPlease check connection!!!',style: boldStyle,),
            ),

          ],
        ) ,
      ),
    );
  }
}