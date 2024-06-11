import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logprota/common/ui/components/status_badge.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';
import 'package:logprota/ui/components/schedule/schedule_proposed_card.dart';

class ScheduleDetailPage extends StatelessWidget {
  const ScheduleDetailPage({required this.consultation, super.key});

  final ConsultationProposal consultation;
  
  Widget _buildConsultationProperty(String property, String value) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(fontSize: 14.0, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: property,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value)
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Daftar Jadwal Konsultasi",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(children: [
                Row(
                  children: [
                    Text(
                      consultation.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.black),
                    ),
                    StatusBadge(
                        status: consultation.status,
                        textColor: consultation.getStatusTextColor(),
                        badgeColor: consultation.getBadgeColor())
                  ],
                ),
                Text(
                  consultation.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black),
                ),
                Row(
                  children: [
                    _buildConsultationProperty("Batas Voting",
                        consultation.latestVote.toIso8601String()),
                    _buildConsultationProperty(
                        "Total Voting: ",
                        consultation.scheduleProposed.fold(
                            0,
                            (sum, schedule) =>
                                sum + schedule.getTotalVote()) as String),
                    _buildConsultationProperty(
                        "Most Voted: ",
                        consultation
                                .getMostVotedSchedule()
                                ?.schedule
                                .toIso8601String() ??
                            'No Vote')
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Users Vote:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(width: 10, height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: consultation.scheduleProposed.length,
                        itemBuilder: (BuildContext context, int index) => ScheduleProposedCard(scheduleProposed: consultation.scheduleProposed[index]),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: FilledButton(
                    onPressed: (){},
                    child: const Text(
                      "ISI BERITA ACARA",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: FilledButton(
                    onPressed: (){},
                    child: const Text(
                      "UBAH JADWAL BIMBINGAN",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        )
    );
  }
}
