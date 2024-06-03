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
      appBar: AppBar(
        title: const Text(
          "Logbook Bimbingan",
        ),
        //actions: const [
        //  Padding(
        //    padding: EdgeInsets.all(10.0),
        //    child: Icon(
        //      Icons.account_circle,
        //    ),
        //  ),
        //],
      ),
      body: _buildUi(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Tambah Bimbingan"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LogbookFormPage()),
          );
        },
      ),
    );
  }

  Widget _buildUi() {
    return SafeArea(
        child: Column(
      children: [_logbookListView()],
    ));
  }

  Widget _logbookListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
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

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: LogbookItemCard(
                  createdAt: formatedDate,
                  number: logbooks.length - index,
                  id: logbookId,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
