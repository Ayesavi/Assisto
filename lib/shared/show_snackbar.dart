import 'package:flutter/material.dart';

showSnackBar(BuildContext context, [String? content, SnackBarAction? action]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content ?? "An error Occurred"),
    // showCloseIcon: true,
    behavior: SnackBarBehavior.fixed,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    action: action,
    dismissDirection: DismissDirection.horizontal,
  ));
}
