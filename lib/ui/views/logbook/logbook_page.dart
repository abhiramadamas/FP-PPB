import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logprota/services/logbook_service.dart';
import 'package:logprota/ui/views/logbook/logbook_form_page.dart';
import 'package:logprota/ui/views/logbook/widgets/logbook_list.dart';

class LogbookPage extends StatefulWidget {
  final String tugasAkhirId;
  const LogbookPage({super.key, required this.tugasAkhirId});

  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  late LogbookService _logbookService;

  @override
  void initState() {
    super.initState();
    _logbookService = LogbookService(widget.tugasAkhirId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logbookListView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Tambah Logbook"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LogbookFormPage(
                      tugasAkhirId: widget.tugasAkhirId,
                    )),
          );
        },
      ),
    );
  }

  Widget _logbookListView() {
    return StreamBuilder(
        stream: _logbookService.getLogbooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Tidak ada logbook"),
            );
          }
          List logbooks = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: logbooks.length,
            itemBuilder: (context, index) {
              String formatedDate = DateFormat("dd MMMM yyyy")
                  .format(logbooks[index]["date"].toDate());
              String logbookId = logbooks[index].id;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: LogbookItemCard(
                  tugasAkhirId: widget.tugasAkhirId,
                  createdAt: formatedDate,
                  number: logbooks.length - index,
                  id: logbookId,
                ),
              );
            },
            padding: const EdgeInsets.all(10.0),
          );
        });
  }
}
