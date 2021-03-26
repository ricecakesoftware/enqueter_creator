import 'package:enqueter_creator/data/models/profile.dart';
import 'package:enqueter_creator/data/repositories/profile_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<ProfileViewModel> profileViewModelProvider = ChangeNotifierProvider((ref) => ProfileViewModel(ref));

class ProfileViewModel extends ChangeNotifier {
  ProviderReference _ref;
  Profile _profile = new Profile();
  Profile get profile => _profile;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  ProfileViewModel(this._ref) {
    UserProfile userProfile = UserProfile();
    if (userProfile.profile != null) {
      _profile = userProfile.profile!;
    }
  }

  void changeDisplayName(String value) {
    _profile.displayName = value;
  }

  String? validateDisplayName(String? value) {
    return (value == null || value.isEmpty) ? 'ニックネームを入力してください' : null;
  }

  void changeGender(int? value) {
    _profile.gender = (value != null) ? value: 2;
  }

  void selectBirthDate() async {
    DateTime? dateTime = await _ref.watch(dialogServiceProvider).showDatePickerDialog(_profile.birthDate);
    if (dateTime != null) {
      _profile.birthDate = dateTime;
    }
  }

  Future<void> register() async {
    UserProfile userProfile = UserProfile();
    _profile.userUid = userProfile.user!.uid;
    if (_profile.id.isEmpty) {
      String? id = await _ref.watch(profileRepositoryProvider).insert(_profile);
      if (id != null) {
        _profile.id = id;
      } else {
        await _ref.watch(dialogServiceProvider).showAlertDialog('エラー', 'ユーザー情報の登録に失敗しました。');
      }
    } else {
      _ref.watch(profileRepositoryProvider).update(_profile);
    }
    userProfile.profile = _profile;
  }
}
