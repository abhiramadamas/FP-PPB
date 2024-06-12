import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logprota/common/helpers/date.dart';
import 'package:logprota/common/ui/components/status_badge.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';
import 'package:logprota/ui/views/schedule/dosen/schedule_detail_page.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    required this.consultationProposal,
    required this.consultationId,
    super.key
  });

  final ConsultationProposal consultationProposal;
  final String consultationId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScheduleDetailPage(
              consultationId: consultationId,
            )
          )
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      consultationProposal.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    StatusBadge(
                      status: consultationProposal.getStatusTextDescription(),
                      textColor: consultationProposal.getStatusTextColor(),
                      badgeColor: consultationProposal.getBadgeColor(),
                    )
                  ],
                ),
                SizedBox(width: double.infinity, height: 10),
                Text(
                  consultationProposal.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15, height: 15),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 14.0, color: Colors.black),
                          children: <TextSpan>[
                            const TextSpan(text: "Batas Voting: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: datetimeToString(consultationProposal.latestVote),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: double.infinity, height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Total Voting: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "${consultationProposal.scheduleProposed.fold(0, (sum, schedule) => sum + schedule.getTotalVote())}"),
                          ],
                        ),
                      ),
                      SizedBox(width: double.infinity, height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Most Voted: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: datetimeToString(consultationProposal.getMostVotedSchedule()?.schedule) ?? 'No Vote'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
