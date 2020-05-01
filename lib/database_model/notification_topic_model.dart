import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tellthetruth/firebase/firebase_common_variables.dart';
class NotificationTopic{
  NotificationTopic({
    this.keysSubscribed,
    this.topic,
    this.gangID,
    this.empty,

  });

  final List<dynamic> keysSubscribed;
  final String topic;
  final String gangID;
  final Null empty;


  factory NotificationTopic.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final List<dynamic> keysSubscribed = data['keysSubscribed'];
    final String topic = data['topic'];
    final String gangID = data['${API_SUFFIX}gang_id'];
    final Null empty = data['empty'];



    return NotificationTopic(
      keysSubscribed: keysSubscribed,
      topic: topic,
      gangID: gangID,
      empty:empty,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      keysSubscribed != null ? 'keysSubscribed': 'empty' : keysSubscribed,
      topic != null ? 'topic': 'empty' : topic,
      gangID != null ? '${API_SUFFIX}gang_id': 'empty' : gangID,
    };
  }
}