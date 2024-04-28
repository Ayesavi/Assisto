import 'package:assisto/widgets/text_widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

showLogOutPopup(BuildContext context, {required VoidCallback onConfirm}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutPopup(
        onConfirmLogout: () {
          onConfirm();
        },
      );
    },
  );
}

class LogoutPopup extends StatelessWidget {
  final Function()? onConfirmLogout;

  const LogoutPopup({super.key, this.onConfirmLogout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const TitleLarge(
        text: 'Logout',
        weight: FontWeight.bold,
      ),
      content: const Text('Are you sure you want to logout from this device?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Call the onConfirmLogout callback if provided
            if (onConfirmLogout != null) {
              onConfirmLogout!();
              FirebaseAnalytics.instance.logEvent(name: 'logged_out');
            }
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

showPopup(BuildContext context, {required VoidCallback onConfirm}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Popup(
        onConfirmPopup: () {
          onConfirm();
        },
      );
    },
  );
}

class Popup extends StatelessWidget {
  final Function()? onConfirmPopup;

  const Popup({super.key, this.onConfirmPopup});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const TitleLarge(
        text: 'Delete Address',
        weight: FontWeight.bold,
      ),
      content: const Text('Are you sure you want to delete adddress?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirmPopup,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
