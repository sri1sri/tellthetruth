import 'package:cloud_firestore/cloud_firestore.dart';

class InsightsDetails{
  InsightsDetails({
    this.userID,
    this.isViewed,
    this.isAnonymos,
    this.optionSelected,

    this.empty,
  });

  final String userID;

  final bool isViewed;
  final bool isAnonymos;
  final int optionSelected;


  final Null empty;

  factory InsightsDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String userID = documentID;
    final bool isViewed = data['is_viewed'];
    final bool isAnonymos = data['is_anonyous'];
    final int optionSelected = data['option_selected'];

    final Null empty = data['empty'];


    return InsightsDetails(
      isViewed: isViewed,
      isAnonymos:isAnonymos,
      optionSelected:optionSelected,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      isViewed != null ? 'is_viewed': 'empty' : isViewed,
      isAnonymos != null ? 'is_anonyous': 'empty' : isAnonymos,
      optionSelected != null ? 'option_selected': 'empty' : optionSelected,
    };
  }
}