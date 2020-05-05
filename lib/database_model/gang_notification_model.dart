import 'package:cloud_firestore/cloud_firestore.dart';
class GangNotifications{
  GangNotifications({
    this.topic,
    this.title,
    this.message,
    this.navigateTo,
    this.from,
    this.empty,

  });

  final String topic;
  final String title;
  final String message;
  final String navigateTo;
  final String from;

  final Null empty;


  factory GangNotifications.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }
    final String topic = data['topic'];
    final String title = data['title'];
    final String message = data['message'];
    final String navigateTo = data['navigate_to'];
    final String from = data['from'];

    final Null empty = data['empty'];



    return GangNotifications(
      topic: topic,
      title: title,
      message: message,
      navigateTo: navigateTo,
        from: from,
        empty:empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      topic != null ? 'topic': 'empty' : topic,
      title != null ? 'title': 'empty' : title,
      message != null ? 'message': 'empty' : message,
      navigateTo != null ? 'navigate_to': 'empty' : title,
      from != null ? 'from': 'navigateTo' : from,

    };
  }

}