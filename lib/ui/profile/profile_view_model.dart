import 'package:enqueter_creator/data/models/profile.dart';
import 'package:enqueter_creator/data/models/user_profile.dart';
import 'package:enqueter_creator/data/providers/user_profile_provider.dart';
import 'package:enqueter_creator/data/repositories/profile_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<ProfileViewModel> profileViewModelProvider = ChangeNotifierProvider(
  (ref) => ProfileViewModel(
    ref.read(userProfileProvider),
    ref.read(profileRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class ProfileViewModel extends ChangeNotifier {
  UserProfile _userProfile;
  ProfileRepository _profileRepository;
  DialogService _dialogService;
  NavigationService _navigationService;

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

  ProfileViewModel(this._userProfile, this._profileRepository, this._dialogService, this._navigationService) {
    Profile? profile = _userProfile.profile;
    if (profile != null) {
      _id = profile.id;
      _displayName = profile.displayName;
      _gender = profile.gender;
      _birthDate = profile.birthDate;
    }
  }

  void changeDisplayName(String value) {
    _displayName = value;
    notifyListeners();
  }

  String? validateDisplayName(String? value) {
    return (value == null || value.isEmpty) ? 'ニックネームを入力してください' : null;
  }

  void changeGender(int? value) {
    _gender = value;
    notifyListeners();
  }

  void selectBirthDate() async {
    DateTime? dateTime = await _dialogService.showDatePickerDialog(_birthDate);
    if (dateTime != null) {
      _birthDate = dateTime;
      notifyListeners();
    }
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      try {
        Profile profile = Profile();
        profile.id = _id;
        profile.userUid = _userProfile.user!.uid;
        profile.displayName = _displayName;
        profile.gender = (_gender == null) ? 2 : _gender!;
        profile.birthDate = _birthDate;
        await _dialogService.showCircularProgressIndicatorDialog(() async {
          if (_id.isEmpty) {
            String? id = await _profileRepository.insert(profile);
            if (id != null) {
              profile.id = id;
            } else {
              await _dialogService.showAlertDialog('エラー', 'プロフィールの登録に失敗しました。');
            }
          } else {
            await _profileRepository.update(profile);
          }
          _userProfile.profile = profile;
        });
        await _dialogService.showAlertDialog(
            'プロフィール登録完了',
            'プロフィールの登録が完了しました。'
        );
        _navigationService.pop();
      } catch (e, s) {
        logger.shout(e);
        logger.shout(s);
        await _dialogService.showAlertDialog('例外発生', e.toString());
      }
    }
  }
}
