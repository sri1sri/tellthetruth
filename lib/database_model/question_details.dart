import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionDetails{
  QuestionDetails({
    this.questionID,
    this.createdAt,
    this.createdBy,
    this.options,
    this.revealIdentity,
    this.endsAt,
    this.viewCount,
    this.answeredCount,
    this.question,
    this.color1,
    this.color2,
    this.createByGender,

    this.empty,
  });

  final String questionID;

  final Timestamp createdAt;
  final Timestamp endsAt;
  final String createdBy;
  final List options;
  final bool revealIdentity;
  final String question;
  final int viewCount;
  final int answeredCount;
  final String color1;
  final String color2;
  final String createByGender;

  final Null empty;

  factory QuestionDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String questionID = documentID;
    final Timestamp createdAt = data['created_at'];
    final Timestamp endsAt = data['ends_at'];
    final String createdBy = data['created_by'];
    final List options = data['options'];
    final bool revealIdentity = data['reveal_identity'];
    final String question = data['question'];
    final int viewCount = data['view_count'];
    final int answeredCount = data['answered_count'];
    final String color1 = data['color1'];
    final String color2 = data['color2'];
    final String createByGender = data['create_by_gender'];

    final Null empty = data['empty'];


    return QuestionDetails(
      createdAt: createdAt,
      endsAt:endsAt,
      createdBy:createdBy,
      options:options,
      revealIdentity:revealIdentity,
      question: question,
      viewCount: viewCount,
      answeredCount:answeredCount,
      color1: color1,
      color2: color2,
      createByGender: createByGender,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      answeredCount != null ? 'answered_count': 'empty' : answeredCount,
      createdAt != null ? 'created_at': 'empty' : createdAt,
      endsAt != null ? 'ends_at': 'empty' : endsAt,
      createdBy != null ? 'created_by': 'empty' : createdBy,
      options != null ? 'options': 'empty' : options,
      question != null ? 'question': 'empty' : question,
      viewCount != null ? 'view_count': 'empty' : viewCount,
      revealIdentity != null ? 'reveal_identity': 'empty' : revealIdentity,
      color1 != null ? 'color1': 'empty' : color1,
      color2 != null ? 'color2': 'empty' : color2,
      createByGender != null ? 'create_by_gender': 'empty' : createByGender,

    };
  }
}