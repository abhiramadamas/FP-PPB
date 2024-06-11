import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logprota/models/logbook.dart';
import 'package:logprota/services/logbook_service.dart';
import 'package:logprota/ui/views/logbook/logbook_form_page.dart';
import 'package:logprota/ui/views/logbook/widgets/logbook_list.dart';

class LogbookPage extends StatefulWidget {
  const LogbookPage({super.key});

  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  final _logbookService = LogbookService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logbookListView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Tambah Logbook"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LogbookFormPage()),
          );
        },
      ),
    );
  }

  Widget _logbookListView() {
    return StreamBuilder(
      stream: _logbookService.getLogbooks(),
      builder: (context, snapshot) {
        List logbooks = snapshot.data?.docs ?? [];
        if (logbooks.isEmpty) {
          return const Center(
            child: Text("Tidak ada logbook"),
          );
        }
        return ListView.builder(
          itemCount: logbooks.length,
          itemBuilder: (context, index) {
            Logbook logbook = logbooks[index].data();
            String formatedDate =
                DateFormat("dd MMMM yyyy").format(logbook.date.toDate());
            String logbookId = logbooks[index].id;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: LogbookItemCard(
                createdAt: formatedDate,
                number: logbooks.length - index,
                id: logbookId,
              ),
            );
          },
          padding: const EdgeInsets.all(10.0),
        );
      },
    );
  }
}
