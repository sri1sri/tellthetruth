import 'firebase_common_variables.dart';

class APIPath {
  static String userDetails(String uid) => '${API_SUFFIX}users/$uid';
  static String usersList() => '${API_SUFFIX}users';

  static String gangDetails(String gangID) => '${API_SUFFIX}gangs/$gangID';
  static String gangsList() => '${API_SUFFIX}gangs';

  static String insights() => '${API_SUFFIX}common_files/insights';
}