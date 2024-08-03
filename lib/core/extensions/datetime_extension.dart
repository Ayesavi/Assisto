import 'package:intl/intl.dart';

extension CustomDateTimeFormatting on DateTime {
  String formattedDateTime() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (day == today.day && month == today.month && year == today.year) {
      return 'Today ${DateFormat('hh:mm a').format(this)}';
    } else if (isAtSameMomentAs(yesterday)) {
      return 'Yesterday ${DateFormat('hh:mm a').format(this)}';
    } else if (day == tomorrow.day &&
        month == tomorrow.month &&
        year == tomorrow.year) {
      return 'Tomorrow ${DateFormat('hh:mm a').format(this)}';
    } else {
      return DateFormat('dd MMM yyyy hh:mm a').format(this);
    }
  }
}
