
import 'package:flutter/cupertino.dart';
import 'package:tellthetruth/firebase/auth.dart';
import 'package:tellthetruth/model/validators.dart';

class RegisterAccountPageModel with RegisterAccountValidator, ChangeNotifier {
  RegisterAccountPageModel({
    @required this.auth,

    this.email = '',
    this.password = '',
    this.username = '',
    this.isLoading = false ,
    this.submitted = false
  });

  final AuthBase auth;

  String email;
  String password;
  String username;
  bool isLoading;
  bool submitted;

  Future <void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      await auth.registerWithEmail(this.email, this.password);
      print('email --> ${this.email + this.password}');

    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateUsername(String username) => updateWith(username: username);

  bool get canSubmit{
    return emailValidator.isValid(email)
        && passwordValidator.isValid(password)
        && usernameValidator.isValid(username)
        && !isLoading;
  }

  String get usernameErrorText {
    bool showErrorText = submitted && !usernameValidator.isValid(username);
    return showErrorText ? invalidUsernameErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  void updateWith({
    String email,
    String password,
    String username,
    bool isLoading,
    bool submitted,

  }) {

    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.username = username ?? this.username;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;

    notifyListeners();
  }
}