import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  ProviderReference _ref;

  HomeViewModel(this._ref);

  void navigateProfileIfUnregistered() async {
    UserProfile userProfile = UserProfile();
    if (userProfile.profile == null) {
      await _ref.watch(dialogServiceProvider).showAlertDialog(
        'プロフィール未登録',
        'プロフィールが登録されていません。先にプロフィールの登録をお願いします。'
      );
      _ref.watch(navigationServiceProvider).push('/profile');
    }
  }
}
