import 'package:enqueter_creator/data/models/part.dart';
import 'package:enqueter_creator/data/models/question.dart';
import 'package:enqueter_creator/data/repositories/part_repository.dart';
import 'package:enqueter_creator/data/repositories/question_repository.dart';
import 'package:enqueter_creator/data/services/dialog_service.dart';
import 'package:enqueter_creator/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<PartViewModel> partViewModelProvider = ChangeNotifierProvider(
  (ref) => PartViewModel(
    ref.read(partRepositoryProvider),
    ref.read(questionRepositoryProvider),
    ref.read(dialogServiceProvider),
    ref.read(navigationServiceProvider)
  )
);

class PartViewModel extends ChangeNotifier {
  PartRepository _partRepository;
  QuestionRepository _questionRepository;
  DialogService _dialogService;
  NavigationService _navigationService;

  String _text = '';
  String get text => _text;
  int _type = 0;
  int get type => _type;
  int _order = 0;
  int get order => _order;
  List<Question> _questions = [];
  List<Question> get questions => _questions;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String id = '';

  PartViewModel(
    this._partRepository,
    this._questionRepository,
    this._dialogService,
    this._navigationService
  );

  void refresh() async {
    if (id.isNotEmpty) {
      Part part = await _partRepository.selectById(id);
      _text = part.text;
      _type = part.type;
      _order = part.order;
      List<Question> questions = await _questionRepository.selectByPartId(id);
      _questions.addAll(questions);
      notifyListeners();
    }
  }

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

  void changeOrder(String value) {
    _order = int.parse(value);
    notifyListeners();
  }

  String? validateOrder(String? value) {
    return (value == null || value.isEmpty) ? '順番を入力してください' : null;
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

  void save() async {
    Part part = Part();
    part.id = id;
    part.text = _text;
    part.type = _type;
    part.order = _order;
    await _dialogService.showCircularProgressIndicatorDialog(() async {
      if (id.isEmpty) {
        String? id = await _partRepository.insert(part);
        if (id != null) {
          this.id = id;
        } else {
          await _dialogService.showAlertDialog('エラー', 'アンケートの登録に失敗しました。');
        }
      } else {
        await _partRepository.update(part);
      }
      await _questionRepository.deleteByPartId(id);
      for (int i = 0; i < _questions.length; i++) {
        Question question = _questions[i];
        question.partId = id;
        question.order = i;
        await _questionRepository.insert(question);
      }
    });
    await _dialogService.showAlertDialog(
        'アンケート詳細登録完了',
        'アンケート詳細の登録が完了しました。'
    );
    _navigationService.pop();
  }

  void delete() async {
    await _dialogService.showCircularProgressIndicatorDialog(() async {
      await _questionRepository.deleteByPartId(id);
      await _partRepository.deleteById(id);
    });
    await _dialogService.showAlertDialog(
        'アンケート詳細削除完了',
        'アンケート詳細の削除が完了しました。'
    );
    _navigationService.pop();
  }
}
