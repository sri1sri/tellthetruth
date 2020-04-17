
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/database_model/common_files_model.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database{

  Stream<CommonFiles> getInsights();
  Stream<UserDetails> getUserDetails();
  Future<void> createGang(GangDetails gangDetails);
  Future<void> updateGang(GangDetails gangDetails, String gangID);
  Future<void> updateInsights(CommonFiles commonFiles);
  Stream<List<GangDetails>>readGangs();
  Stream<CommonFiles> getAnimations();

}


Database DBreference;

class FirestoreDatabase implements Database {

  FirestoreDatabase({@required this.uid}) : assert (uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<UserDetails> getUserDetails() => _service.documentStream(
    path: APIPath.userDetails(uid),
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
  Future<void> createGang(GangDetails gangDetails) async => await _service.setData(
    path: APIPath.gangDetails(DateTime.now().toIso8601String()),
    data: gangDetails.toMap(),
  );

  @override
  Future<void> updateGang(GangDetails gangDetails, String gangID) async => await _service.updateData(
    path: APIPath.gangDetails(gangID),
    data: gangDetails.toMap(),
  );

  @override
  Future<void> updateInsights(CommonFiles commonFiles) async => await _service.updateData(
    path: APIPath.insights(),
    data: commonFiles.toMap(),
  );

  @override
  Stream<List<GangDetails>>readGangs() => _service.collectionStream(
    path: APIPath.gangsList(),
    builder: (data, documentId) => GangDetails.fromMap(data, documentId),
    queryBuilder: (query) => query.where('created_by', isEqualTo: USER_ID),
  );
}