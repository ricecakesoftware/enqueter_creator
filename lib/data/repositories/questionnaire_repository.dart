import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<QuestionnaireRepository> questionnaireRepositoryProvider = Provider<QuestionnaireRepository>((_) => QuestionnaireRepository());

class QuestionnaireRepository extends Repository<Questionnaire> {
  QuestionnaireRepository() : super('questionnaires');

  Future<List<Questionnaire>> selectByCreatedUserUidAndStatus(String userUid, QuestionnaireStatus status) async {
    return await select(
      firestore.collection('questionnaires')
        .where('created_user_uid', isEqualTo: userUid)
        .where('status', isEqualTo: status.index)
        .orderBy('created_at'));
  }

  @override
  Questionnaire convertFromData(Map<String, dynamic> data) {
    Questionnaire questionnaire = new Questionnaire();
    questionnaire.id = data['id'];
    questionnaire.title = data['title'];
    questionnaire.content = data['content'];
    questionnaire.deadline = data['deadline'].toDate();
    questionnaire.status = data['status'];
    questionnaire.createdAt = data['created_at'].toDate();
    questionnaire.createdUserUid = data['created_user_uid'];
    return questionnaire;
  }

  @override
  Map<String, dynamic> convertToData(Questionnaire questionnaire) {
    return {
      'id': questionnaire.id,
      'title': questionnaire.title,
      'content': questionnaire.content,
      'deadline': Timestamp.fromDate(questionnaire.deadline),
      'status': questionnaire.status,
      'created_at': Timestamp.fromDate(questionnaire.createdAt),
      'created_user_uid': questionnaire.createdUserUid,
    };
  }
}
