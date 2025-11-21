import 'package:intl/intl.dart';

extension DateTimeFormattingX on DateTime {
  String toShortDate() => DateFormat('EEE, MMM d').format(this);

  String toHourMinute() => DateFormat('hh:mm a').format(this);
}
