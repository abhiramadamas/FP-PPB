import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logprota/models/berita.dart';

const String beritaCollectionRef = "news";

class BeritaService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _newsRef;

  BeritaService() {
    _newsRef = _firestore
        .collection(beritaCollectionRef)
        .withConverter<Berita>(
      fromFirestore: (snapshot, _) => Berita.fromJson(snapshot.data()!),
      toFirestore: (berita, _) => berita.toJson(),
    );
  }

  Stream<QuerySnapshot> getNews() {
    return _newsRef.orderBy("createdAt", descending: true).snapshots();
  }

  Future<Berita> getBerita(String beritaId) async {
    DocumentSnapshot<Object?> beritaDoc =
    await _newsRef.doc(beritaId).get();

    return Berita(
      note: beritaDoc["note"],
      judul: beritaDoc["judul"],
      createdAt: beritaDoc["createdAt"],
    );
  }

  void addBerita(Berita berita) async {
    berita.createdAt = Timestamp.now();
    await _newsRef.add(berita);
  }

  void updateBerita(String beritaId, Berita berita) {
    berita.createdAt = Timestamp.now();
    _newsRef.doc(beritaId).update(berita.toJson());
  }

  void deleteBerita(String beritaId) async {
    await _newsRef.doc(beritaId).delete();
  }
}
