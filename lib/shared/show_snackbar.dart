import 'package:flutter/material.dart';

showSnackBar(BuildContext context, [String? content, SnackBarAction? action]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content ?? "An error Occurred"),
    // showCloseIcon: true,
    behavior: SnackBarBehavior.fixed,
    action: action,
    dismissDirection: DismissDirection.down,
  ));
}
