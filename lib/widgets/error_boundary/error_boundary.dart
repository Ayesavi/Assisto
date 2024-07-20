import 'package:flutter/material.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final String errorMessage;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorMessage = 'Something went wrong. Please try again later.',
  });

  @override
  _ErrorBoundaryState createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      setState(() {
        hasError = true;
      });
    };
  }

  @override
  void dispose() {
    FlutterError.onError = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    }

    return widget.child;
  }
}
