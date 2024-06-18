import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';

const String consultationProposalCollectionRef = 'schedules';

class ScheduleService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _schedulesRef;

  ScheduleService() {
    _schedulesRef = _firestore.collection(consultationProposalCollectionRef);
  }

  Stream<QuerySnapshot> getConsultations() {
    return _schedulesRef.orderBy("created_at", descending: true).snapshots();
  }

  Future<ConsultationProposal> getConsultation(String consultationId) async {
    DocumentSnapshot<Object?> consultationDoc =
    await _schedulesRef.doc(consultationId).get();

    return ConsultationProposal.fromJson(consultationDoc.data() as Map<String, Object?>);
  }

  void addConsultation(ConsultationProposal consultation) async {
    await _schedulesRef.add(consultation.toJson());
  }

  void updateLogbook(String consultationId, ConsultationProposal consultation) async {
    await _schedulesRef.doc(consultationId).update(consultation.toJson());
  }

  void deleteLogbook(String consultationId) async {
    await _schedulesRef.doc(consultationId).delete();
  }
}