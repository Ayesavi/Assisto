import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringBidTile extends StatelessWidget {
  const ShimmeringBidTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
