import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enqueter_creator/data/models/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ProfileRepository> profileRepositoryProvider = Provider<ProfileRepository>((ref) => ProfileRepository());

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Profile> selectById(String id) async {
    Query query = _firestore.collection('profiles').where('id', isEqualTo: id);
    QuerySnapshot snapshot = await query.get();
    return convertFromData(snapshot.docs[0].data()!);
  }

  Future<Profile?> selectByUserUid(String userUid) async {
    Query query = _firestore.collection('profiles').where('user_uid', isEqualTo: userUid);
    QuerySnapshot snapshot = await query.get();
    if (snapshot.size > 0) {
      return convertFromData(snapshot.docs[0].data()!);
    }
    return null;
  }

  Future<String?> insert(Profile profile) async {
    DocumentReference reference = await _firestore.collection('profiles').add(convertToData(profile));
    await _firestore.collection('profiles').doc(reference.id).update({'id': reference.id});
    return reference.id;
  }

  Future<void> update(Profile profile) async {
    DocumentReference reference = _firestore.collection('profiles').doc(profile.id);
    await reference.update(convertToData(profile));
  }

  Profile convertFromData(Map<String, dynamic> data) {
    Profile profile = new Profile();
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
