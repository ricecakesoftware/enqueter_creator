import 'package:flutter/material.dart';

class Detail extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _outlineId = '';
  String get outlineId => _outlineId;
  set outlineId(String outlineId) {
    _outlineId = outlineId;
    notifyListeners();
  }

  String _text = '';
  String get text => _text;
  set text(String text) {
    _text = text;
    notifyListeners();
  }

  int _type = 0;
  int get type => _type;
  set type(int type) {
    _type = type;
    notifyListeners();
  }
}
