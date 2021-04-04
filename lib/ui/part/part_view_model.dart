import 'package:enqueter_creator/data/models/question.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<PartViewModel> partViewModelProvider = ChangeNotifierProvider((ref) => PartViewModel(ref));

class PartViewModel extends ChangeNotifier {
  ProviderReference _ref;

  String _text = '';
  String get text => _text;
  int _type = 0;
  int get type => _type;
  List<Question> _questions = [];
  List<Question> get questions => _questions;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  PartViewModel(this._ref);

  void changeText(String value) {
    _text = value;
    notifyListeners();
  }

  String? validateText(String? value) {
    return (value == null || value.isEmpty) ? 'テキストを入力してください' : null;
  }

  void changeType(int? value) {
    if (value != null) {
      _type = value;
      notifyListeners();
    }
  }

  void changeQuestionText(int index, String value) {
    _questions[index].text = value;
    notifyListeners();
  }

  String? validateQuestionText(String? value) {
    return (value == null || value.isEmpty) ? 'テキストを入力してください' : null;
  }

  void addQuestion() {
    _questions.add(Question());
    notifyListeners();
  }

  void deleteQuestion(int index) {
    _questions.removeAt(index);
    notifyListeners();
  }

  void save() {
    _ref.watch(navigationServiceProvider).pop();
  }

  void delete() {
    _ref.watch(navigationServiceProvider).pop();
  }
}
