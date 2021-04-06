import 'package:enqueter_creator/data/models/user_profile.dart';
import 'package:enqueter_creator/data/providers/auth_repository.dart';
import 'package:enqueter_creator/data/providers/user_profile_provider.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/data/repositories/profile_repository.dart';
import 'package:enqueter_creator/utils/firebase_auth_exception_helper.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SignInViewModel> signInViewModelProvider = ChangeNotifierProvider(
  (ref) => SignInViewModel(
    ref.read(userProfileProvider),
    ref.read(authProvider),
    ref.read(profileRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class SignInViewModel extends ChangeNotifier {
  UserProfile _userProfile;
  FirebaseAuth _authProvider;
  ProfileRepository _profileRepository;
  DialogService _dialogService;
  NavigationService _navigationService;

  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  SignInViewModel(this._userProfile, this._authProvider, this._profileRepository, this._dialogService, this._navigationService);

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
        await _dialogService.showCircularProgressIndicatorDialog(() async {
          final UserCredential result = await _authProvider.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          _userProfile.user = result.user!;
          _userProfile.profile = await _profileRepository.selectByUserUid(result.user!.uid);
        });
        if (_userProfile.profile == null) {
          await _dialogService.showAlertDialog(
              'プロフィール未登録',
              'プロフィールが登録されていません。先にプロフィールの登録をお願いします。'
          );
          _navigationService.pushReplacement('/profile');
        } else {
          _navigationService.pushReplacement('/home');
        }
      } on FirebaseAuthException catch (e) {
        logger.severe(e);
        await _dialogService.showAlertDialog(
          'Firebaseエラー',
          FirebaseAuthExceptionHelper.message(e.code)
        );
      } catch (e, s) {
        logger.shout(e);
        logger.shout(s);
        await _dialogService.showAlertDialog('例外発生', e.toString());
      }
    }
  }

  void navigateSignUp() {
    _navigationService.push('/sign_up');
  }
}
