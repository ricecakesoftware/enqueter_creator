import 'package:enqueter_creator/data/models/responder.dart';
import 'package:enqueter_creator/data/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ResponderRepository> responderRepositoryProvider = Provider<ResponderRepository>((_) => ResponderRepository());

class ResponderRepository extends Repository<Responder> {
  ResponderRepository() : super('responders');

  @override
  Responder convertFromData(Map<String, dynamic> data) {
    Responder responder = new Responder();
    responder.id = data['id'];
    responder.profileId = data['profile_id'];
    responder.status = data['status'];
    return responder;
  }

  @override
  Map<String, dynamic> convertToData(Responder responder) {
    return {
      'id': responder.id,
      'profile_id': responder.profileId,
      'status': responder.status,
    };
  }
}
