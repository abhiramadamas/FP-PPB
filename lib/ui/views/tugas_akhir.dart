import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logprota/services/tugasakhir_service.dart';
import 'package:logprota/ui/views/usulan_ta.dart';

class TugasAkhir extends StatefulWidget {
  final String userId;
  const TugasAkhir({super.key, required this.userId});

  @override
  State<TugasAkhir> createState() => _TugasAkhirState();
}

class _TugasAkhirState extends State<TugasAkhir> {
  final TugasakhirService tugasakhirService = TugasakhirService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: tugasakhirService.getTugasAkhirStream(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _loadingIndicator();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return _addTugasAkhir();
            }

            DocumentSnapshot document = snapshot.data!.docs[0];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String docId = document.id;

            return _usulanCard(data, docId);
          },
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _addTugasAkhir() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Belum ada usulan Tugas Akhir",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UsulanTA()));
            },
            child: Text(
              'Buat Usulan'.toUpperCase(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _usulanCard(
    Map<String, dynamic> data,
    String docId,
  ) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(data['judul']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rencana: ${data['rencana']}'),
                Text('Pembimbing: ${data['pembimbing']}'),
                Text('Timestamp: ${data['timestamp'].toDate()}'),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final TextEditingController judulController =
                          TextEditingController(text: data['judul']);
                      final TextEditingController rencanaController =
                          TextEditingController(text: data['rencana']);
                      final TextEditingController pembimbingController =
                          TextEditingController(text: data['pembimbing']);

                      return AlertDialog(
                        title: const Text('Update Tugas Akhir'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: judulController,
                                decoration: const InputDecoration(
                                  labelText: 'Judul',
                                ),
                              ),
                              TextField(
                                controller: rencanaController,
                                decoration: const InputDecoration(
                                  labelText: 'Rencana',
                                ),
                              ),
                              TextField(
                                controller: pembimbingController,
                                decoration: const InputDecoration(
                                  labelText: 'Pembimbing',
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              tugasakhirService.updateTugasAkhir(
                                docId,
                                judulController.text,
                                rencanaController.text,
                                pembimbingController.text,
                              );
                              Navigator.of(context).pop();
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Tugas Akhir'),
                      content: const Text(
                          'Are you sure you want to delete this Tugas Akhir?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            tugasakhirService.deleteTugasAkhir(docId);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
