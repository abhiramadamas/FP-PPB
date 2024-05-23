import 'package:flutter/material.dart';

class LogbookPage extends StatelessWidget {
  const LogbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LogProTA",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Catatan Penelitian dan Pembimbingan",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Judul Tugas Akhir Anda"),
                    Text(
                      "Judul Tugas Akhir yang ada di MyITS Thesis",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
