class Schema {
  static final String schedule = "schedule";
  static final String vote = "vote";
}

class ScheduleProposed {
  final DateTime schedule;
  final List<int> vote;

  ScheduleProposed({
    required this.schedule,
    this.vote = const [],
  });

  Map<String, Object?> toJson() => {
    Schema.schedule: this.schedule.toIso8601String(),
    Schema.vote: this.vote ?? []
  };

  static ScheduleProposed fromJson(Map<String, Object?> json) => ScheduleProposed(
    schedule: DateTime.parse(json[Schema.schedule] as String),
    vote: json[Schema.vote] as List<int>
  );

  int getTotalVote() {
    return this.vote.length;
  }
}