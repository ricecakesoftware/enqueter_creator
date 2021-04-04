import 'package:enqueter_creator/data/models/part.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<QuestionnaireViewModel> questionnaireViewModelProvider = ChangeNotifierProvider((ref) => QuestionnaireViewModel(ref));

class QuestionnaireViewModel extends ChangeNotifier {
  ProviderReference _ref;

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

  QuestionnaireViewModel(this._ref);

  void refresh() {

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
    DateTime? dateTime = await _ref.watch(dialogServiceProvider).showDatePickerDialog(_deadline);
    if (dateTime != null) {
      _deadline = dateTime;
      notifyListeners();
    }
  }

  void navigatePart({int? index}) {
    _ref.watch(navigationServiceProvider).push('/part');
  }

  void save() {
    _ref.watch(navigationServiceProvider).pop();
  }

  void publish() {
    _ref.watch(navigationServiceProvider).pop();
  }

  void delete() {
    _ref.watch(navigationServiceProvider).pop();
  }
}
