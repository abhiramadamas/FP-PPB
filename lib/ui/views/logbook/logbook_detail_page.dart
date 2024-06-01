import 'package:flutter/material.dart';
import 'package:logprota/ui/views/logbook/logbook_add_page.dart';

class LogbookDetailPage extends StatelessWidget {
  const LogbookDetailPage(
      {super.key, required this.logbookId, required this.number});
  final String logbookId;
  final int number;

  @override
  Widget build(BuildContext context) {
    String supervisor = "Pak Dwi";
    String note = "Ini isi bimbingannya";
    String createdAt = "29 mei 2023";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Logbook"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
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
                          Navigator.of(context).pop();
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
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Bimbingan ${number.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Tanggal: $createdAt",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Dosen Pembimbing",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  supervisor,
                  style: const TextStyle(
                    fontSize: 17.0,
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
                      note,
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Edit Logbook"),
        icon: const Icon(Icons.edit_outlined),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LogbookAddPage()),
          );
        },
      ),
    );
  }
}
