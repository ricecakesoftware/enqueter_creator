import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/model.dart';

class Responder extends Model {
  String profileId = '';
  ResponderStatus status = ResponderStatus.NotAnswering;
}
