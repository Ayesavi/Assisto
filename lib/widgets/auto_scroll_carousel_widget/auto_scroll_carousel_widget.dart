import 'package:assisto/models/carousel_item_model/carousel_item_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AutoScrollCarousel extends StatefulWidget {
  final List<CarouselItem> items;
  final Function(CarouselItem, dynamic) onPressParams;
  final Duration autoScrollDuration;

  const AutoScrollCarousel({
    super.key,
    required this.items,
    required this.onPressParams,
    this.autoScrollDuration = const Duration(seconds: 3),
  });

  @override
  _AutoScrollCarouselState createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends State<AutoScrollCarousel> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider.builder(
            itemCount: widget.items.length,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: widget.autoScrollDuration,
              enlargeCenterPage: true,
              aspectRatio: 16 / 6,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final item = widget.items[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: GestureDetector(
                  onTap: () => widget.onPressParams(item, {}),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                item.subtitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = entry.key;
                });
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
