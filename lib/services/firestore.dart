import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
//   Get collection data
  final CollectionReference bimbingans = FirebaseFirestore.instance.collection('bimbingans');
  final CollectionReference tugasAkhir = FirebaseFirestore.instance.collection('tugasAkhir');

// Create
  Future<void> tambahTugasAkhir(String judul, String rencana, String pembimbing){
    return tugasAkhir.add({
      'judul': judul,
      'rencana' : rencana,
      'pembimbing' : pembimbing,
      'timestamp': Timestamp.now(),
    });
  }
// READ
  Stream<QuerySnapshot> getTugasAkhirStream() {
    final bimbinganStream = tugasAkhir.orderBy('timestamp', descending: true).snapshots();

    return bimbinganStream;
  }
// UPDATE
  Future<void> updateTugasAkhir(String docID, String newJudul, String newRencana, String newPembimbing){
    return tugasAkhir.doc(docID).update({
      'judul': newJudul,
      'rencana' : newRencana,
      'pembimbing' : newPembimbing,
      'timestamp': DateTime.now()
    });
  }
// DELETE
  Future<void> deleteTugasAkhir(String docID){
    return tugasAkhir.doc(docID).delete();
  }

  Future<void> tambahBimbingan(String bimbingan){
    return bimbingans.add({
      'note': bimbingan,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getBimbinganStream() {
    final bimbinganStream = bimbingans.orderBy('timestamp', descending: true).snapshots();

    return bimbinganStream;
  }

}