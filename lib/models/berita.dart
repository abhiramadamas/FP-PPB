import 'package:cloud_firestore/cloud_firestore.dart';

class Berita {
  String note;
  String judul;
  Timestamp? createdAt;

  Berita({
    required this.note,
    required this.judul,
    this.createdAt,
  });

  Berita.fromJson(Map<String, Object?> json)
      : this(
    note: json["note"]! as String,
    judul: json["judul"]! as String,
    createdAt: json["createdAt"]! as Timestamp,
  );

  Berita copyWith({
    String? note,
    String? judul,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Berita(
      note: note ?? this.note,
      judul: judul ?? this.judul,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'note': note,
      'judul': judul,
      'createdAt': createdAt,
    };
  }
}
