import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringServiceList extends StatelessWidget {
  final int itemCount;

  const ShimmeringServiceList({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return SizedBox(
      height: 150.0, // Height of the horizontal list
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 140.0, // Width of each service widget
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // Changes position of shadow
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 80.0, // Width of each service widget
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // Changes position of shadow
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 120.0, // Width of each service widget
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // Changes position of shadow
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmeringServicePlaceholderWidget extends StatelessWidget {
  const ShimmeringServicePlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 120.0, // Width of each service widget
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
