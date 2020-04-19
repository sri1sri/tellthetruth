import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/common_files_model.dart';
import 'package:tellthetruth/database_model/insights_details.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<CommonFiles> getInsights();
  Stream<UserDetails> getUserDetails(String userId);
  Future<void> createGang(GangDetails gangDetails);
  Future<void> updateGang(GangDetails gangDetails, String gangID);
  Stream<List<GangDetails>> readGangs();
  Stream<CommonFiles> getAnimations();
  Future<void> createQuestion(QuestionDetails questionDetails, String gangID);
  Stream<List<QuestionDetails>> readQuestions(String gangID);
  Future<void> updateQuestionDetails(QuestionDetails questionDetails, String gangID, String questionID);
  Future<void> createInsights(InsightsDetails insightDetails, String gangID, String questionID);
  Stream<InsightsDetails> myInsight(String gangID, String questionID);
  Future<void> updateInsights(InsightsDetails insightDetails, String gangID, String questionID);
  Future<void> deleteQuestion(String gangID, String questionID);
  Stream<List<QuestionDetails>> deleteQuestionsList(String gangID);
  Future<void> updateAppInsights(CommonFiles commonFiles);
}

Database DBreference;

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<UserDetails> getUserDetails(String userId) => _service.documentStream(
        path: APIPath.userDetails(userId),
        builder: (data, documentId) => UserDetails.fromMap(data, documentId),
      );

  @override
  Stream<CommonFiles> getInsights() => _service.documentStream(
        path: APIPath.insights(),
        builder: (data, documentId) => CommonFiles.fromMap(data, documentId),
      );

  @override
  Stream<CommonFiles> getAnimations() => _service.documentStream(
        path: APIPath.animationsURL(),
        builder: (data, documentId) => CommonFiles.fromMap(data, documentId),
      );

  @override
  Future<void> createGang(GangDetails gangDetails) async =>
      await _service.setData(
        path: APIPath.gangDetails(DateTime.now().toString()),
        data: gangDetails.toMap(),
      );

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
        path: APIPath.questionDetails(gangID, DateTime.now().toString()),
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
      await _service.setData(
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
      await _service.deleteData(
        path: APIPath.questionDetails(gangID, questionID),
      );

  @override
  Stream<List<QuestionDetails>> deleteQuestionsList(String gangID) => _service.collectionStream(
    path: APIPath.questionsList(gangID),
    builder: (data, documentId) => QuestionDetails.fromMap(data, documentId),
    queryBuilder: (query) => query.where('delete_at', isLessThan: Timestamp.fromDate(DateTime.now())),
    );

  @override
  Future<void> updateAppInsights(CommonFiles commonFiles) async =>
      await _service.updateData(
        path: APIPath.insights(),
        data: commonFiles.toMap(),
      );
}
