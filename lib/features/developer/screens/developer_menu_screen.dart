import 'package:flutter/material.dart';

class DeveloperMenuPage extends StatelessWidget {
  const DeveloperMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Menu'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Check Crashlytics'),
            onTap: () {
              // Perform a test crash here
              // This is just a demonstration, replace with actual code to crash the app
              throw Exception(
                  'This is a test crash triggered by the developer menu');
            },
          ),
          // Add more ListTile widgets for additional developer options if needed
        ],
      ),
    );
  }
}
