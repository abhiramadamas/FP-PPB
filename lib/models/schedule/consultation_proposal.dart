import 'package:flutter/material.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';

class Schema {
  static final String title = "title";
  static final String description = "description";
  static final String status = "status";
  static final String scheduleProposed = "schedules_proposed";
  static final String latestVote = "latest_vote_datetime";
  static final String createdAt = "created_at";
}

class ConsultationProposal {
  final String title;
  final String description;
  final String status;
  final List<ScheduleProposed> scheduleProposed;
  final DateTime latestVote;
  final String? resume;
  final DateTime createdAt;

  ConsultationProposal({
    required this.title,
    required this.description,
    required this.status,
    required this.scheduleProposed,
    required this.latestVote,
    this.resume,
    required this.createdAt
  });

  Color getStatusTextColor() {
    switch (status) {
      case 'created':
        return Colors.black;
      case 'vote_closed':
        return Colors.black;
      case 'done':
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  String getStatusTextDescription() {
    switch (status) {
      case 'created':
        return 'DIBUAT';
      case 'vote_closed':
        return 'VOTE DITUTUP';
      case 'done':
        return 'SELESAI';
      default:
        return 'DIBUAT';
    }
  }

  Color getBadgeColor() {
    switch (status) {
      case 'created':
        return Colors.amberAccent;
      case 'vote_closed':
        return Colors.lightBlueAccent;
      case 'done':
        return Colors.lightGreenAccent;
      default:
        return Colors.white;
    }
  }

  ScheduleProposed? getMostVotedSchedule() {
    var mostVoted = null;
    var maxVote = 0;
    for(final schedule in scheduleProposed) {
      if(schedule.getTotalVote() > maxVote) {
        mostVoted = schedule;
      }
    }
    return mostVoted;
  }

  Map<String, Object?> toJson() => {
    Schema.title: this.title,
    Schema.description: this.description,
    Schema.status: this.status,
    Schema.scheduleProposed: this.scheduleProposed.map((schedule) => schedule.toJson()).toList(),
    Schema.latestVote: this.latestVote.toIso8601String(),
    Schema.createdAt: this.createdAt.toIso8601String()
  };

  static ConsultationProposal fromJson(Map<String, Object?> json){
    return ConsultationProposal(
        title: json[Schema.title] as String,
        description: json[Schema.description] as String,
        status: json[Schema.status] as String,
        scheduleProposed: (json[Schema.scheduleProposed] as List<dynamic>).map((item) => (item as Map<String, Object?>)).toList().map((schedule) => ScheduleProposed.fromJson(schedule)).toList(),
        latestVote: DateTime.parse(json[Schema.latestVote] as String),
        createdAt: DateTime.parse(json[Schema.createdAt] as String)
    );
  }
}