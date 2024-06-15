import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logprota/models/logbook.dart';

const String logbookCollectionRef = "logbooks";
const String tugasAkhirCollectionRef = "tugasAkhir";

class LogbookService {
  final _firestore = FirebaseFirestore.instance;
  final String tugasAkhirId;
  late final CollectionReference _logbooksRef;

  LogbookService(this.tugasAkhirId) {
    _logbooksRef = _firestore
        .collection(tugasAkhirCollectionRef)
        .doc(tugasAkhirId)
        .collection(logbookCollectionRef);
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
    await _logbooksRef.add(logbook.toJson());
  }

  void updateLogbook(String logbookId, Logbook logbook) {
    logbook.createdAt = Timestamp.now();
    _logbooksRef.doc(logbookId).update(logbook.toJson());
  }

  void deleteLogbook(String logbookId) async {
    await _logbooksRef.doc(logbookId).delete();
  }
}
