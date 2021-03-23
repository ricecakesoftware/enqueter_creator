import 'package:flutter/material.dart';

class Outline extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _questionnaireId = '';
  String get questionnaireId => _questionnaireId;
  set questionnaireId(String questionnaireId) {
    _questionnaireId = questionnaireId;
    notifyListeners();
  }

  String _text = '';
  String get text => _text;
  set text(String text) {
    _text = text;
    notifyListeners();
  }
}
