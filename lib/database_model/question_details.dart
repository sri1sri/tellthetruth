import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionDetails{
  QuestionDetails({
    this.questionID,
    this.createdAt,
    this.createdBy,
    this.deleteAt,
    this.options,
    this.viewedBy,
    this.isAnonymous,
    this.endsAt,
//    this.viewCount,
    this.optionFourPolledCount,
    this.optionThreePolledCount,
    this.optionTwoPolledCount,
    this.optionOnePolledCount,
    this.question,
    this.color1,
    this.color2,
    this.createByGender,
    this.createdByUsername,

    this.empty,
  });

  final String questionID;

  final Timestamp createdAt;
  final Timestamp endsAt;
  final Timestamp deleteAt;
  final String createdBy;
  final List options;
  final List<dynamic> viewedBy;
  final bool isAnonymous;
  final String question;
//  final int viewCount;
  final String color1;
  final String color2;
  final String createByGender;
  final String createdByUsername;

  final int optionOnePolledCount;
  final int optionTwoPolledCount;
  final int optionThreePolledCount;
  final int optionFourPolledCount;


  final Null empty;

  factory QuestionDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String questionID = documentID;
    final Timestamp createdAt = data['created_at'];
    final Timestamp endsAt = data['ends_at'];
    final Timestamp deleteAt = data['delete_at'];
    final String createdBy = data['created_by'];
    final List options = data['options'];
    final List<dynamic> viewedBy = data['viewed_by'];
    final bool isAnonymous = data['is_anonymous'];
    final String question = data['question'];
//    final int viewCount = data['view_count'];
    final int optionOne = data['option_one_count'];
    final int optionTwo = data['option_two_count'];
    final int optionThree = data['option_three_count'];
    final int optionFour = data['option_four_count'];
    final String createdByUsername = data['created_by_username'];
    final String color1 = data['color1'];
    final String color2 = data['color2'];
    final String createByGender = data['create_by_gender'];

    final Null empty = data['empty'];


    return QuestionDetails(
      questionID: questionID,
      createdAt: createdAt,
      deleteAt: deleteAt,
      endsAt:endsAt,
      createdBy:createdBy,
      options:options,
      isAnonymous:isAnonymous,
      question: question,
      viewedBy: viewedBy,
//      viewCount: viewCount,
      optionOnePolledCount:optionOne,
      optionFourPolledCount: optionFour,
      optionThreePolledCount: optionThree,
      optionTwoPolledCount: optionTwo,
      color1: color1,
      color2: color2,
      createByGender: createByGender,
      createdByUsername: createdByUsername,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      optionOnePolledCount != null ? 'option_one_count': 'empty' : optionOnePolledCount,
      optionTwoPolledCount != null ? 'option_two_count': 'empty' : optionTwoPolledCount,
      optionThreePolledCount != null ? 'option_three_count': 'empty' : optionThreePolledCount,
      optionFourPolledCount != null ? 'option_four_count': 'empty' : optionFourPolledCount,
      createdAt != null ? 'created_at': 'empty' : createdAt,
      deleteAt != null ? 'delete_at': 'empty' : deleteAt,
      createdByUsername != null ? 'created_by_username': 'empty' : createdByUsername,
      viewedBy != null ? 'viewed_by': 'empty' : viewedBy,
      endsAt != null ? 'ends_at': 'empty' : endsAt,
      createdBy != null ? 'created_by': 'empty' : createdBy,
      options != null ? 'options': 'empty' : options,
      question != null ? 'question': 'empty' : question,
//      viewCount != null ? 'view_count': 'empty' : viewCount,
      isAnonymous != null ? 'is_anonymous': 'empty' : isAnonymous,
      color1 != null ? 'color1': 'empty' : color1,
      color2 != null ? 'color2': 'empty' : color2,
      createByGender != null ? 'create_by_gender': 'empty' : createByGender,

    };
  }
}