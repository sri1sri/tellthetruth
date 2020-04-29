import 'package:cloud_firestore/cloud_firestore.dart';
class UserDetails{
  UserDetails({
    this.username,
    this.gender,
    this.joinedDate,
    this.userID,
    this.emailID,
    this.password,
    this.dateOfBirth,
    this.deviceToken,
    this.empty,

  });

  final String username;
  final String gender;
  final Timestamp joinedDate;
  final String userID;
  final String emailID;
  final String password;
  final String deviceToken;
  final Timestamp dateOfBirth;
  final Null empty;



  factory UserDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }
    final String userID = data['user_id'];

    final String username = data['username'];
    final String gender = data['gender'];
    final Timestamp dateOfBirth = data['date_of_birth'];
    final Timestamp joinedDate = data['join_date'];
    final String emailID = data['email_id'];
    final String password = data['password'];
    final String deviceToken = data['device_token'];
    final Null empty = data['empty'];


    return UserDetails(
      username: username,
      gender: gender,
      dateOfBirth: dateOfBirth,
      joinedDate: joinedDate,
      userID: userID,
      emailID: emailID,
      password: password,
      deviceToken: deviceToken,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      userID != null ? 'user_id': 'empty' : userID,
      username != null ? 'username': 'empty' : username,
      gender != null ? 'gender': 'empty' : gender,
      dateOfBirth != null ? 'date_of_birth': 'empty' : dateOfBirth,
      joinedDate != null ? 'join_date': 'empty' : joinedDate,
      emailID != null ? 'email_id':'empty' :  emailID,
      password != null ? 'password':'empty' :  password,
      deviceToken != null ? 'device_token':'empty' :  deviceToken,

    };
  }

}