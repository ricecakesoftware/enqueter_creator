import 'package:enqueter_creator/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SigninViewModel> signinViewModelProvider = ChangeNotifierProvider((ref) => SigninViewModel(ref));

class SigninViewModel extends ChangeNotifier {
  ProviderReference _ref;

  String _email = '';
  String _password = '';
  String get email => _email;
  String get password => _password;

  SigninViewModel(this._ref);

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void changePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void signin() {
    _ref.watch(navigationServiceProvider).pushReplacement('/home');
  }

  void navigateSignup() {
    _ref.watch(navigationServiceProvider).push('/signup');
  }
}
