import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/core/utils/utils.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskTile extends ConsumerWidget {
  final TaskModel taskModel;
  final VoidCallback onPressed;
  const TaskTile({super.key, required this.taskModel, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distance = taskModel.distance?.toInt();
    return ListTile(
      onTap: onPressed,
      leading: UserAvatar(
        imageUrl: taskModel.owner.imageUrl,
        radius: 30,
      ),
      title: TitleMedium(
        weight: FontWeight.bold,
        text: taskModel.title.capitalize,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelLarge(
            text: taskModel.description.capitalize,
            maxLines: 2,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
            weight: FontWeight.w500,
          ),
          if (taskModel.distance != null) ...[
            const SizedBox(
              height: 4,
            ),
          ]
        ],
      ),
      trailing: taskModel.deadline != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8)),
                  child: LabelMedium(
                      text: formatTime(
                        taskModel.deadline!,
                      ),
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                if (taskModel.distance != null) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      LabelMedium(
                        text: '${distance.toString()} km\'s',
                        weight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.outline.tone(50),
                      )
                    ],
                  )
                ]
              ],
            )
          : null,
    );
  }
}
