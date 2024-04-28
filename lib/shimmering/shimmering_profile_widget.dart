import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringProfileWidget extends StatelessWidget {
  const ShimmeringProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onInverseSurface.withOpacity(.9),
      highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size.width * 60 / 100,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 14.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: theme.colorScheme.primary,
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                ),
                child: Text(
                  'Edit Profile >',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}