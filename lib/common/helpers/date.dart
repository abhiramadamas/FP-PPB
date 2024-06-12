import 'package:intl/intl.dart';

String? datetimeToString(DateTime? time) {
  if(time==null) {
    return null;
  }
  return DateFormat('EEEE, d MMM y HH:mm:ss').format(time);
}

DateTime getOneMonthFromNow() {
  var now = DateTime.now();
  return DateTime(
    now.year,
    now.month + 1,
    now.day,
    now.hour,
    now.minute,
    now.second,
    now.millisecond,
    now.microsecond,
  );
}