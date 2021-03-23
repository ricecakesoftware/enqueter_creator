import 'package:flutter/material.dart';

class Responder extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }
}
