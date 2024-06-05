import 'package:cloud_firestore/cloud_firestore.dart';

class Logbook {
  String note;
  Timestamp date;
  Timestamp? createdAt;

  Logbook({
    required this.note,
    required this.date,
    this.createdAt,
  });

  Logbook.fromJson(Map<String, Object?> json)
      : this(
          note: json["note"]! as String,
          date: json["date"]! as Timestamp,
          createdAt: json["createdAt"]! as Timestamp,
        );

  Logbook copyWith({
    String? note,
    Timestamp? date,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Logbook(
      note: note ?? this.note,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'note': note,
      'date': date,
      'createdAt': createdAt,
    };
  }
}
