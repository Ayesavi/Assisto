import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class TileStatusWidget extends StatelessWidget {
  const TileStatusWidget(this.status, {super.key});

  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final containerScheme = _getColorForStatus(status, isDarkTheme);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: containerScheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: LabelSmall(
        text: status.name.toUpperCase(),
        color: containerScheme.onColor,
      ),
    );
  }

  ColorFamily _getColorForStatus(TaskStatus status,
      [bool isDarkTheme = false]) {
    switch (status) {
      case TaskStatus.assigned:
        if (isDarkTheme) {
          return MaterialTheme.lushGreen.dark;
        }
        return MaterialTheme.lushGreen.light;
      case TaskStatus.unassigned:
        if (isDarkTheme) {
          return MaterialTheme.yellow.dark;
        }
        return MaterialTheme.yellow.light;
      case TaskStatus.completed:
        if (isDarkTheme) {
          final scheme = MaterialTheme.darkScheme();
          return ColorFamily(
              color: scheme.primary,
              onColor: scheme.onPrimary,
              colorContainer: scheme.primaryContainer,
              onColorContainer: scheme.onPrimaryContainer);
        }
        final scheme = MaterialTheme.lightScheme();
        return ColorFamily(
            color: scheme.primary,
            onColor: scheme.onPrimary,
            colorContainer: scheme.primaryContainer,
            onColorContainer: scheme.onPrimaryContainer);
      case TaskStatus.paid:
        if (isDarkTheme) {
          return MaterialTheme.green.dark;
        }
        return MaterialTheme.green.light;
    }
  }
}
