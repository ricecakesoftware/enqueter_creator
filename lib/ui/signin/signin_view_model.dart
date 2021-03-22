import 'package:enqueter_creator/utils/dialog_service.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:enqueter_creator/utils/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SigninViewModel> signinViewModelProvider = ChangeNotifierProvider((ref) => SigninViewModel(ref));

class SigninViewModel extends ChangeNotifier {
  ProviderReference _ref;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  GlobalKey<FormState> get formKey => _formKey;
  String get email => _email;
  String get password => _password;

  SigninViewModel(this._ref);

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    return (value == null || value.isEmpty) ? 'メールアドレスを入力してください' : null;
  }

  void changePassword(String value) {
    _password = value;
    notifyListeners();
  }

  String? validatePassword(String? value) {
    return (value == null || value.isEmpty) ? 'パスワードを入力してください' : null;
  }

  void signin() async {
    if (_formKey.currentState!.validate()) {
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final UserCredential result = await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        final User user = result.user!;
        _ref.watch(navigationServiceProvider).pushReplacement(
            '/home', args: user);
      } catch (e) {
        logger.severe(e);
        _ref.watch(dialogServiceProvider).showAlertDialog(
            'error', e.toString());
      }
    }
  }

  void navigateSignup() {
    _ref.watch(navigationServiceProvider).push('/signup');
  }
}
