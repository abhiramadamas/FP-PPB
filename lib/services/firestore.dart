import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
//   Get collection data
  final CollectionReference bimbingans = FirebaseFirestore.instance.collection('bimbingans');
  final CollectionReference tugasAkhir = FirebaseFirestore.instance.collection('tugasAkhir');

// Create
  Future<void> tambahBimbingan(String bimbingan){
    return bimbingans.add({
      'note': bimbingan,
      'timestamp': Timestamp.now(),
    });
  }

// READ
  Stream<QuerySnapshot> getBimbinganStream() {
    final bimbinganStream = bimbingans.orderBy('timestamp', descending: true).snapshots();

    return bimbinganStream;
  }
// UPDATE

// DELETE
  Future<void> tambahTugasAkhir(String judul, String rencana, String pembimbing){
    return bimbingans.add({
      'judul': judul,
      'rencana' : rencana,
      'pembimbing' : pembimbing,
      'timestamp': Timestamp.now(),
    });
  }

}