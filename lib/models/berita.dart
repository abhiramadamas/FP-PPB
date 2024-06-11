import 'package:cloud_firestore/cloud_firestore.dart';

class Berita {
  String note;
  String judul;
  String departemen;
  Timestamp? createdAt;

  Berita({
    required this.note,
    required this.judul,
    required this.departemen,
    this.createdAt,
  });

  Berita.fromJson(Map<String, Object?> json)
      : this(
    note: json["note"]! as String,
    judul: json["judul"]! as String,
    departemen: json["departemen"]! as String,
    createdAt: json["createdAt"]! as Timestamp,
  );

  Berita copyWith({
    String? note,
    String? judul,
    String? departemen,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Berita(
      note: note ?? this.note,
      judul: judul ?? this.judul,
      departemen: departemen ?? this.departemen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'note': note,
      'judul': judul,
      'departemen': departemen,
      'createdAt': createdAt,
    };
  }
}
