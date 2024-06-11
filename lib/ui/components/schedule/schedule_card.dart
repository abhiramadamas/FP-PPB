import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logprota/common/ui/components/status_badge.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    required this.consultationProposal,
    super.key
  });

  final ConsultationProposal consultationProposal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.all(5),
      child: Card(
        child: Row(
          children: [
            Row(
              children: [
                Text(
                  consultationProposal.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.black
                  ),
                ),
                StatusBadge(
                  status: consultationProposal.status,
                  textColor: consultationProposal.getStatusTextColor(),
                  badgeColor: consultationProposal.getBadgeColor()
                )
              ],
            ),
            Text(
              consultationProposal.description,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black
              ),
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: "Batas Voting: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: consultationProposal.latestVote.toIso8601String())
                    ]
                  ),
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: "Total Voting: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: consultationProposal.scheduleProposed.fold(0, (sum, schedule) => sum + schedule.getTotalVote()) as String),
                      ]
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Most Voted: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: consultationProposal.getMostVotedSchedule()?.schedule.toIso8601String() ?? 'No Vote'),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
