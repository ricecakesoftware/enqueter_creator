import 'package:enqueter_creator/data/models/model.dart';

class Question extends Model {
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
