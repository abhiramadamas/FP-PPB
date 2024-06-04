class Schema {
  static final String schedule = "schedule";
  static final String vote = "vote";
}

class ScheduleProposed {
  final DateTime schedule;
  final int? vote;

  ScheduleProposed({
    required this.schedule,
    this.vote,
  });

  Map<String, Object?> toJson() => {
    Schema.schedule: this.schedule.toIso8601String(),
    Schema.vote: this.vote ?? 0
  };

  static ScheduleProposed fromJson(Map<String, Object?> json) => ScheduleProposed(
    schedule: DateTime.parse(json[Schema.schedule] as String),
    vote: json[Schema.vote] as int?
  );
}