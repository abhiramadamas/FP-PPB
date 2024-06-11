import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logprota/ui/views/berita/berita_detail_page.dart';

class BeritaList extends StatelessWidget {
  const BeritaList({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> newsStream =
    FirebaseFirestore.instance.collection('news').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: newsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Expanded(
          child: ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['notes']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class BeritaItemCard extends StatelessWidget {
  final String createdAt;
  final String judul;
  final String id;
  final String note;
  const BeritaItemCard(
      {super.key,
        required this.createdAt,
        required this.judul,
        required this.id,
        required this.note
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BeritaDetailPage(
                beritaId: id,
                judul: judul,
              )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: Text(
                  "${judul}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
              ),
              Text(
                "${note}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: Text(
                  "Tanggal berita $createdAt",
                  style: const TextStyle(
                    color: Colors.black54,
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
