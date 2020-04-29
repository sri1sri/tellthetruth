import 'package:cloud_firestore/cloud_firestore.dart';
class GangNotifications{
  GangNotifications({
    this.name,
    this.topic,
    this.empty,

  });

  final String name;
  final String topic;
  final Null empty;


  factory GangNotifications.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String name = data['name'];
    final String topic = data['topic'];
    final Null empty = data['empty'];



    return GangNotifications(
      name: name,
      topic: topic,
        empty:empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      name != null ? 'name': 'empty' : name,
      topic != null ? 'topic': 'empty' : topic,

    };
  }

}