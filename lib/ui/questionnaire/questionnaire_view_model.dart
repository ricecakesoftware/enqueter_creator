import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/part.dart';
import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/models/user_profile.dart';
import 'package:enqueter_creator/data/providers/user_profile_provider.dart';
import 'package:enqueter_creator/data/repositories/part_repository.dart';
import 'package:enqueter_creator/data/repositories/questionnaire_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<QuestionnaireViewModel> questionnaireViewModelProvider = ChangeNotifierProvider(
  (ref) => QuestionnaireViewModel(
    ref.read(userProfileProvider),
    ref.read(questionnaireRepositoryProvider),
    ref.read(partRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class QuestionnaireViewModel extends ChangeNotifier {
  UserProfile _userProfile;
  QuestionnaireRepository _questionnaireRepository;
  PartRepository _partRepository;
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
    this._dialogService,
    this._navigationService
  );

  void refresh() async {
    if (id.isNotEmpty) {
      Questionnaire questionnaire = await _questionnaireRepository.selectById(id);
      _title = questionnaire.title;
      _content = questionnaire.content;
      _deadline = questionnaire.deadline;
      List<Part> parts = await _partRepository.selectByQuestionnaireId(id);
      _parts.addAll(parts);
      notifyListeners();
    }
  }

  void changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  String? validateTitle(String? value) {
    return (value == null || value.isEmpty) ? 'タイトルを入力してください' : null;
  }

  void changeContent(String value) {
    _content = value;
    notifyListeners();
  }

  String? validateContent(String? value) {
    return (value == null || value.isEmpty) ? '内容を入力してください' : null;
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
      await _navigationService.push('/part', args: _parts[index].id);
    } else {
      await _navigationService.push('/part');
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
      questionnaire.status = 0;
      questionnaire.createdAt = DateTime.now();
      questionnaire.createdUserUid = _userProfile.user!.uid;
      await _dialogService.showCircularProgressIndicatorDialog(() async {
        if (id.isEmpty) {
          String? id = await _questionnaireRepository.insert(questionnaire);
          if (id != null) {
            this.id = id;
          } else {
            await _dialogService.showAlertDialog('エラー', 'アンケートの登録に失敗しました。');
          }
        } else {
          await _questionnaireRepository.update(questionnaire);
        }
      });
      await _dialogService.showAlertDialog(
          'アンケート登録完了',
          'アンケートの一時保存が完了しました。'
      );
    }
  }

  void publish() async {
    if (_formKey.currentState!.validate()) {
      DialogResult? result = await _dialogService.showYesNoDialog(
          'アンケート公開確認',
          'アンケートを公開してよろしいですか？'
      );
      if (result == DialogResult.Yes) {
        Questionnaire questionnaire = Questionnaire();
        questionnaire.id = id;
        questionnaire.title = _title;
        questionnaire.content = _content;
        questionnaire.deadline = _deadline;
        questionnaire.status = 1;
        questionnaire.createdAt = DateTime.now();
        questionnaire.createdUserUid = _userProfile.user!.uid;
        await _dialogService.showCircularProgressIndicatorDialog(() async {
          await _questionnaireRepository.update(questionnaire);
          // TODO 対応者追加
        });
        await _dialogService.showAlertDialog(
            'アンケート公開完了',
            'アンケートの公開が完了しました。'
        );
        _navigationService.pop(result: id);
      }
    }
  }

  void delete() async {
    DialogResult? result = await _dialogService.showYesNoDialog(
        'アンケート削除確認',
        'アンケートを削除してよろしいですか？'
    );
    if (result == DialogResult.Yes) {
      await _dialogService.showCircularProgressIndicatorDialog(() async {
        await _questionnaireRepository.deleteById(id);
        await _partRepository.deleteByQuestionnaireId(id);
      });
      await _dialogService.showAlertDialog(
          'アンケート削除完了',
          'アンケートの削除が完了しました。'
      );
      _navigationService.pop();
    }
  }
}
