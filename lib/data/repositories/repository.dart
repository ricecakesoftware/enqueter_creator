import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enqueter_creator/data/models/model.dart';

abstract class Repository<T extends Model> {
  String _collectionName;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  Repository(this._collectionName);

  Future<List<T>> select(Query query) async {
    QuerySnapshot snapshot = await query.get();
    List<T> resultList = [];
    for (int i = 0; i < snapshot.size; i++) {
      resultList.add(convertFromData(snapshot.docs[i].data()!));
    }
    return resultList;
  }

  Future<T> selectById(String id) async {
    List<T> resultList = await select(firestore.collection(_collectionName).where('id', isEqualTo: id));
    return resultList[0];
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

  Future<void> delete(Query query) async {
    QuerySnapshot snapshot = await query.get();
    for (int i = 0; i < snapshot.size; i++) {
      await snapshot.docs[i].reference.delete();
    }
  }

  Future<void> deleteById(String id) async {
    await delete(firestore.collection(_collectionName).where('id', isEqualTo: id));
  }

  T convertFromData(Map<String, dynamic> data);
  Map<String, dynamic> convertToData(T t);
}
