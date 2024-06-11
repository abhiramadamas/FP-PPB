import 'package:flutter/material.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';

class ScheduleAddPage extends StatefulWidget {
  const ScheduleAddPage({super.key});

  @override
  State<ScheduleAddPage> createState() => _ScheduleAddPageState();
}

class _ScheduleAddPageState extends State<ScheduleAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String title, description;
  late DateTime latestVote;
  late List<ScheduleProposed> scheduleProposed = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Jadwal Konsultasi",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Headline",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Anda wajib memasukkan headline';
                  }
                  return null;
                },
                onSaved: (value) => setState(() {
                  title = value as String;
                }),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Deskripsi",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Anda wajib memasukkan deskripsi';
                  }
                  return null;
                },
                minLines: 3,
                onSaved: (value) => setState(() {
                  description = value as String;
                }),
              ),
              InputDatePickerFormField(
                fieldLabelText: "Batas waktu voting",
                firstDate: DateTime.now(),
                lastDate: () {
                  var now = DateTime.now();
                  return DateTime(
                    now.year,
                    now.month + 1,
                    now.day,
                    now.hour,
                    now.minute,
                    now.second,
                    now.millisecond,
                    now.microsecond,
                  );
                }(),
              ),
              ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          scheduleProposed[index].schedule.toIso8601String(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemCount: scheduleProposed.length
              )
            ],
          ),
        )
      ),
    );
  }
}
