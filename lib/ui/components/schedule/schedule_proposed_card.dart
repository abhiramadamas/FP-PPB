import 'package:flutter/material.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';
import 'package:logprota/models/user/mahasiswa.dart';

class ScheduleProposedCard extends StatefulWidget {
  const ScheduleProposedCard({required this.scheduleProposed, super.key});

  final ScheduleProposed scheduleProposed;

  @override
  State<ScheduleProposedCard> createState() => _ScheduleProposedCardState();
}

class _ScheduleProposedCardState extends State<ScheduleProposedCard> {
  late List<Mahasiswa> mahasiswaVoted = [];

  List<Mahasiswa> getMahasiswaVoted () {
    return [
      Mahasiswa(registration_code: '5025201001', name: 'Anto'),
      Mahasiswa(registration_code: '5025201002', name: 'Geming'),
      Mahasiswa(registration_code: '5025201003', name: 'Keren'),
      Mahasiswa(registration_code: '5025201004', name: 'Sekali'),
      Mahasiswa(registration_code: '5025201008', name: 'Juozzz'),
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
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  widget.scheduleProposed.schedule.toIso8601String(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                Text(
                  "Total vote: ${widget.scheduleProposed.getTotalVote()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                )
              ],
            ),
            ListView.builder(
              itemCount: mahasiswaVoted.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.lightBlueAccent,
                  child: Text(
                    "${mahasiswaVoted[index].name} - ${mahasiswaVoted[index].registration_code}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0
                    ),
                  )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
