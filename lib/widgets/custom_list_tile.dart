import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final bool enabled;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle = const SizedBox.shrink(),
    this.trailing,
    this.onTap,
    this.dense = false,
    this.contentPadding,
    this.backgroundColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // leading ?? const SizedBox(),
              // const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title,
                    const SizedBox(height: 4),
                    subtitle,
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (trailing != null) ...[
                trailing!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}
