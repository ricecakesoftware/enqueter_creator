import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enqueter_creator/data/models/model.dart';

abstract class Repository<T extends Model> {
  String _collectionName;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  Repository(this._collectionName);

  Future<T> selectById(String id) async {
    Query query = firestore.collection(_collectionName).where('id', isEqualTo: id);
    QuerySnapshot snapshot = await query.get();
    return convertFromData(snapshot.docs[0].data()!);
  }

  Future<String?> insert(T t) async {
    DocumentReference reference = await firestore.collection(_collectionName).add(convertToData(t));
    await firestore.collection(_collectionName).doc(reference.id).update({'id': reference.id});
    return reference.id;
  }

  Future<void> update(T t) async {
    DocumentReference reference = firestore.collection(_collectionName).doc(t.id);
    await reference.update(convertToData(t));
  }

  Future<void> delete(T t) async {
    DocumentReference reference = firestore.collection(_collectionName).doc(t.id);
    await reference.delete();
  }

  T convertFromData(Map<String, dynamic> data);
  Map<String, dynamic> convertToData(T t);
}
