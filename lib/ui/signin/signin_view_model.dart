import 'package:enqueter_creator/utils/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logger.dart';

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

  void signin() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(email: _email, password: _password);
      final User user = result.user!;
      _ref.watch(navigationServiceProvider).pushReplacement('/home', args: user);
    } catch (e) {
      logger.severe(e);
    }
  }

  void navigateSignup() {
    _ref.watch(navigationServiceProvider).push('/signup');
  }
}
