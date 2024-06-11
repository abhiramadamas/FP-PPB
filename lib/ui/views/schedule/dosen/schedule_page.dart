import 'package:flutter/material.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';
import 'package:logprota/ui/components/schedule/schedule_card.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    required this.consultations,
    super.key
  });

  final List<ConsultationProposal> consultations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Jadwal Konsultasi",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ScheduleCard(consultationProposal: consultations[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: consultations.length
      )
    );
  }
}
