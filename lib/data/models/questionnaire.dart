import 'package:enqueter_creator/data/models/model.dart';

class Questionnaire extends Model {
  String _title = '';
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String _content = '';
  String get content => _content;
  set content(String content) {
    _content = content;
    notifyListeners();
  }

  DateTime _deadline = DateTime(1970, 1, 1);
  DateTime get deadline => _deadline;
  set deadline(DateTime deadline) {
    _deadline = deadline;
    notifyListeners();
  }

  int _status = 0;
  int get status => _status;
  set status(int status) {
    _status = status;
    notifyListeners();
  }

  DateTime _createdAt = DateTime(1970, 1, 1);
  DateTime get createdAt => _createdAt;
  set createdAt(DateTime createdAt) {
    _createdAt = createdAt;
    notifyListeners();
  }

  String _createdUserUid = '';
  String get createdUserUid => _createdUserUid;
  set createdUserUid(String createdUserUid) {
    _createdUserUid = createdUserUid;
    notifyListeners();
  }
}
