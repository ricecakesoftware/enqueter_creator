import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enqueter_creator/data/models/profile.dart';
import 'package:enqueter_creator/data/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ProfileRepository> profileRepositoryProvider = Provider<ProfileRepository>((_) => ProfileRepository());

class ProfileRepository extends Repository<Profile> {
  ProfileRepository() : super('profiles');

  Future<Profile?> selectByUserUid(String userUid) async {
    Query query = firestore.collection('profiles').where('user_uid', isEqualTo: userUid);
    QuerySnapshot snapshot = await query.get();
    if (snapshot.size > 0) {
      return convertFromData(snapshot.docs[0].data()!);
    }
    return null;
  }

  Profile convertFromData(Map<String, dynamic> data) {
    Profile profile = Profile();
    profile.id = data['id'];
    profile.userUid = data['user_uid'];
    profile.displayName = data['display_name'];
    profile.gender = data['gender'];
    profile.birthDate = data['birth_date'].toDate();
    return profile;
  }

  Map<String, dynamic> convertToData(Profile profile) {
    return {
      'id': profile.id,
      'user_uid': profile.userUid,
      'display_name': profile.displayName,
      'gender': profile.gender,
      'birth_date': Timestamp.fromDate(profile.birthDate),
    };
  }
}
