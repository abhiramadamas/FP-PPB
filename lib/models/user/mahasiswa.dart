import 'package:logprota/models/user/user.dart';

class Mahasiswa extends User {
  Mahasiswa({
    required super.registration_code,
    required super.name,
    super.type = 'mahasiswa'
  });
}