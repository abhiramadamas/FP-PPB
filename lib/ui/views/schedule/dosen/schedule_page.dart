import 'package:flutter/material.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';
import 'package:logprota/services/schedule_service.dart';
import 'package:logprota/ui/components/schedule/schedule_card.dart';
import 'package:logprota/ui/views/schedule/dosen/schedule_form_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _scheduleService = ScheduleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _scheduleService.getConsultations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Tidak ada jadwal konsultasi"),
            );
          }
          List consultations = snapshot.data?.docs ?? [];
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ScheduleCard(
                consultationProposal: ConsultationProposal.fromJson(consultations[index].data()),
                consultationId: consultations[index].id,
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: consultations.length,
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ScheduleFormPage()));
        },
        backgroundColor: Colors.lightBlueAccent,
        label: Container(
          color: Colors.lightBlueAccent,
          // padding: EdgeInsets.all(10),
          child: const Row(
            children: <Widget>[
              const Icon(Icons.add),
              SizedBox(width: 10, height: 10),
              const Text(
                "Buat Jadwal",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
