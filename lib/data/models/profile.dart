import 'package:flutter/material.dart';

class Profile extends ChangeNotifier {
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

  String _displayName = '';
  String get displayName => _displayName;
  set displayName(String displayName) {
    _displayName = displayName;
    notifyListeners();
  }

  int _gender = 0;
  int get gender => _gender;
  set gender(int userUid) {
    _gender = gender;
    notifyListeners();
  }

  DateTime _birthDate = DateTime.now();
  DateTime get birthDate => _birthDate;
  set birthDate(DateTime userUid) {
    _birthDate = birthDate;
    notifyListeners();
  }
}
