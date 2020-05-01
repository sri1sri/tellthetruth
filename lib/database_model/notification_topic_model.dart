import 'package:cloud_firestore/cloud_firestore.dart';
class NotificationTopic{
  NotificationTopic({
    this.keysSubscribed,
    this.topic,
    this.empty,

  });

  final List<dynamic> keysSubscribed;
  final String topic;
  final Null empty;


  factory NotificationTopic.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final List<dynamic> keysSubscribed = data['keysSubscribed'];
    final String topic = data['topic'];
    final Null empty = data['empty'];



    return NotificationTopic(
      keysSubscribed: keysSubscribed,
      topic: topic,
      empty:empty,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      keysSubscribed != null ? 'keysSubscribed': 'empty' : keysSubscribed,
      topic != null ? 'topic': 'empty' : topic,
    };
  }
}