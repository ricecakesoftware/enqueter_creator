import 'package:enqueter_creator/data/models/profile.dart';
import 'package:enqueter_creator/data/repositories/profile_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:enqueter_creator/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<ProfileViewModel> profileViewModelProvider = ChangeNotifierProvider((ref) => ProfileViewModel(ref));

class ProfileViewModel extends ChangeNotifier {
  ProviderReference _ref;
  Profile _profile = Profile();

  String _id = '';
  String get id => _id;
  String _displayName = '';
  String get displayName => _displayName;
  int? _gender = 0;
  int? get gender => _gender;
  DateTime _birthDate = DateTime(1970, 1, 1);
  DateTime get birthDate => _birthDate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  ProfileViewModel(this._ref) {
    UserProfile userProfile = UserProfile();
    if (userProfile.profile != null) {
      _profile = userProfile.profile!;
      _id = _profile.id;
      _displayName = _profile.displayName;
      _gender = _profile.gender;
      _birthDate = _profile.birthDate;
    }
  }

  void changeDisplayName(String value) {
    _profile.displayName = value;
    _displayName = value;
    notifyListeners();
  }

  String? validateDisplayName(String? value) {
    return (value == null || value.isEmpty) ? 'ニックネームを入力してください' : null;
  }

  void changeGender(int? value) {
    _profile.gender = (value != null) ? value: 2;
    _gender = value;
    notifyListeners();
  }

  void selectBirthDate() async {
    DateTime? dateTime = await _ref.watch(dialogServiceProvider).showDatePickerDialog(_profile.birthDate);
    if (dateTime != null) {
      _profile.birthDate = dateTime;
      _birthDate = dateTime;
      notifyListeners();
    }
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserProfile userProfile = UserProfile();
        _profile.userUid = userProfile.user!.uid;
        await _ref.watch(dialogServiceProvider).showCircularProgressIndicatorDialog(() async {
          if (_profile.id.isEmpty) {
            String? id = await _ref.watch(profileRepositoryProvider).insert(_profile);
            if (id != null) {
              _profile.id = id;
            } else {
              await _ref.watch(dialogServiceProvider).showAlertDialog('エラー', 'ユーザー情報の登録に失敗しました。');
            }
          } else {
            await _ref.watch(profileRepositoryProvider).update(_profile);
          }
          userProfile.profile = _profile;
        });
        await _ref.watch(dialogServiceProvider).showAlertDialog(
            'プロフィール登録完了',
            'プロフィールが登録完了しました。'
        );
        _ref.watch(navigationServiceProvider).pop();
      } catch (e, s) {
        logger.shout(e);
        logger.shout(s);
        await _ref.watch(dialogServiceProvider).showAlertDialog('例外発生', e.toString());
      }
    }
  }
}
