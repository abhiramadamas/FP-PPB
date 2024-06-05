import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logprota/models/logbook.dart';

const String logbookCollectionRef = "logbooks";

class LogbookService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _logbooksRef;

  LogbookService() {
    _logbooksRef = _firestore
        .collection(logbookCollectionRef)
        .withConverter<Logbook>(
          fromFirestore: (snapshot, _) => Logbook.fromJson(snapshot.data()!),
          toFirestore: (logbook, _) => logbook.toJson(),
        );
  }

  Stream<QuerySnapshot> getLogbooks() {
    return _logbooksRef.orderBy("date", descending: true).snapshots();
  }

  Future<Logbook> getLogbook(String logbookId) async {
    DocumentSnapshot<Object?> logbookDoc =
        await _logbooksRef.doc(logbookId).get();

    return Logbook(
      note: logbookDoc["note"],
      date: logbookDoc["date"],
      createdAt: logbookDoc["createdAt"],
    );
  }

  void addLogbook(Logbook logbook) async {
    logbook.createdAt = Timestamp.now();
    await _logbooksRef.add(logbook);
  }

  void updateLogbook(String logbookId, Logbook logbook) {
    logbook.createdAt = Timestamp.now();
    _logbooksRef.doc(logbookId).update(logbook.toJson());
  }

  void deleteLogbook(String logbookId) async {
    await _logbooksRef.doc(logbookId).delete();
  }
}
