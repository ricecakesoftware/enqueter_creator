import 'package:enqueter_creator/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SignupViewModel> signupViewModelProvider = ChangeNotifierProvider((ref) => SignupViewModel(ref));

class SignupViewModel extends ChangeNotifier {
  ProviderReference _ref;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  GlobalKey<FormState> get formKey => _formKey;
  String get email => _email;
  String get password => _password;

  SignupViewModel(this._ref);

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void changePassword(String value) {
    _password = value;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    return (value == null || value.isEmpty) ? 'メールアドレスを入力してください' : null;
  }

  String? validatePassword(String? value) {
    return (value == null || value.length < 6) ? '文字数が不足しています' : null;
  }

  String? validateConfirmPassword(String? value) {
    return (_password != value) ? 'パスワードが一致しません' : null;
  }

  void signup() {
    if (_formKey.currentState!.validate()) {
      if (!_ref.watch(navigationServiceProvider).pop()) {
        _ref.watch(navigationServiceProvider).pushReplacement('/signin');
      }
    }
  }
}
