import 'package:flutter/material.dart';

class ValueNotifierFAB extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final VoidCallback onPress;

  const ValueNotifierFAB(
      {super.key, required this.isLoading, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (context, value, child) => FloatingActionButton(
        onPressed: value ? null : onPress, // Disable button if loading
        child: value
            ? const SizedBox.square(
                dimension: 20, child: CircularProgressIndicator())
            : const Icon(Icons.payment_outlined),
      ),
    );
  }
}
