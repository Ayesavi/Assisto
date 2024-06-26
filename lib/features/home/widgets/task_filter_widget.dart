import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/widgets/filter_widget/filter_widget.dart';
import 'package:flutter/material.dart';

class TaskFilterWidget extends StatelessWidget {
  final void Function(List filters) onSelected;
  const TaskFilterWidget({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterWidget(
      filters: const [
        TaskFilterType.all,
        TaskFilterType.you,
        TaskFilterType.bidded
      ],
      filterLabel: (t) {
        switch (t) {
          case TaskFilterType.bidded:
            return 'Bidded';

          case TaskFilterType.all:
            return 'All';
          case TaskFilterType.you:
            return 'By you';
        }
      },
      allowMultipleSelection: true,
      onSelected: onSelected,
      collisionMap: const {
        TaskFilterType.you: [TaskFilterType.all, TaskFilterType.bidded],
        TaskFilterType.all: [TaskFilterType.you, TaskFilterType.bidded],
        TaskFilterType.bidded: [TaskFilterType.you, TaskFilterType.all]
      },
    );
  }
}
