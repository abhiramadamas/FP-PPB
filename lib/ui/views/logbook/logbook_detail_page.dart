import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logprota/models/logbook.dart';
import 'package:logprota/services/logbook_service.dart';
import 'package:logprota/ui/views/logbook/logbook_form_page.dart';

class LogbookDetailPage extends StatefulWidget {
  const LogbookDetailPage(
      {super.key,
      required this.logbookId,
      required this.number,
      required this.tugasAkhirId});
  final String logbookId;
  final int number;
  final String tugasAkhirId;

  @override
  State<LogbookDetailPage> createState() => _LogbookDetailPageState();
}

class _LogbookDetailPageState extends State<LogbookDetailPage> {
  late LogbookService _logbookService;
  late Logbook logbook;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _logbookService = LogbookService(widget.tugasAkhirId);
    _fetchLogbook();
  }

  Future<void> _fetchLogbook() async {
    logbook = await _logbookService.getLogbook(widget.logbookId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Logbook"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _deleteLogbook(),
          ),
        ],
      ),
      body: _logbookDetail(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Edit Logbook"),
        icon: const Icon(Icons.edit_outlined),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LogbookFormPage(
                tugasAkhirId: widget.tugasAkhirId,
                logbookId: widget.logbookId,
                note: logbook.note,
                date: logbook.date,
              ),
            ),
          );
          _fetchLogbook();
        },
      ),
    );
  }

  Widget _logbookDetail() {
    if (isLoading) {
      return const Center(
        child: Text("Loading"),
      );
    }

    String formatedDate =
        DateFormat("dd MMMM yyyy").format(logbook.date.toDate());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Bimbingan ${widget.number.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                "Tanggal: $formatedDate",
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Catatan Pembimbingan",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    logbook.note,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _deleteLogbook() {
    return GestureDetector(
      child: const Icon(Icons.delete),
      onTap: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Hapus Logbook",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 20.0,
              ),
            ),
            content: const Text(
              "Kamu yakin ingin menghapus logbook inig?",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // delete action
                  _logbookService.deleteLogbook(widget.logbookId);
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
