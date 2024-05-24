import 'package:assisto/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SmallChipWidget extends ConsumerWidget {
  final String label;
  final VoidCallback? onPress;
  final bool selected;
  const SmallChipWidget(
      {super.key, required this.label, this.onPress, this.selected = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 25,
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: onPress,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(label.capitalize,
                  style: TextStyle(
                      color: selected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.onSurface))),
        ));
  }
}
