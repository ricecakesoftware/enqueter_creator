import 'package:enqueter_creator/data/models/model.dart';

class Profile extends Model {
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
  set gender(int gender) {
    _gender = gender;
    notifyListeners();
  }

  DateTime _birthDate = DateTime(1970, 1, 1);
  DateTime get birthDate => _birthDate;
  set birthDate(DateTime birthDate) {
    _birthDate = birthDate;
    notifyListeners();
  }
}
