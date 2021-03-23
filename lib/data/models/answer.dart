import 'package:flutter/material.dart';

class Answer extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _detailId = '';
  String get detailId => _detailId;
  set detailId(String detailId) {
    _detailId = detailId;
    notifyListeners();
  }

  String _userId = '';
  String get userId => _userId;
  set userId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  int _value = 0;
  int get value => _value;
  set value(int value) {
    _value = value;
    notifyListeners();
  }

  String _text = '';
  String get text => _text;
  set text(String text) {
    _text = text;
    notifyListeners();
  }
}
