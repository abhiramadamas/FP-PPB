import 'package:flutter/material.dart';
import 'package:logprota/common/ui/components/date_picker.dart';
import 'package:logprota/common/ui/components/datetime_picker.dart';
import 'package:logprota/models/schedule/consultation_proposal.dart';
import 'package:logprota/models/schedule/schedule_proposed.dart';
import 'package:logprota/services/schedule_service.dart';

class ScheduleFormPage extends StatefulWidget {
  const ScheduleFormPage({
    this.consultationId,
    super.key
  });

  final String? consultationId;

  @override
  State<ScheduleFormPage> createState() => _ScheduleFormPageState();
}

class _ScheduleFormPageState extends State<ScheduleFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scheduleService = ScheduleService();

  ConsultationProposal? consultationProposal = null;

  late String? title = consultationProposal?.title;
  late String? description = consultationProposal?.description;
  late String? status = consultationProposal?.status ?? 'created';
  late DateTime latestVote = consultationProposal?.latestVote ?? DateTime.now();
  late List<ScheduleProposed> scheduleProposed = consultationProposal?.scheduleProposed ?? [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if(widget.consultationId != null) {
      _fetchSchedule(widget.consultationId as String);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchSchedule(String consultationId) async {
    ConsultationProposal consultation = await _scheduleService.getConsultation(consultationId);
    setState(() {
      consultationProposal = consultation;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Jadwal Konsultasi",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading ? Center(child: Text("LOADING...")) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: title ?? null,
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
                const SizedBox(width: double.infinity, height: 15),
                TextFormField(
                  initialValue: description ?? null,
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
                  maxLines: 5,
                  onSaved: (value) => setState(() {
                    description = value as String;
                  }),
                ),
                const SizedBox(width: double.infinity, height: 15),
                CustomDatePickerField(
                  label: "Batas Waktu Voting",
                  selectedDate: latestVote,
                  onDateChanged: (DateTime datetime) => setState(() {
                    latestVote = datetime;
                  }),
                ),
                const SizedBox(width: double.infinity, height: 15),
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: scheduleProposed.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          CustomDateTimePickerField(
                            key: UniqueKey(),
                            label: "Opsi Jadwal ${index + 1}",
                            selectedDateTime: scheduleProposed[index].schedule,
                            onDateTimeChanged: (DateTime date) {
                              List<ScheduleProposed> updatedSchedule = [];
                              for (final schedule in scheduleProposed) {
                                updatedSchedule.add(ScheduleProposed(
                                  schedule: schedule.schedule,
                                ));
                              }
                              updatedSchedule[index] = ScheduleProposed(schedule: date);
                              setState(() {
                                scheduleProposed = updatedSchedule;
                              });
                            },
                          ),
                          const SizedBox(width: double.infinity, height: 15)
                        ],
                      );
                    }),
                MaterialButton(
                  color: Colors.amberAccent,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(15),
                  onPressed: () => setState(() {
                    scheduleProposed.add(ScheduleProposed(
                      schedule: DateTime.now(),
                    ));
                  }),
                  child: const Text(
                    "Tambah Opsi Jadwal",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: double.infinity, height: 15),
                MaterialButton(
                  color: Colors.lightBlueAccent,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(15),
                  onPressed: (){
                    if(_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ConsultationProposal consultation = ConsultationProposal(
                          title: title as String,
                          description: description as String,
                          status: 'created',
                          scheduleProposed: scheduleProposed,
                          latestVote: latestVote,
                          createdAt: DateTime.now()
                      );
                      if(widget.consultationId!=null) {
                        _scheduleService.updateLogbook(widget.consultationId as String, consultation);
                      } else {
                        _scheduleService.addConsultation(consultation);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Simpan Jadwal Konsultasi",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
