import 'package:assisto/core/remote_config/remote_config_service.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AppRequiresUpdatePage extends ConsumerWidget {
  const AppRequiresUpdatePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          onPressed: () {
            // TODO: Implement the logic to navigate to the Play Store
          },
          child: const Text('Visit Play Store'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _handleRefresh(ref),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Assets.lottie.appRequiresUpdate,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Oops, looks like you are missing something',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      'Please update your app to enjoy the best possible services.',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh(WidgetRef ref) async {
    await RemoteConfigService.fetchAndSettle();
  }
}
