import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logprota/models/logbook.dart';
import 'package:logprota/services/logbook_service.dart';

class LogbookFormPage extends StatefulWidget {
  final String? logbookId;
  final String? note;
  final Timestamp? date;
  final String tugasAkhirId;
  const LogbookFormPage(
      {super.key,
      this.logbookId,
      this.note,
      this.date,
      required this.tugasAkhirId});

  @override
  State<LogbookFormPage> createState() => _LogbookFormPageState();
}

class _LogbookFormPageState extends State<LogbookFormPage> {
  final formKey = GlobalKey<FormState>();
  final noteController = TextEditingController();
  final dateController = TextEditingController();
  late LogbookService _logbookService;
  @override
  void initState() {
    super.initState();
    _logbookService = LogbookService(widget.tugasAkhirId);
    if (widget.note != null) {
      noteController.text = widget.note!;
    }
    if (widget.date != null) {
      DateTime dateTime = widget.date!.toDate();
      dateController.text = dateTime.toString().split(" ")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    String formTitle =
        widget.logbookId != null ? "Edit Logbook" : "Tambah Logbook";
    return Scaffold(
      appBar: AppBar(
        title: Text(formTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        labelText: "Tanggal bimbingan",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tanggal bimbingan wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Catatan bimbingan",
                      ),
                      minLines: 4,
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Catatan wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ),
                  _saveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime initialDate = widget.date?.toDate() ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            DateTime dateTime = DateTime.parse(dateController.text);
            Logbook logbook = Logbook(
              note: noteController.text,
              date: Timestamp.fromDate(dateTime),
            );
            if (widget.logbookId != null) {
              // save edit
              _logbookService.updateLogbook(widget.logbookId!, logbook);
            } else {
              // save add
              _logbookService.addLogbook(logbook);
            }
            Navigator.of(context).pop();
          }
        },
        child: const Text("Simpan"),
      ),
    );
  }
}
