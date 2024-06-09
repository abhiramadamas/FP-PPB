// screen_a.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore.dart';
import 'usulan_ta.dart';

class TugasAkhir extends StatefulWidget {
  const TugasAkhir({super.key});

  @override
  State<TugasAkhir> createState() => _TugasAkhirState();
}

class _TugasAkhirState extends State<TugasAkhir> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Menu'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Serba-serbi tugas akhir anda",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Catatan Penelitian dan Bimbingan'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Tugas Akhir Saya",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21.0),
                      ),
                      const Text(
                        "Status ajuan tugas akhir saya",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UsulanTA()));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Buat Usulan'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      StreamBuilder<QuerySnapshot>(
                        stream: firestoreService.getTugasAkhirStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text('No Tugas Akhir available');
                          }

                          return SizedBox(
                            height: 400.0, // Set a fixed height for the list
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return ListTile(
                                  title: Text(data['judul']),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Rencana: ${data['rencana']}'),
                                      Text('Pembimbing: ${data['pembimbing']}'),
                                      Text(
                                          'Timestamp: ${data['timestamp'].toDate()}'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              final TextEditingController
                                                  judulController =
                                                  TextEditingController(
                                                      text: data['judul']);
                                              final TextEditingController
                                                  rencanaController =
                                                  TextEditingController(
                                                      text: data['rencana']);
                                              final TextEditingController
                                                  pembimbingController =
                                                  TextEditingController(
                                                      text: data['pembimbing']);

                                              return AlertDialog(
                                                title: const Text(
                                                    'Update Tugas Akhir'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            judulController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Judul',
                                                        ),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            rencanaController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Rencana',
                                                        ),
                                                      ),
                                                      TextField(
                                                        controller:
                                                            pembimbingController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Pembimbing',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      firestoreService
                                                          .updateTugasAkhir(
                                                        document.id,
                                                        judulController.text,
                                                        rencanaController.text,
                                                        pembimbingController
                                                            .text,
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
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
                                              title: const Text(
                                                  'Delete Tugas Akhir'),
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
                                                    firestoreService
                                                        .deleteTugasAkhir(
                                                            document.id);
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
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
