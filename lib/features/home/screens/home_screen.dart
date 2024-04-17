import 'package:cloud_functions/cloud_functions.dart';
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
            final data = await FirebaseFunctions.instance.httpsCallableFromUri(
                Uri.parse(
                    'http://localhost:5001/dev-assisto/asia-south1/apiv1/api/data'),
                options: HttpsCallableOptions())();
            print(data.data);
          },
          child: const Text('Call'),
        ),
      ),
    );
  }
}
