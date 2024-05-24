import 'package:flutter/material.dart';

class LogbookPage extends StatelessWidget {
  const LogbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Logbook TA",
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
                      const Text(
                        "Judul Tugas Akhir Anda",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Sistem Rekomendasi Berbasis Website Untuk Pemilihan Program Keterampilan SMA/MA Double Track dengan Metode AHP'
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Pembimbingan Dosen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21.0),
                      ),
                      SizedBox(height: 10.0),
                      LogbookItemCard(
                          createdAt: "29 April 2024 15.30", number: 3),
                      SizedBox(height: 8.0),
                      LogbookItemCard(
                          createdAt: "29 April 2024 12.15", number: 2),
                      SizedBox(height: 8.0),
                      LogbookItemCard(
                          createdAt: "13 Maret 2024 13.30", number: 1),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Tambah Bimbingan"),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class LogbookItemCard extends StatelessWidget {
  final String createdAt;
  final int number;
  const LogbookItemCard(
      {super.key, required this.createdAt, required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("hello tanpped");
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
