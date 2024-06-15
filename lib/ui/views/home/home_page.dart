import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logprota/services/tugasakhir_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      currentUser!.email!,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
            _tugasAkhirCard(currentUser.uid),
          ],
        ),
      ),
    );
  }

  Widget _tugasAkhirCard(String userId) {
    TugasakhirService tugasakhirService = TugasakhirService();
    return StreamBuilder(
      stream: tugasakhirService.getTugasAkhirStream(userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tugas Akhir Terkini",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Belum ada usulan tugas akhir"),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        DocumentSnapshot document = snapshot.data!.docs[0];
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tugas Akhir Terkini",
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        data["judul"],
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        data["rencana"],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text("Dosen Pembimbing: ${data["pembimbing"]}",
                          style: const TextStyle(fontSize: 16.0)),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: const Text(
                          "Dalam Pengerjaan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
