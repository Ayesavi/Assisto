import 'package:intl/intl.dart';

extension CustomDateTimeFormatting on DateTime {
  String formattedDateTime() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final localDateTime = toLocal();

    if (localDateTime.day == today.day &&
        localDateTime.month == today.month &&
        localDateTime.year == today.year) {
      return 'Today ${DateFormat('hh:mm a').format(localDateTime)}';
    } else if (localDateTime.isAtSameMomentAs(yesterday)) {
      return 'Yesterday ${DateFormat('hh:mm a').format(localDateTime)}';
    } else if (localDateTime.day == tomorrow.day &&
        localDateTime.month == tomorrow.month &&
        localDateTime.year == tomorrow.year) {
      return 'Tomorrow ${DateFormat('hh:mm a').format(localDateTime)}';
    } else {
      return DateFormat('dd MMM yyyy hh:mm a').format(localDateTime);
    }
  }
}
