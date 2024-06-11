import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logprota/models/berita.dart';
import 'package:logprota/services/berita_service.dart';
import 'package:logprota/ui/views/berita/berita_form_page.dart';

class BeritaDetailPage extends StatefulWidget {
  const BeritaDetailPage(
      {super.key, required this.beritaId, required this.judul});
  final String beritaId;
  final String judul;

  @override
  State<BeritaDetailPage> createState() => _BeritaDetailPageState();
}

class _BeritaDetailPageState extends State<BeritaDetailPage> {
  final BeritaService _beritaService = BeritaService();
  late Berita berita;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBerita();
  }

  Future<void> _fetchBerita() async {
    berita = await _beritaService.getBerita(widget.beritaId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _deleteBerita(),
          ),
        ],
      ),
      body: _beritaDetail(),
      floatingActionButton: FutureBuilder<String?>(
        future: getUserRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return an empty container while waiting for the future to complete
            return Container();
          }
          // Show the floating action button only if user is Dosen
          if (snapshot.data == 'Dosen') {
            return FloatingActionButton.extended(
              label: const Text("Edit Berita"),
              icon: const Icon(Icons.edit_outlined),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BeritaFormPage(
                      beritaId: widget.beritaId,
                      note: berita.note,
                      judul: berita.judul,
                      departemen: berita.departemen,
                    ),
                  ),
                );
                _fetchBerita();
              },
            );
          } else {
            // Return an empty container if user is not Dosen
            return Container();
          }
        },
      ),
    );
  }

  Widget _beritaDetail() {
    if (isLoading) {
      return const Center(
        child: Text("Loading"),
      );
    }

    String formatedDate =
    DateFormat("dd MMMM yyyy").format(berita.createdAt!.toDate());
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
                "${berita.judul}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blue
                ),
              ),
              Text(
                "Departemen ${berita.departemen}",
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black38
                ),
              ),
              Text(
                "Tanggal dibuat: $formatedDate",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black38
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Berita",
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
                    berita.note,
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

  Widget _deleteBerita() {
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
              "Kamu yakin ingin menghapus logbook ini?",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // delete action
                  _beritaService.deleteBerita(widget.beritaId);
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

  // Function to get user role from Firebase Authentication
  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      if (email.contains("@dosen.com")) {
        return 'Dosen';
      } else {
        return 'Mahasiswa';
      }
    }
    return null;
  }
}
