import 'package:google_maps_flutter/google_maps_flutter.dart';

const kCenterLatlng = LatLng(21.2514, 81.6296);
Map<String, dynamic> ignoreNullFields(Map<String, dynamic> inputMap) {
  final Map<String, dynamic> resultMap = {};

  inputMap.forEach((key, value) {
    if (value != null) {
      if (value is Map<String, dynamic>) {
        // If the value is a map, recursively apply ignoreNullFields
        final nestedMap = ignoreNullFields(value);
        // If the nested map is not empty, add it to the result map
        if (nestedMap.isNotEmpty) {
          resultMap[key] = nestedMap;
        }
      } else {
        // If the value is not null and not a map, add it to the result map
        resultMap[key] = value;
      }
    }
  });

  return resultMap;
}

bool checkNullOrEmpty(List<dynamic> params) {
  for (var param in params) {
    if (param == null || param.toString().isEmpty) {
      return true; // Return true if any parameter is null or empty
    }
  }
  return false; // Return false if all parameters are non-null and non-empty
}

int calculateAgeFromString(String birthDateString) {
  final now = DateTime.now();
  final parts = birthDateString.split('/');
  if (parts.length != 3) {
    throw ArgumentError(
        'Invalid date format. Please provide date in dd/mm/yyyy format.');
  }
  final birthDate =
      DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age;
}

String formatTime(DateTime dateTime) {
  // Extract hour, minute, and second from the DateTime object
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  // Determine if it's AM or PM

  String period = hour < 12 ? 'AM' : 'PM';

  // Convert hour from 24-hour format to 12-hour format if needed
  if (hour > 12) {
    hour -= 12;
  }

  // Convert hour, minute, and second to strings and pad with leading zeros if necessary
  String hourStr = hour.toString().padLeft(2, '0');
  String minuteStr = minute.toString().padLeft(2, '0');

  // Concatenate all parts and return the formatted string
  return '$hourStr:$minuteStr $period';
}
