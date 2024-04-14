import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

showNetworkErrorPopup(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const _NetworkErrorDialog();
    },
  );
}

class _NetworkErrorDialog extends ConsumerWidget {
  const _NetworkErrorDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Not connected to internet'),
      content:
          const Text('Please ensure that you are connected to the internet'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
