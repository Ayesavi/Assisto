import 'package:assisto/features/home/screens/feed_page.dart';
import 'package:assisto/widgets/filter_widget/filter_widget.dart';
import 'package:flutter/material.dart';

class TaskFilterWidget extends StatelessWidget {
  final void Function(List filters) onSelected;
  const TaskFilterWidget({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      filters: const [
        TaskFilterType.recommended,
        TaskFilterType.you,
        TaskFilterType.bidded
      ],
      filterLabel: (t) {
        switch (t) {
          case TaskFilterType.bidded:
            return 'Bidded';

          case TaskFilterType.recommended:
            return 'recommended';
          case TaskFilterType.you:
            return 'By you';
          default:
            return 'Unknown';
        }
      },
      allowMultipleSelection: true,
      onSelected: onSelected,
      collisionMap: const {
        TaskFilterType.you: [TaskFilterType.recommended, TaskFilterType.bidded],
        TaskFilterType.recommended: [TaskFilterType.you, TaskFilterType.bidded],
        TaskFilterType.bidded: [TaskFilterType.you, TaskFilterType.recommended]
      },
    );
  }
}
