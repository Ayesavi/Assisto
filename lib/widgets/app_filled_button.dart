import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppFilledButton extends ConsumerWidget {
  AppFilledButton({
    super.key,
    required this.label,
    this.bgColor,
    this.onTap,
    this.asyncTap,
  });

  final progressIndicatorProvider = StateProvider<bool>((ref) => false);

  final String label;
  final Color? bgColor;
  final VoidCallback? onTap;
  final Future<void> Function()? asyncTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if progress is ongoing
    final isProgress = ref.watch(progressIndicatorProvider);
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          onPressed: () async {
            if (onTap != null) {
              onTap!();
            } else if (asyncTap != null && isProgress == false) {
              try {
                // Start showing CircularProgressIndicator
                if (ref.context.mounted) {
                  ref
                      .read(progressIndicatorProvider.notifier)
                      .update((state) => true);
                  // Call the asyncTap
                  asyncTap!().then((value) {
                    if (ref.context.mounted) {
                      ref.read(progressIndicatorProvider.notifier).state =
                          false;
                    }
                  });
                }
                // Stop showing CircularProgressIndicator
              } catch (e) {
                if (ref.context.mounted) {
                  ref.read(progressIndicatorProvider.notifier).state = false;
                }
                rethrow;
              }
            }
          },
          child: isProgress
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleLarge(
                      text: label,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CupertinoActivityIndicator(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ) // Show progress row if in progress
              : TitleLarge(
                  text: label,
                  color: Theme.of(context).colorScheme.onPrimary,
                ) // Show label if not in progress

          ),
    );
  }
}
