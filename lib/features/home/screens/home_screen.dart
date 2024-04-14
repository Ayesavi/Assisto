import 'package:assisto/core/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          await ref.read(authControllerProvider).signOut();
        },
        child: const Text('Remove Sessions'),
      )),
    );
  }
}
