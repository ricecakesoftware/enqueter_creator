import 'package:enqueter_creator/data/models/model.dart';

class Part extends Model {
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

  int _type = 0;
  int get type => _type;
  set type(int type) {
    _type = type;
    notifyListeners();
  }

  int _order = 0;
  int get order => _order;
  set order(int order) {
    _order = order;
    notifyListeners();
  }
}
