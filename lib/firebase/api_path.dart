import 'firebase_common_variables.dart';

class APIPath {
  static String userDetails(String uid) => '${API_SUFFIX}users/$uid';
  static String usersList() => '${API_SUFFIX}users';
}