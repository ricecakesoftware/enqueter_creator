import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/models/user_profile.dart';
import 'package:enqueter_creator/data/providers/user_profile_provider.dart';
import 'package:enqueter_creator/data/repositories/questionnaire_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:enqueter_creator/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider = ChangeNotifierProvider(
  (ref) => HomeViewModel(
    ref.read(userProfileProvider),
    ref.read(questionnaireRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class HomeViewModel extends ChangeNotifier {
  UserProfile _userProfile;
  QuestionnaireRepository _questionnaireRepository;
  DialogService _dialogService;
  NavigationService _navigationService;

  List<Questionnaire> _creatings = [];
  List<Questionnaire> get creatings => _creatings;
  List<Questionnaire> _answerings = [];
  List<Questionnaire> get answerings => _answerings;
  List<Questionnaire> _finishings = [];
  List<Questionnaire> get finishings => _finishings;

  HomeViewModel(this._userProfile, this._questionnaireRepository, this._dialogService, this._navigationService);

  void refresh() async {
    try {
      await _dialogService.showCircularProgressIndicatorDialog(() async {
        String userUid = _userProfile.user!.uid;
        List<Questionnaire> creatings = await _questionnaireRepository.selectByCreatedUserUidAndStatus(userUid, QuestionnaireStatus.Creating);
        List<Questionnaire> openings = await _questionnaireRepository.selectByCreatedUserUidAndStatus(userUid, QuestionnaireStatus.Published);
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
      await _dialogService.showAlertDialog('例外発生', e.toString());
    }
  }

  void navigateProfile() async {
    await _navigationService.push('/profile');
  }

  void navigateQuestionnaire({String? id}) async {
    await _navigationService.push('/questionnaire', args: id);
    refresh();
  }
}
