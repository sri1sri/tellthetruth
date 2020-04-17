import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyFeedContent extends StatelessWidget {

  final String title;
  final String message;

  const EmptyFeedContent({Key key, this.title = 'Emptyyyyy!!!', this.message ='No items has been added.'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0,),
              Text('Hello dude. You don\'t have any gangs to display.', style: TextStyle(fontSize: 30.0, color: Colors.blueGrey),
              ),
              SizedBox(height: 10.0,),
              Text('How to create gang?', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 10.0,),
              Text('- Go to + tab below.', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 10.0,),
              Text('- Click on Create new gang & have fun.', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 10.0,),
              Text('- Enter you gang name & icon. You will be providing with gang code. That\'s it..!!!', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),

              SizedBox(height: 10.0,),
              Text('How to join gang?', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 10.0,),
              Text('- Go to + tab below.', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 10.0,),
              Text('- Click on Join your gang.', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 10.0,),
              Text('- Enter you gang code. That\'s it..!!!', style: TextStyle(fontSize: 18.0, color: Colors.blueGrey,fontWeight: FontWeight.w600),),
              SizedBox(height: 40.0,),
            ],
          ),
        ),
      ),
    );
  }
}
