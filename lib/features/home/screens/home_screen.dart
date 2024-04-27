import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign Out'),
          onPressed: () {
            ref.read(authControllerProvider.notifier).signOut();
          },
        ),
      ),
    );
  }
}
