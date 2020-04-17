import 'firebase_common_variables.dart';

class APIPath {
  static String userDetails(String uid) => '${API_SUFFIX}users/$uid';
  static String usersList() => '${API_SUFFIX}users';

  static String gangDetails(String gangID) => '${API_SUFFIX}gangs/$gangID';
  static String gangsList() => '${API_SUFFIX}gangs';

  static String questionDetails(String gangID, String questionID) => '${API_SUFFIX}gangs/$gangID/questions/$questionID';
  static String questionsList(String gangID) => '${API_SUFFIX}gangs/$gangID/questions/';

  static String insights() => '${API_SUFFIX}common_files/insights';
  static String animationsURL() => '${API_SUFFIX}common_files/animation_file_url';

}

