import 'package:cloud_firestore/cloud_firestore.dart';

class Qustionetails{
  Qustionetails({
    this.questionID,
    this.createdAt,
    this.createdBy,
    this.options,
    this.revealIdentity,
    this.endAt,
    this.viewCount,

    this.question,

    this.empty,
  });

  final String questionID;
  final Timestamp createdAt;
  final Timestamp endAt;
  final String createdBy;
  final List<String> options;
  final bool revealIdentity;
  final String question;
  final int viewCount;

//  final Map<dynamic, dynamic> qufestion;


  final Null empty;

  factory Qustionetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String questionID = documentID;
    final Timestamp createdAt = data['created_at'];
    final Timestamp endAt = data['end_at'];
    final String createdBy = data['created_by'];
    final List<String> options = data['options'];
    final bool revealIdentity = data['reveal_identity'];
    final String question = data['question'];
    final int viewCount = data['view_count'];

    final Null empty = data['empty'];


    return Qustionetails(
      createdAt: createdAt,
      endAt:endAt,
      createdBy:createdBy,
      options:options,
      revealIdentity:revealIdentity,
      question: question,
      viewCount: viewCount,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      createdAt != null ? 'created_at': 'empty' : createdAt,
      endAt != null ? 'end_at': 'empty' : endAt,
      createdBy != null ? 'created_by': 'empty' : createdBy,
      options != null ? 'options': 'empty' : options,
      question != null ? 'question': 'empty' : question,
      viewCount != null ? 'view_count': 'empty' : viewCount,
      revealIdentity != null ? 'reveal_identity': 'empty' : revealIdentity,

    };
  }
}