import 'package:enqueter_creator/data/models/model.dart';

class Responder extends Model {
  String _userUid = '';
  String get userUid => _userUid;
  set userUid(String userUid) {
    _userUid = userUid;
    notifyListeners();
  }
}
