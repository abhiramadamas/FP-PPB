import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
//   Get collection data
  final CollectionReference bimbingans = FirebaseFirestore.instance.collection('bimbingans');

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
}