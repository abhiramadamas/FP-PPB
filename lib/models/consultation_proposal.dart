import 'package:logprota/models/schedule_proposed.dart';

class Schema {
  static final String id = "_id";
  static final String title = "title";
  static final String description = "description";
  static final String status = "status";
  static final String scheduleProposed = "schedules_proposed";
  static final String latestVote = "latest_vote_datetime";
  static final String createdAt = "created_at";
}

enum ConsultationProposalStatus {
  created,
  rejected,
  accepted
}

class ConsultationProposal {
  final int? id;
  final String title;
  final String description;
  final ConsultationProposalStatus status;
  final List<ScheduleProposed> scheduleProposed;
  final DateTime latestVote;
  final DateTime createdAt;

  ConsultationProposal({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.scheduleProposed,
    required this.latestVote,
    required this.createdAt
  });


}