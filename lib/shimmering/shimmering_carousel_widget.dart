import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringCarouselWidget extends StatelessWidget {
  final int itemCount; // Number of shimmering items to display
  final double aspectRatio; // Aspect ratio for the shimmering containers

  const ShimmeringCarouselWidget({
    super.key,
    this.itemCount = 5,
    this.aspectRatio = 16 / 6,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Shimmering Carousel
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: CarouselSlider.builder(
            itemCount: itemCount,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: aspectRatio,
              viewportFraction: 0.8,
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
        // Shimmering Dots
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(itemCount, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
