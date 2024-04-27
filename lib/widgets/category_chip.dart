import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData? icon;
  final VoidCallback? onTap;

  const ChipWidget({
    super.key,
    required this.label,
    this.onTap,
    required this.isSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      onTap: onTap,
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        label: LabelLarge(
          text: label.capitalize,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.tone(70),
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        avatar: icon != null
            ? Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              )
            : null,
      ),
    );
  }
}
