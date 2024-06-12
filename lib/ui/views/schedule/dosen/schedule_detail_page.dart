import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logprota/common/helpers/date.dart';
import 'package:logprota/common/ui/components/status_badge.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';
import 'package:logprota/services/schedule_service.dart';
import 'package:logprota/ui/components/schedule/schedule_proposed_card.dart';
import 'package:logprota/ui/views/schedule/dosen/schedule_form_page.dart';

class ScheduleDetailPage extends StatefulWidget {
  ScheduleDetailPage({
    required this.consultationId,
    super.key
  });

  final String consultationId;

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  final _scheduleService = ScheduleService();
  late ConsultationProposal consultation;
  bool isLoading = true;

  @override
  void initState() {
    print(isLoading);
    super.initState();
    _fetchSchedule();
  }

  Future<void> _fetchSchedule() async {
    consultation = await _scheduleService.getConsultation(widget.consultationId);
    print(consultation);
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildConsultationProperty(String property, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14.0, color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: property, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Jadwal Konsultasi",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: _deleteSchedule(context),
          )
        ],
      ),
      body: isLoading ? Center(child: Text("LOADING...")) : SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    consultation.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                  StatusBadge(
                    status: consultation.getStatusTextDescription(),
                    textColor: consultation.getStatusTextColor(),
                    badgeColor: consultation.getBadgeColor(),
                  )
                ],
              ),
              SizedBox(width: double.infinity, height: 15),
              Text(
                consultation.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: double.infinity, height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildConsultationProperty("Batas Voting: ", datetimeToString(consultation.latestVote) as String),
                  SizedBox(width: double.infinity, height: 10),
                  _buildConsultationProperty("Total Voting: ", "${consultation.scheduleProposed.fold(0, (sum, schedule) => sum + schedule.getTotalVote())}"),
                  SizedBox(width: double.infinity, height: 10),
                  _buildConsultationProperty("Most Voted: ", datetimeToString(consultation.getMostVotedSchedule()?.schedule) ?? 'No Vote'),
                ],
              ),
              SizedBox(width: double.infinity, height: 15),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Users Vote:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10, height: 10),
                    Container(
                      child: Column(
                        children: consultation.scheduleProposed.map((schedule) => ScheduleProposedCard(scheduleProposed: schedule)).toList(),
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(width: double.infinity, height: 15),
              MaterialButton(
                color: Colors.lightBlueAccent,
                minWidth: double.infinity,
                padding: EdgeInsets.all(15),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScheduleFormPage(
                        consultationId: widget.consultationId,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Ubah Jadwal Bimbingan",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _deleteSchedule(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.delete),
      onTap: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Hapus Jadwal Konsultasi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 20.0,
              ),
            ),
            content: const Text(
              "Kamu yakin ingin menghapus jadwal ini?",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // delete action
                  _scheduleService.deleteLogbook(widget.consultationId);
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Ya",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  "Tidak",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
