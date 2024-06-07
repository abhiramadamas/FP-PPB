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
      appBar: AppBar(
        title: const Text(
          "Berita Tugas Akhir",
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

  Widget _buildUi() {
    return SafeArea(
        child: Column(
          children: [_beritaListView()],
        ));
  }

  Widget _beritaListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
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
              String formatedDate =
              DateFormat("dd MMMM yyyy").format(berita.createdAt!.toDate());
              String beritaId = news[index].id;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BeritaItemCard(
                  createdAt: formatedDate,
                  judul: judul,
                  id: beritaId,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
