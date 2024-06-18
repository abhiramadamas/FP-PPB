import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logprota/services/tugasakhir_service.dart';
import 'package:logprota/ui/views/home/home_page.dart';
import 'package:logprota/ui/views/logbook/logbook_page.dart';
import 'package:logprota/ui/views/berita/berita_page.dart';
import 'package:logprota/ui/views/schedule/dosen/schedule_page.dart';
import 'package:logprota/ui/views/tugas_akhir.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainNavigation extends StatefulWidget {
  final User user;
  const MainNavigation({super.key, required this.user});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentPageIndex = 0;
  //sign out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final TugasakhirService firestoreService = TugasakhirService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const [
          Text("Home"),
          Text("Tugas Akhir"),
          Text("Logbook"),
          Text("Berita"),
          Text("Jadwal Bimbingan")
        ][currentPageIndex],
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.message),
            icon: Icon(Icons.book_outlined),
            label: 'Tugas Akhir',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.message),
            icon: Icon(Icons.note_outlined),
            label: 'Logbook',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.message),
            icon: Icon(Icons.newspaper),
            label: 'Berita',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.message),
            icon: Icon(Icons.calendar_month),
            label: 'Jadwal',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTugasAkhirStream(widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            const Center(child: Text("Terjadi Kesalahan"));
          }
          String? docId;
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            DocumentSnapshot document = snapshot.data!.docs[0];
            docId = document.id;
          }
          return [
            const HomePage(),
            TugasAkhir(userId: widget.user.uid),
            LogbookPage(tugasAkhirId: docId),
            BeritaPage(userEmail: widget.user.email!),
            const SchedulePage(),
          ][currentPageIndex];
        },
      ),
    );
  }
}
