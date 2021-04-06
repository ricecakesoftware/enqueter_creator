import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enqueter_creator/data/models/questionnaire.dart';
import 'package:enqueter_creator/data/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<QuestionnaireRepository> questionnaireRepositoryProvider = Provider<QuestionnaireRepository>((_) => QuestionnaireRepository());

class QuestionnaireRepository extends Repository<Questionnaire> {
  QuestionnaireRepository() : super('questionnaires');

  Future<List<Questionnaire>> selectByCreatedUserUidAndStatus(String userUid, int status) async {
    Query query = firestore.collection('questionnaires')
      .where('created_user_uid', isEqualTo: userUid)
      .where('status', isEqualTo: status)
      .orderBy('created_at');
    QuerySnapshot snapshot = await query.get();
    List<Questionnaire> resultList = [];
    for (int i = 0; i < snapshot.size; i++) {
      resultList.add(convertFromData(snapshot.docs[i].data()!));
    }
    return resultList;
  }

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
