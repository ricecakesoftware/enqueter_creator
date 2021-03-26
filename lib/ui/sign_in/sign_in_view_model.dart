import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/data/repositories/profile_repository.dart';
import 'package:enqueter_creator/utils/firebase_auth_exception_helper.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:enqueter_creator/utils/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SignInViewModel> signInViewModelProvider = ChangeNotifierProvider((ref) => SignInViewModel(ref));

class SignInViewModel extends ChangeNotifier {
  ProviderReference _ref;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  GlobalKey<FormState> get formKey => _formKey;
  String get email => _email;
  String get password => _password;

  SignInViewModel(this._ref);

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

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _ref.watch(dialogServiceProvider).showCircularProgressIndicatorDialog(() async {
          final FirebaseAuth auth = FirebaseAuth.instance;
          final UserCredential result = await auth.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          UserProfile userProfile = UserProfile();
          userProfile.user = result.user!;
          userProfile.profile = await _ref.watch(profileRepositoryProvider).selectByUserUid(result.user!.uid);
        });
        _ref.watch(navigationServiceProvider).pushReplacement('/home');
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

  void navigateSignUp() {
    _ref.watch(navigationServiceProvider).push('/sign_up');
  }
}
