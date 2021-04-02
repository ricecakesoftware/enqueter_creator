import 'package:flutter/material.dart';

class Responder extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _userUid = '';
  String get userUid => _userUid;
  set userUid(String userUid) {
    _userUid = userUid;
    notifyListeners();
  }
}
