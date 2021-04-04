import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/repositories/questionnaire_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:enqueter_creator/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  ProviderReference _ref;

  List<Questionnaire> _creatings = [];
  List<Questionnaire> get creatings => _creatings;
  List<Questionnaire> _answerings = [];
  List<Questionnaire> get answerings => _answerings;
  List<Questionnaire> _finishings = [];
  List<Questionnaire> get finishings => _finishings;

  HomeViewModel(this._ref);

  void refresh() async {
    try {
      UserProfile userProfile = UserProfile();
      await _ref.watch(dialogServiceProvider).showCircularProgressIndicatorDialog(() async {
        List<Questionnaire> creatings = await _ref.watch(questionnaireRepositoryProvider).selectByCreatedUserUidAndStatus(userProfile.user!.uid, 0);
        List<Questionnaire> openings = await _ref.watch(questionnaireRepositoryProvider).selectByCreatedUserUidAndStatus(userProfile.user!.uid, 1);
        openings.sort((q1, q2) => q1.deadline.compareTo(q2.deadline));
        _creatings.clear();
        _answerings.clear();
        _finishings.clear();
        for (Questionnaire questionnaire in creatings) {
          _creatings.add(questionnaire);
        }
        for (Questionnaire questionnaire in openings.where((q) => q.deadline.compareTo(DateTime.now()) < 0)) {
          _answerings.add(questionnaire);
        }
        for (Questionnaire questionnaire in openings.where((q) => q.deadline.compareTo(DateTime.now()) >= 0)) {
          _finishings.add(questionnaire);
        }
        notifyListeners();
      });
    } catch (e, s) {
      logger.shout(e);
      logger.shout(s);
      await _ref.watch(dialogServiceProvider).showAlertDialog('例外発生', e.toString());
    }
  }

  void navigateProfile() {
    _ref.watch(navigationServiceProvider).push('/profile');
  }

  void navigateQuestionnaire({String? id}) {
    _ref.watch(navigationServiceProvider).push('/questionnaire', args: id);
  }
}
