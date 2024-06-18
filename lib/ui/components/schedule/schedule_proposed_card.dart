import 'package:flutter/material.dart';
import 'package:logprota/common/helpers/date.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';

class ScheduleProposedCard extends StatefulWidget {
  const ScheduleProposedCard({required this.scheduleProposed, super.key});

  final ScheduleProposed scheduleProposed;

  @override
  State<ScheduleProposedCard> createState() => _ScheduleProposedCardState();
}

class _ScheduleProposedCardState extends State<ScheduleProposedCard> {
  late List<String> mahasiswaVoted = [];

  List<String> getMahasiswaVoted() {
    return [
      "Anto",
      "Geming",
      "BJIR"
    ];
  }

  @override
  void initState() {
    super.initState();
    mahasiswaVoted = getMahasiswaVoted();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datetimeToString(widget.scheduleProposed.schedule) as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Total vote: ${widget.scheduleProposed.getTotalVote()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Column(
                children: mahasiswaVoted.map((mahasiswa) => Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  width: double.infinity,
                  color: Colors.amberAccent,
                  child: Text(
                    mahasiswa,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                )).toList() as List<Widget>,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
