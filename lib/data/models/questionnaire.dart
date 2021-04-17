import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/model.dart';

class Questionnaire extends Model {
  String title = '';
  String content = '';
  DateTime deadline = dateTimeMinimum;
  QuestionnaireStatus status = QuestionnaireStatus.Creating;
  DateTime createdAt = dateTimeMinimum;
  String createdUserUid = '';
}
