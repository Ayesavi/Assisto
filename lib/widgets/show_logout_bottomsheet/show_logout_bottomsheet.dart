import 'package:flutter/material.dart';

void showLogOutBottomSheet(BuildContext context, VoidCallback onConfirmLogOut,
    VoidCallback onRejectedOne) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Log out',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Are you sure you want to log out?'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onConfirmLogOut,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Yes, Logout'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: onRejectedOne,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    },
  );
}
