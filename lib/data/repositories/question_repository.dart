import 'package:enqueter_creator/data/models/question.dart';
import 'package:enqueter_creator/data/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<QuestionRepository> questionRepositoryProvider = Provider<QuestionRepository>((_) => QuestionRepository());

class QuestionRepository extends Repository<Question> {
  QuestionRepository() : super('questions');

  Future<List<Question>> selectByPartId(String partId) async {
    return await select(firestore.collection('questions').where('part_id', isEqualTo: partId));
  }

  Future<void> deleteByPartId(String partId) async {
    await delete(firestore.collection('questions').where('part_id', isEqualTo: partId));
  }

  @override
  Question convertFromData(Map<String, dynamic> data) {
    Question question = Question();
    question.id = data['id'];
    question.text = data['text'];
    question.order = data['order'];
    return question;
  }

  @override
  Map<String, dynamic> convertToData(Question question) {
    return {
      'id': question.id,
      'text': question.text,
      'order': question.order,
    };
  }
}
