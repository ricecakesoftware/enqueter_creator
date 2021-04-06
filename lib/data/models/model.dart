import 'package:flutter/material.dart';

abstract class Model extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }
}
