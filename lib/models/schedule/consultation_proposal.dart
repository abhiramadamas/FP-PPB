import 'package:flutter/material.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';

class Schema {
  static final String id = "_id";
  static final String title = "title";
  static final String description = "description";
  static final String status = "status";
  static final String scheduleProposed = "schedules_proposed";
  static final String latestVote = "latest_vote_datetime";
  static final String createdAt = "created_at";
}

class ConsultationProposal {
  final int? id;
  final String title;
  final String description;
  final String status;
  final List<ScheduleProposed> scheduleProposed;
  final DateTime latestVote;
  final String? resume;
  final DateTime createdAt;

  ConsultationProposal({
    this.id,
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
}