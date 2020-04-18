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
    this.optionFour,
    this.optionThree,
    this.optionTwo,
    this.optionOne,
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
  final String color1;
  final String color2;
  final String createByGender;

  final int optionOne;
  final int optionTwo;
  final int optionThree;
  final int optionFour;


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
    final int optionOne = data['option_one_count'];
    final int optionTwo = data['option_two_count'];
    final int optionThree = data['option_three_count'];
    final int optionFour = data['option_four_count'];

    final String color1 = data['color1'];
    final String color2 = data['color2'];
    final String createByGender = data['create_by_gender'];

    final Null empty = data['empty'];


    return QuestionDetails(
      questionID: questionID,
      createdAt: createdAt,
      endsAt:endsAt,
      createdBy:createdBy,
      options:options,
      revealIdentity:revealIdentity,
      question: question,
      viewCount: viewCount,
      optionOne:optionOne,
      optionFour: optionFour,
      optionThree: optionThree,
      optionTwo: optionTwo,
      color1: color1,
      color2: color2,
      createByGender: createByGender,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      optionOne != null ? 'option_one_count': 'empty' : optionOne,
      optionTwo != null ? 'option_two_count': 'empty' : optionTwo,
      optionThree != null ? 'option_three_count': 'empty' : optionThree,
      optionFour != null ? 'option_four_count': 'empty' : optionFour,
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