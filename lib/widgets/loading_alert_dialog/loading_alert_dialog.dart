import 'package:assisto/core/error/handler.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, Future future,
    {VoidCallback? onFinish}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents the dialog from being dismissed
    builder: (BuildContext context) {
      return _LoadingAlertDialog(
        future: future,
        onFinish: onFinish,
      );
    },
  );
}

class _LoadingAlertDialog extends StatefulWidget {
  const _LoadingAlertDialog({super.key, required this.future, this.onFinish});
  final Future future;
  final VoidCallback? onFinish;
  @override
  State<_LoadingAlertDialog> createState() => __LoadingAlertDialogState();
}

class __LoadingAlertDialogState extends State<_LoadingAlertDialog> {
  bool _canPop = false;

  @override
  void initState() {
    widget.future.onError((e, s) async {
      showSnackBar(context, appErrorHandler(e).message);
    });
    widget.future.then((v) {
      widget.onFinish?.call();
    });
    widget.future.whenComplete(() {
      setState(() {
        _canPop = true;
      });
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      child: AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        content: Row(
          children: [
            CircularProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(width: 20),
            const Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
