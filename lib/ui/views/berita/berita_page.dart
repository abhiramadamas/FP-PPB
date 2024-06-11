import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logprota/models/berita.dart';
import 'package:logprota/services/berita_service.dart';
import 'package:logprota/ui/views/berita/berita_form_page.dart';
import 'package:logprota/ui/views/berita/widgets/berita_list.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  final _beritaService = BeritaService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _beritaListView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Tambah Berita"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BeritaFormPage()),
          );
        },
      ),
    );
  }

  Widget _beritaListView() {
    return StreamBuilder(
      stream: _beritaService.getNews(),
      builder: (context, snapshot) {
        List news = snapshot.data?.docs ?? [];
        if (news.isEmpty) {
          return const Center(
            child: Text("Tidak ada berita"),
          );
        }
        return ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            Berita berita = news[index].data();
            String judul = berita.judul;
            String note = berita.note;
            String formatedDate =
                DateFormat("dd MMMM yyyy").format(berita.createdAt!.toDate());
            String beritaId = news[index].id;

            return BeritaItemCard(
              createdAt: formatedDate,
              judul: judul,
              note: note,
              id: beritaId,
            );
          },
          padding: const EdgeInsets.all(10.0),
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
