import 'package:assisto/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringOnMapAddressWidget extends StatelessWidget {
  const ShimmeringOnMapAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Icon(
                Icons.near_me_outlined,
                color: theme.colorScheme.primary,
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: double.infinity,
                height: 14,
                color: Colors.white,
              ),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: double.infinity,
                height: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          AppFilledButton(
            label: 'Continue',
            isDisabled: true,
          )
        ],
      ),
    );
  }
}
