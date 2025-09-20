import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/expense_model.dart';

class FirebaseDatabase {
  static final _db = FirebaseFirestore.instance;
  static const usersCollectionName = "users";
  static const journalsCollectionName = "journals";

  /// READ - real-time stream of all journals
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

  /// CREATE - add new journal
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

  /// UPDATE - update journal by ID
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

  /// DELETE - delete journal by ID
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
}
