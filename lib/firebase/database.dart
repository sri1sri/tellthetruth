import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/common_files_model.dart';
import 'package:tellthetruth/database_model/gang_notification_model.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/notification_topic_model.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<UserDetails> getUserDetails(String userId);
  Future<void> updateUserDetails(UserDetails userDetails, String userID);
  Future<String> createGang(GangDetails gangDetails);
  Future<void> updateGang(GangDetails gangDetails, String gangID);
  Stream<List<GangDetails>> readGangs();
  Stream<CommonFiles> getAnimations();
  Future<void> createQuestion(QuestionDetails questionDetails, String gangID);
  Stream<List<QuestionDetails>> readQuestions(String gangID);
  Future<void> updateQuestionDetails(QuestionDetails questionDetails, String gangID, String questionID);
  Stream<QuestionDetails> readSingleQuestion(String gangID, String questionID);
  Future<void> createInsights(InsightsDetails insightDetails, String gangID, String questionID);
  Stream<InsightsDetails> myInsight(String gangID, String questionID);
  Future<void> updateInsights(InsightsDetails insightDetails, String gangID, String questionID);
  Future<void> deleteQuestion(String gangID, String questionID);
  Stream<List<UserDetails>> readGangUsers(List<dynamic> usersIDS);
  Stream<List<InsightsDetails>> readQuestionsInsights(String gangID, String questionID);
  Future<void> deleteGang(String gangID);
  Future<void> deleteQuestions(String gangID);
  Future<void> deleteInsights(String gangID, String questionID);
  Stream<CommonFiles> getAppProperties();
  Future<void> createNotification(GangNotifications gangNotifications);

  Future<void> createTopic(NotificationTopic notificationTopic);
  Future<void> updateTopic(NotificationTopic notificationTopic, String topicID);
  Stream<List<NotificationTopic>> readTopic(String topicID);

}

Database  DBreference;


class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<CommonFiles> getAppProperties() => _service.documentStream(
    path: APIPath.appProperties(),
    builder: (data, documentId) => CommonFiles.fromMap(data, documentId),
  );

  @override
  Future<void> updateUserDetails(UserDetails userDetails, String userID) async =>
      await _service.updateData(
        path: APIPath.userDetails(userID),
        data: userDetails.toMap(),
      );

  @override
  Stream<UserDetails> getUserDetails(String userId) => _service.documentStream(
        path: APIPath.userDetails(userId),
        builder: (data, documentId) => UserDetails.fromMap(data, documentId),
      );

  @override
  Stream<CommonFiles> getAnimations() => _service.documentStream(
        path: APIPath.animationsURL(),
        builder: (data, documentId) => CommonFiles.fromMap(data, documentId),
      );

  @override
  Future<String> createGang(GangDetails gangDetails) async {
    return await _service.setData(
      path: APIPath.gangsList(),
      data: gangDetails.toMap(),
    );
  }

  @override
  Future<void> updateGang(GangDetails gangDetails, String gangID) async =>
      await _service.updateData(
        path: APIPath.gangDetails(gangID),
        data: gangDetails.toMap(),
      );

  @override
  Stream<List<GangDetails>> readGangs() => _service.collectionStream(
        path: APIPath.gangsList(),
        builder: (data, documentId) => GangDetails.fromMap(data, documentId),
        queryBuilder: (query) =>
            query.where('gang_user_ids', arrayContains: USER_ID),
      );

  @override
  Future<void> createQuestion(
          QuestionDetails questionDetails, String gangID) async =>
      await _service.setData(
        path: APIPath.questionsList(gangID),
        data: questionDetails.toMap(),
      );

  @override
  Stream<List<QuestionDetails>> readQuestions(String gangID) =>
      _service.collectionStream(
        path: APIPath.questionsList(gangID),
        builder: (data, documentId) =>
            QuestionDetails.fromMap(data, documentId),
      );

  @override
  Stream<QuestionDetails> readSingleQuestion(String gangID, String questionID) =>
      _service.documentStream(
        path: APIPath.questionDetails(gangID, questionID),
        builder: (data, documentId) =>
            QuestionDetails.fromMap(data, documentId),
      );

  @override
  Stream<InsightsDetails> myInsight(String gangID, String questionID) =>
      _service.documentStream(
        path: APIPath.myInsightDetails(gangID, questionID, USER_ID),
        builder: (data, documentId) =>
            InsightsDetails.fromMap(data, documentId),
      );

  @override
  Future<void> updateQuestionDetails(QuestionDetails questionDetails,
          String gangID, String questionID) async =>
      await _service.updateData(
        path: APIPath.questionDetails(gangID, questionID),
        data: questionDetails.toMap(),
      );

  @override
  Future<void> createInsights(
      InsightsDetails insightDetails, String gangID, String questionID) async =>
      await _service.setDataWithID(
        path: APIPath.myInsightDetails(gangID, questionID, USER_ID),
        data: insightDetails.toMap(),
      );

  @override
  Future<void> updateInsights(InsightsDetails insightDetails, String gangID, String questionID) async =>
      await _service.updateData(
        path: APIPath.myInsightDetails(gangID, questionID, USER_ID),
        data: insightDetails.toMap(),
      );

  @override
  Future<void> deleteQuestion(
      String gangID, String questionID) async =>
      await _service.deleteDocument(
        path: APIPath.questionDetails(gangID, questionID),
      );

  @override
  Future<void> deleteGang(String gangID) async =>
      await _service.deleteDocument(
        path: APIPath.gangDetails(gangID),
      );
  @override
  Future<void> deleteQuestions(String gangID) async =>
      await _service.deleteCollection(
        path: APIPath.questionsList(gangID),
      );

  @override
  Future<void> deleteInsights(String gangID, String questionID) async =>
      await _service.deleteCollection(
        path: APIPath.questionInsightDetails(gangID, questionID),
      );

  @override
  Stream<List<UserDetails>> readGangUsers(List<dynamic> usersIDS) => _service.collectionStream(
    path: APIPath.usersList(),
    builder: (data, documentId) => UserDetails.fromMap(data, documentId),
    queryBuilder: (query) =>
        query.where('user_id', whereIn: usersIDS),
  );

  @override
  Stream<List<InsightsDetails>> readQuestionsInsights(String gangID, String questionID) => _service.collectionStream(
    path: APIPath.questionInsightDetails(gangID, questionID),
    builder: (data, documentId) => InsightsDetails.fromMap(data, documentId),
    queryBuilder: (query) => query.where('is_anonymous', isEqualTo: false),
  );

  @override
  Future<void> createNotification(GangNotifications gangNotifications) async =>
      await _service.setData(
        path: APIPath.gangNotificationsList(),
        data: gangNotifications.toMap(),
      );

  @override
  Future<void> createTopic(NotificationTopic notificationTopic) async =>
      await _service.setData(
        path: APIPath.notificationsTopicsList(),
        data: notificationTopic.toMap(),
      );

  @override
  Future<void> updateTopic(NotificationTopic notificationTopic, String topicID) async =>
      await _service.updateData(
        path: APIPath.notificationsTopicDetails(topicID),
        data: notificationTopic.toMap(),
      );

  @override
  Stream<List<NotificationTopic>> readTopic(String topicID) => _service.collectionStream(
    path: APIPath.notificationsTopicsList(),
    builder: (data, documentId) => NotificationTopic.fromMap(data, documentId),
    queryBuilder: (query) => query.where('topic', isEqualTo: topicID),
  );

}
