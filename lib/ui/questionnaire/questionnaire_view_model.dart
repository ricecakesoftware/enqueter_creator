import 'package:enqueter_creator/data/models/part.dart';
import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/repositories/part_repository.dart';
import 'package:enqueter_creator/data/repositories/questionnaire_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<QuestionnaireViewModel> questionnaireViewModelProvider = ChangeNotifierProvider(
  (ref) => QuestionnaireViewModel(
    ref.read(questionnaireRepositoryProvider),
    ref.read(partRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class QuestionnaireViewModel extends ChangeNotifier {
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
    this._questionnaireRepository,
    this._partRepository,
    this._dialogService,
    this._navigationService);

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

  void navigatePart({int? index}) {
    if (index != null) {
      _navigationService.push('/part', args: _parts[index].id);
    } else {
      _navigationService.push('/part');
    }
  }

  void save() {
    _navigationService.pop();
  }

  void publish() {
    _navigationService.pop();
  }

  void delete() {
    _navigationService.pop();
  }
}
