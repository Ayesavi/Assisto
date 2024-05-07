import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/widgets/filter_widget/filter_widget.dart';
import 'package:flutter/material.dart';

class TaskFilterWidget extends StatelessWidget {
  final void Function(List filters) onSelected;
  const TaskFilterWidget({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterWidget<TaskFilterType>(
      filters: const [
        TaskFilterType.all,
        TaskFilterType.deadline,
        TaskFilterType.location,
        TaskFilterType.you,
        TaskFilterType.bidded
      ],
      filterLabel: (t) {
        switch (t) {
          case TaskFilterType.location:
            return 'Location';
          case TaskFilterType.bidded:
            return 'Bidded';
          case TaskFilterType.deadline:
            return 'Deadline';
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
        TaskFilterType.all: [TaskFilterType.you],
        TaskFilterType.bidded: [TaskFilterType.you]
      },
    );
  }
}
