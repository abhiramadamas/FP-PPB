import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logprota/models/berita.dart';
import 'package:logprota/services/berita_service.dart';
import 'package:logprota/ui/views/berita/berita_form_page.dart';
import 'package:logprota/ui/views/berita/widgets/berita_list.dart';

class BeritaPage extends StatefulWidget {
  final String userEmail;
  const BeritaPage({super.key, required this.userEmail});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  final _beritaService = BeritaService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _beritaListView(),
      floatingActionButton: _addNewsFloatButton(),
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

  Widget? _addNewsFloatButton() {
    String userRole = getUserRole();
    if (userRole != 'Dosen') {
      return null;
    }
    return FloatingActionButton.extended(
      label: const Text("Tambah Berita"),
      icon: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BeritaFormPage()),
        );
      },
    );
  }

  // Function to get user role from Firebase Authentication
  String getUserRole() {
    if (widget.userEmail.contains("@dosen.com")) {
      return 'Dosen';
    }
    return 'Mahasiswa';
  }
}
