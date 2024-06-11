class User {
  final int? id;
  final String name;
  final String registration_code;
  final String type;

  User({
    this.id,
    required this.name,
    required this.registration_code,
    required this.type
  });
}