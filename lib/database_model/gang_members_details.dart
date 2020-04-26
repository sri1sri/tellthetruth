import 'package:cloud_firestore/cloud_firestore.dart';

class GangMembers{
  GangMembers({
    this.userID,
    this.joinedAt,

    this.empty,
  });

  final String userID;
  final Timestamp joinedAt;

  final Null empty;

  factory GangMembers.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String userID = documentID;

    final Timestamp joinedAt = data['joined_at'];

    final Null empty = data['empty'];


    return GangMembers(
      userID: userID,
      joinedAt: joinedAt,

      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      joinedAt != null ? 'joined_at': 'empty' : joinedAt,

    };
  }
}