import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/part.dart';
import 'package:enqueter_creator/data/models/profile.dart';
import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/models/responder.dart';
import 'package:enqueter_creator/data/models/user_profile.dart';
import 'package:enqueter_creator/data/providers/user_profile_provider.dart';
import 'package:enqueter_creator/data/repositories/part_repository.dart';
import 'package:enqueter_creator/data/repositories/profile_repository.dart';
import 'package:enqueter_creator/data/repositories/questionnaire_repository.dart';
import 'package:enqueter_creator/data/repositories/responder_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<QuestionnaireViewModel> questionnaireViewModelProvider = ChangeNotifierProvider(
  (ref) => QuestionnaireViewModel(
    ref.read(userProfileProvider),
    ref.read(questionnaireRepositoryProvider),
    ref.read(partRepositoryProvider),
    ref.read(profileRepositoryProvider),
    ref.read(responderRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class QuestionnaireViewModel extends ChangeNotifier {
  UserProfile _userProfile;
  QuestionnaireRepository _questionnaireRepository;
  PartRepository _partRepository;
  ProfileRepository _profileRepository;
  ResponderRepository _responderRepository;
  DialogService _dialogService;
  NavigationService _navigationService;

  String _title = '';
  String get title => _title;
  String _content = '';
  String get content => _content;
  DateTime _deadline = DateTime.now().add(Duration(days: 30));
  DateTime get deadline => _deadline;
  List<Part> _parts = [];
  List<Part> get parts => _parts;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String id = '';

  QuestionnaireViewModel(
    this._userProfile,
    this._questionnaireRepository,
    this._partRepository,
    this._profileRepository,
    this._responderRepository,
    this._dialogService,
    this._navigationService
  );

  void refresh() async {
    await _dialogService.showCircularProgressIndicatorDialog(() async {
      if (id.isNotEmpty) {
        Questionnaire questionnaire = await _questionnaireRepository.selectById(
            id);
        _title = questionnaire.title;
        _content = questionnaire.content;
        _deadline = questionnaire.deadline;
        _parts.clear();
        List<Part> parts = await _partRepository.selectByQuestionnaireId(id);
        _parts.addAll(parts);
      } else {
        _title = '';
        _content = '';
        _deadline = DateTime.now().add(Duration(days: 30));
        _parts.clear();
      }
      notifyListeners();
    });
  }

  void changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  String? validateTitle(String? value) {
    return (value == null || value.isEmpty) ? '???????????????????????????????????????' : null;
  }

  void changeContent(String value) {
    _content = value;
    notifyListeners();
  }

  String? validateContent(String? value) {
    return (value == null || value.isEmpty) ? '?????????????????????????????????' : null;
  }

  void selectDeadline() async {
    DateTime? dateTime = await _dialogService.showDatePickerDialog(_deadline);
    if (dateTime != null) {
      _deadline = dateTime;
      notifyListeners();
    }
  }

  void navigatePart({int? index}) async {
    if (index != null) {
      await _navigationService.push('/part', args: [id, _parts[index].id]);
    } else {
      await _navigationService.push('/part', args: [id, '']);
    }
    refresh();
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      Questionnaire questionnaire = Questionnaire();
      questionnaire.id = id;
      questionnaire.title = _title;
      questionnaire.content = _content;
      questionnaire.deadline = _deadline;
      questionnaire.status = QuestionnaireStatus.Creating;
      questionnaire.createdAt = DateTime.now();
      questionnaire.createdUserUid = _userProfile.user!.uid;
      await _dialogService.showCircularProgressIndicatorDialog(() async {
        if (id.isEmpty) {
          String? id = await _questionnaireRepository.insert(questionnaire);
          if (id != null) {
            this.id = id;
          } else {
            await _dialogService.showAlertDialog('?????????', '????????????????????????????????????????????????');
          }
        } else {
          await _questionnaireRepository.update(questionnaire);
        }
      });
      await _dialogService.showAlertDialog(
          '???????????????????????????',
          '??????????????????????????????????????????????????????'
      );
    }
  }

  void publish() async {
    if (_formKey.currentState!.validate()) {
      DialogResult? result = await _dialogService.showYesNoDialog(
          '???????????????????????????',
          '??????????????????????????????????????????????????????'
      );
      if (result == DialogResult.Yes) {
        Questionnaire questionnaire = Questionnaire();
        questionnaire.id = id;
        questionnaire.title = _title;
        questionnaire.content = _content;
        questionnaire.deadline = _deadline;
        questionnaire.status = QuestionnaireStatus.Published;
        questionnaire.createdAt = DateTime.now();
        questionnaire.createdUserUid = _userProfile.user!.uid;
        await _dialogService.showCircularProgressIndicatorDialog(() async {
          await _questionnaireRepository.update(questionnaire);
          List<Profile> profiles = await _profileRepository.selectAll();
          for (Profile profile in profiles) {
            Responder responder = Responder();
            responder.profileId = profile.id;
            responder.status = ResponderStatus.NotAnswering;
            await _responderRepository.insert(responder);
          }
        });
        await _dialogService.showAlertDialog(
            '???????????????????????????',
            '????????????????????????????????????????????????'
        );
        _navigationService.pop(result: id);
      }
    }
  }

  void delete() async {
    DialogResult? result = await _dialogService.showYesNoDialog(
        '???????????????????????????',
        '??????????????????????????????????????????????????????'
    );
    if (result == DialogResult.Yes) {
      await _dialogService.showCircularProgressIndicatorDialog(() async {
        await _questionnaireRepository.deleteById(id);
        await _partRepository.deleteByQuestionnaireId(id);
      });
      await _dialogService.showAlertDialog(
          '???????????????????????????',
          '????????????????????????????????????????????????'
      );
      _navigationService.pop();
    }
  }
}
