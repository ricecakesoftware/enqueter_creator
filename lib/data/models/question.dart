import 'package:flutter/material.dart';

class Question extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _partId = '';
  String get partId => _partId;
  set partId(String partId) {
    _partId = partId;
    notifyListeners();
  }

  String _text = '';
  String get text => _text;
  set text(String text) {
    _text = text;
    notifyListeners();
  }

  int _order = 0;
  int get order => _order;
  set order(int order) {
    _order = order;
    notifyListeners();
  }
}
