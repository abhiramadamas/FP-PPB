import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String tugasAkhirCollectionRef = "tugasAkhir";

class TugasakhirService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _tugasAkhirRef;

  TugasakhirService() {
    _tugasAkhirRef = _firestore.collection(tugasAkhirCollectionRef);
  }

// Create
  Future<void> tambahTugasAkhir(
      String judul, String rencana, String pembimbing, String userId) {
    return _tugasAkhirRef.add({
      'judul': judul,
      'rencana': rencana,
      'pembimbing': pembimbing,
      'uid': userId,
      'timestamp': Timestamp.now(),
    });
  }

  Future<AggregateQuerySnapshot> countTugasAkhirItem() async {
    return _tugasAkhirRef.count().get();
  }

// READ
  Stream<QuerySnapshot> getTugasAkhirStream() {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? "";
    final bimbinganStream = _tugasAkhirRef
        .where(
          "uid",
          isEqualTo: userId,
        )
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();

    return bimbinganStream;
  }

// UPDATE
  Future<void> updateTugasAkhir(
    String docID,
    String newJudul,
    String newRencana,
    String newPembimbing,
  ) {
    return _tugasAkhirRef.doc(docID).update({
      'judul': newJudul,
      'rencana': newRencana,
      'pembimbing': newPembimbing,
      'timestamp': DateTime.now()
    });
  }

// DELETE
  Future<void> deleteTugasAkhir(String docID) {
    return _tugasAkhirRef.doc(docID).delete();
  }
}
