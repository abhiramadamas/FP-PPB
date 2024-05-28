// screen_a.dart
import 'package:flutter/material.dart';
import 'package:logprota/ui/views/usulan_ta.dart';

class TugasAkhir extends StatefulWidget {
  const TugasAkhir({Key? key}) : super(key: key);

  @override
  State<TugasAkhir> createState() => _TugasAkhirState();
}

class _TugasAkhirState extends State<TugasAkhir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text(
          "Tugas Akhir",
        ),
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
                      Text(
                        'Menu'
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Serba-serbi tugas akhir anda",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Catatan Penelitian dan Bimbingan'
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Tugas Akhir Saya",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21.0),
                      ),
                      const Text(
                        "Status ajuan tugas akhir saya",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => UsulanTA()));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Buat Usulan'
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         "Hello to First Screen",
      //         style: TextStyle(
      //           fontSize: 20,
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Center(
      //         child: ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => UsulanTA()));
      //           },
      //           child: Text(
      //             "First Screen",
      //             style: TextStyle(
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.bold
      //             ),
      //           ),
      //         ),
      //       ),
      //     ]
      // ),

    );
  }
}