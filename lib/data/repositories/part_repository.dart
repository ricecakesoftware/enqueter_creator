import 'package:enqueter_creator/data/models/part.dart';
import 'package:enqueter_creator/data/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<PartRepository> partRepositoryProvider = Provider<PartRepository>((_) => PartRepository());

class PartRepository extends Repository<Part> {
  PartRepository() : super('parts');

  Future<List<Part>> selectByQuestionnaireId(String questionnaireId) async {
    return await select(firestore.collection('parts').where('questionnaire_id', isEqualTo: questionnaireId));
  }

  Future<void> deleteByQuestionnaireId(String questionnaireId) async {
    await delete(firestore.collection('parts').where('questionnaire_id', isEqualTo: questionnaireId));
  }

  @override
  Part convertFromData(Map<String, dynamic> data) {
    Part part = Part();
    part.id = data['id'];
    part.text = data['text'];
    part.type = data['type'];
    part.order = data['order'];
    return part;
  }

  @override
  Map<String, dynamic> convertToData(Part part) {
    return {
      'id': part.id,
      'text': part.text,
      'type': part.type,
      'order': part.order,
    };
  }
}
