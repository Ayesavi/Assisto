
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringTextField extends StatelessWidget {
  const ShimmeringTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.cardColor;
    final shimmerColor = theme.splashColor;

    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Shimmer.fromColors(
            baseColor: shimmerColor,
            highlightColor: Colors.white,
            child: Container(
              height: 48.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.45, 0.5, 0.55],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Shimmer.fromColors(
            baseColor: shimmerColor,
            highlightColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 48.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.45, 0.5, 0.55],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Shimmer.fromColors(
            baseColor: shimmerColor,
            highlightColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 48.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.45, 0.5, 0.55],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ]
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}