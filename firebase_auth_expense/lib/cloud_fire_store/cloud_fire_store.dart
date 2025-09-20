import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/expense_model.dart';

class FirebaseDatabase {
  static final _db = FirebaseFirestore.instance;
  static const usersCollectionName = "users";
  static const journalsCollectionName = "journals";

  Stream<List<Journal>> getJournal() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw "No user logged in";

    return _db
        .collection(usersCollectionName)
        .doc(userId)
        .collection(journalsCollectionName)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Journal.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addJournal(Journal journal) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw "No user logged in";

    final docRef = _db
        .collection(usersCollectionName)
        .doc(userId)
        .collection(journalsCollectionName)
        .doc();

    await docRef.set(journal.toMap()..['id'] = docRef.id);
  }

  Future<void> updateJournal(Journal journal) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw "No user logged in";

    await _db
        .collection(usersCollectionName)
        .doc(userId)
        .collection(journalsCollectionName)
        .doc(journal.id)
        .update(journal.toMap());
  }

  Future<void> deleteJournal(String journalId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw "No user logged in";

    await _db
        .collection(usersCollectionName)
        .doc(userId)
        .collection(journalsCollectionName)
        .doc(journalId)
        .delete();
  }

  Future<void> deleteAllJournals() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw "No user logged in";
    }

    final journalsRef = _db
        .collection(usersCollectionName)
        .doc(userId)
        .collection(journalsCollectionName);

    final snapshot = await journalsRef.get();
    final batch = _db.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
