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
    this.gangNotificationToken,

    this.empty,
  });

  final String gangID;
  final String gangName;
  final String gangCode;
  final String gangIconURL;
  final String createBy;
  final Timestamp createdAt;
  final String gangNotificationToken;
  final List<dynamic> gangUserIDS;

  final Null empty;

  factory GangDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String gangID = documentID;


    final String gangName = data['gang_name'];
    final String gangCode = data['gang_code'];
    final String gangIconURL = data['gang_icon_url'];
    final String createdBy = data['created_by'];
    final Timestamp createdAt = data['created_at'];
    final List<dynamic> gangUserIDS = data['gang_user_ids'];
    final String gangNotificationToken = data['gang_notification_token'];

    final Null empty = data['empty'];


    return GangDetails(
      gangID: gangID,
      gangName:gangName,
      gangCode:gangCode,
      gangIconURL:gangIconURL,
      createBy: createdBy,
      createdAt: createdAt,
      gangUserIDS: gangUserIDS,
      gangNotificationToken: gangNotificationToken,
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
      gangNotificationToken != null ? 'gang_notification_token': 'empty' : gangNotificationToken,
    };
  }
}