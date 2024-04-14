
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, [String? content]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content ?? "An error Occurred"),
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
  ));
}
