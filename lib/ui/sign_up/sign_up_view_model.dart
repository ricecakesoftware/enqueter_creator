import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/utils/firebase_auth_exception_helper.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SignUpViewModel> signUpViewModelProvider = ChangeNotifierProvider((ref) => SignUpViewModel(ref));

class SignUpViewModel extends ChangeNotifier {
  ProviderReference _ref;

  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  SignUpViewModel(this._ref);

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

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _ref.watch(dialogServiceProvider).showCircularProgressIndicatorDialog(() async {
          final FirebaseAuth auth = FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        });
        await _ref.watch(dialogServiceProvider).showAlertDialog('完了', 'Sign Upが完了しました。');
        _ref.watch(navigationServiceProvider).pop();
      } on FirebaseAuthException catch (e) {
        logger.severe(e);
        await _ref.watch(dialogServiceProvider).showAlertDialog(
          'Firebaseエラー',
          FirebaseAuthExceptionHelper.message(e.code)
        );
      } catch (e, s) {
        logger.shout(e);
        logger.shout(s);
        await _ref.watch(dialogServiceProvider).showAlertDialog('例外発生', e.toString());
      }
    }
  }
}
