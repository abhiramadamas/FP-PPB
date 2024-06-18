import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logprota/ui/views/logbook/logbook_detail_page.dart';

class LogbookList extends StatelessWidget {
  const LogbookList({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> logbooksStream =
        FirebaseFirestore.instance.collection('logbooks').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: logbooksStream,
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

class LogbookItemCard extends StatelessWidget {
  final String createdAt;
  final int number;
  final String id;
  final String tugasAkhirId;
  const LogbookItemCard({
    super.key,
    required this.createdAt,
    required this.number,
    required this.id,
    required this.tugasAkhirId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LogbookDetailPage(
              tugasAkhirId: tugasAkhirId,
              logbookId: id,
              number: number,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bimbingan ${number.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "Tanggal bimbingan $createdAt",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
