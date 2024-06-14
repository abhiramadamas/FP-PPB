// screen_a.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/firestore.dart';

class UsulanTA extends StatefulWidget {
  const UsulanTA({super.key});

  @override
  State<UsulanTA> createState() => _UsulanTAState();
}

class _UsulanTAState extends State<UsulanTA> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController judulController = TextEditingController();
  final TextEditingController rencanaController = TextEditingController();
  final TextEditingController pembimbingController = TextEditingController();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Usulan TA",
        ),
      ),
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
                        'Informasi'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: judulController,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Rencana Penelitian'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: rencanaController,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Pembimbing'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: pembimbingController,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          firestoreService.tambahTugasAkhir(
                            judulController.text,
                            rencanaController.text,
                            pembimbingController.text,
                            userId,
                          );
                          judulController.clear();
                          rencanaController.clear();
                          pembimbingController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Add"),
                      )
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
