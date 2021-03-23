import 'package:flutter/material.dart';

class Questionnaire extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _title = '';
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String _content = '';
  String get content => _content;
  set text(String content) {
    _content = content;
    notifyListeners();
  }
}
