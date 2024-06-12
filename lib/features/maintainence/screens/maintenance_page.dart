import 'package:assisto/core/app_config/app_config_service.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class MaintenancePage extends ConsumerWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppFilledButton(
          // onPressed: () {
          //   // Handle "Contact Us" button press (e.g., open email app)
          // },
          label: ('Contact Us'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _handleRefresh(ref),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false, // Prevent default scrolling behavior
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Assets.lottie.appUnderMaintainence,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'We\'re under maintenance!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      '  We\'re currently working on some improvements and will be back soon. Please check back later.   ',
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
    AppConfigService.fetchAndSettle();
    ref.invalidate(appConfigKeysProvider);
  }
}
