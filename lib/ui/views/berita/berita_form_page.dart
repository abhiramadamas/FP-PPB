import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logprota/models/berita.dart';
import 'package:logprota/services/berita_service.dart';

class BeritaFormPage extends StatefulWidget {
  final String? beritaId;
  final String? note;
  final String? judul;
  final String? departemen;
  const BeritaFormPage({super.key, this.beritaId, this.note, this.judul, this.departemen});

  @override
  State<BeritaFormPage> createState() => _BeritaFormPageState();
}

class _BeritaFormPageState extends State<BeritaFormPage> {
  final formKey = GlobalKey<FormState>();
  final noteController = TextEditingController();
  final judulController = TextEditingController();
  final departemenController = TextEditingController();
  final _beritaService = BeritaService();
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      noteController.text = widget.note!;
    }
    if (widget.judul != null) {
      judulController.text = widget.judul!;
    }
    if (widget.departemen != null) {
      departemenController.text = widget.departemen!;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formTitle =
    widget.beritaId != null ? "Tambah Berita" : "Edit Berita";
    return Scaffold(
      appBar: AppBar(
        title: Text(formTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: judulController,
                      decoration: const InputDecoration(
                        labelText: "Judul Berita",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Judul Berita wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: departemenController,
                      decoration: const InputDecoration(
                        labelText: "Departemen",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Departemen wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Isi Berita",
                      ),
                      minLines: 4,
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Isi Berita wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ),
                  _saveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Berita berita = Berita(
              note: noteController.text,
              judul: judulController.text,
              departemen: departemenController.text,
            );
            if (widget.beritaId != null) {
              // save edit
              _beritaService.updateBerita(widget.beritaId!, berita);
            } else {
              // save add
              _beritaService.addBerita(berita);
            }
            Navigator.of(context).pop();
          }
        },
        child: const Text("Simpan"),
      ),
    );
  }
}
