import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    // Handle delete
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var dateText = _addDashIfNeeded(newText);
    return newValue.copyWith(
      text: dateText,
      selection: TextSelection.collapsed(
        offset: dateText.length,
      ),
    );
  }

  String _addDashIfNeeded(String text) {
    text = text.replaceAll('-', '');
    if (text.length > 2 && !text.contains('-')) {
      // Add slash after day and month
      text =
          '${text.substring(0, 2)}-${text.substring(2, text.length > 4 ? 4 : text.length)}${text.length > 4 ? '-${text.substring(4, text.length)}' : ''}';
    }
    return text;
  }
}
