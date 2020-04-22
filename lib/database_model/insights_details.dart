import 'package:cloud_firestore/cloud_firestore.dart';

class InsightsDetails{
  InsightsDetails({
    this.userID,
    this.isViewed,
    this.isAnonymous,
    this.isReported,
    this.optionSelected,


    this.empty,
  });

  final String userID;

  final bool isViewed;
  final bool isAnonymous;
  final int optionSelected;
  final bool isReported;


  final Null empty;

  factory InsightsDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String userID = documentID;
    final bool isViewed = data['is_viewed'];
    final bool isAnonymous = data['is_anonymous'];
    final int optionSelected = data['option_selected'];

    final Null empty = data['empty'];


    return InsightsDetails(
      userID: userID,
      isViewed: isViewed,
      isAnonymous:isAnonymous,
      optionSelected:optionSelected,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      isViewed != null ? 'is_viewed': 'empty' : isViewed,
      isAnonymous != null ? 'is_anonymous': 'empty' : isAnonymous,
      optionSelected != null ? 'option_selected': 'empty' : optionSelected,
    };
  }
}