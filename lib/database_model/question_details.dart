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

    this.empty,
  });

  final String questionID;

  final Timestamp createdAt;
  final Timestamp endsAt;
  final String createdBy;
  final List<String> options;
  final bool revealIdentity;
  final String question;
  final int viewCount;
  final int answeredCount;

  final Null empty;

  factory QuestionDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String questionID = documentID;
    final Timestamp createdAt = data['created_at'];
    final Timestamp endsAt = data['ends_at'];
    final String createdBy = data['created_by'];
    final List<String> options = data['options'];
    final bool revealIdentity = data['reveal_identity'];
    final String question = data['question'];
    final int viewCount = data['view_count'];
    final int answeredCount = data['answered_count'];

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
    };
  }
}