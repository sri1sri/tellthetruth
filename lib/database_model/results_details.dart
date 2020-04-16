import 'package:cloud_firestore/cloud_firestore.dart';

class ResultsDetails{
  ResultsDetails({
this.isViewed,
    this.revealedIdentity,
    this.selectedOption,
    this.userID,

    this.empty,
  });

  final String userID;
  final bool isViewed;
  final int selectedOption;
  final bool revealedIdentity;

  final Null empty;

  factory ResultsDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String userID = documentID;


    final bool isViewed = data['is_viewed'];
    final int selectedOption = data['selected_option'];
    final bool revealedIdentity = data['revealed_identity'];

    final Null empty = data['empty'];


    return ResultsDetails(
      userID: userID,
      isViewed:isViewed,
      selectedOption:selectedOption,
      revealedIdentity:revealedIdentity,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      isViewed != null ? 'is_viewed': 'empty' : isViewed,
      selectedOption != null ? 'selected_option': 'empty' : selectedOption,
      revealedIdentity != null ? 'revealed_identity': 'empty' : revealedIdentity,
    };
  }
}