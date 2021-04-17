import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/model.dart';

class Profile extends Model {
  String userUid = '';
  String displayName = '';
  Gender gender = Gender.Male;
  DateTime birthDate = dateTimeMinimum;
}
