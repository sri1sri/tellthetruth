import 'firebase_common_variables.dart';

class APIPath {
  static String userDetails(String uid) => '${API_SUFFIX}users/$uid';
  static String usersList() => '${API_SUFFIX}users';

  static String gangDetails(String gangID) => '${API_SUFFIX}gangs/$gangID';
  static String gangsList() => '${API_SUFFIX}gangs';

  static String gangMembersDetails(String gangID) => '${API_SUFFIX}gangs/$gangID/members/';
  static String gangMemberDetails(String gangID, String uid) => '${API_SUFFIX}gangs/$gangID/members/$uid';

  static String questionDetails(String gangID, String questionID) => '${API_SUFFIX}gangs/$gangID/questions/$questionID';
  static String questionsList(String gangID) => '${API_SUFFIX}gangs/$gangID/questions/';

  static String myInsightDetails(String gangID, String questionID, String userID) => '${API_SUFFIX}gangs/$gangID/questions/$questionID/insights/$userID';
  static String questionInsightDetails(String gangID, String questionID) => '${API_SUFFIX}gangs/$gangID/questions/$questionID/insights/';

  static String gangNotifications(String notificationID) => 'gang_notification/$notificationID';

  static String notificationsTopicDetails(String topicID) => 'topic_/$topicID';
  static String notificationsTopicsList() => 'topic_';

  static String appProperties() => '${API_SUFFIX}common_files/properties';
  static String animationsURL() => '${API_SUFFIX}common_files/animation_file_url';

}

