import 'package:cloud_firestore/cloud_firestore.dart';

class GangDetails{
  GangDetails({
    this.gangID,
    this.gangName,
    this.gangCode,
    this.gangIconURL,
    this.createBy,
    this.createdAt,
    this.gangUserIDS,

    this.empty,
  });

  final String gangID;
  final String gangName;
  final int gangCode;
  final String gangIconURL;
  final String createBy;
  final Timestamp createdAt;
  final List<String> gangUserIDS;

  final Null empty;

  factory GangDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String gangID = documentID;


    final String gangName = data['gang_name'];
    final int gangCode = data['gang_code'];
    final String gangIconURL = data['gang_icon_url'];
    final String createdBy = data['created_by'];
    final Timestamp createdAt = data['created_at'];
    final List<String> gangUserIDS = data['gang_user_ids'];

    final Null empty = data['empty'];


    return GangDetails(
      gangID: gangID,
      gangName:gangName,
      gangCode:gangCode,
      gangIconURL:gangIconURL,
      createBy: createdBy,
      createdAt: createdAt,
      gangUserIDS: gangUserIDS,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      gangName != null ? 'gang_name': 'empty' : gangName,
      gangCode != null ? 'gang_code': 'empty' : gangCode,
      gangIconURL != null ? 'gang_icon_url': 'empty' : gangIconURL,
      createBy != null ? 'created_by': 'empty' : createBy,
      createdAt != null ? 'created_at': 'empty' : createdAt,
      gangUserIDS != null ? 'gang_user_ids': 'empty' : gangUserIDS,

    };
  }
}