import 'package:assisto/core/extensions/datetime_extension.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

class TaskProfilePageView extends ConsumerWidget {
  final TaskModel model;
  const TaskProfilePageView(this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTaskAssigned = model.status != TaskStatus.unassigned;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLarge(
            text: model.title,
            weight: FontWeight.bold,
          ),
          kWidgetMinVerticalGap,
          ReadMoreText(model.description),
          CupertinoListSection(
            backgroundColor: Theme.of(context).canvasColor,
            children: [
              if (model.address != null)
                CupertinoListTile(
                  onTap: () {
                    //todo: open at map center
                  },
                  padding: const EdgeInsets.all(5),
                  leading: Icon(Icons.near_me_outlined,
                      color: Theme.of(context).colorScheme.tertiary),
                  title: const TitleMedium(text: 'Location'),
                  subtitle: BodyMedium(text: model.address!.address),
                  additionalInfo: BodyLarge(
                    text: '${model.distance!.toInt().toString()} Kms',
                  ),
                  trailing: const CupertinoListTileChevron(),
                ),
              CupertinoListTile(
                padding: const EdgeInsets.all(5),
                leading: Icon(Icons.lock_clock,
                    color: Theme.of(context).colorScheme.tertiary),
                title: const TitleMedium(text: 'Deadline'),
                additionalInfo: BodyLarge(
                  text: model.deadline!.formattedDateTime(),
                ),
              ),
              if (model.expectedPrice != null)
                CupertinoListTile(
                  padding: const EdgeInsets.all(5),
                  leading: Icon(Icons.person_outline_outlined,
                      color: Theme.of(context).colorScheme.tertiary),
                  title: const TitleMedium(text: 'Max Budget'),
                  additionalInfo: BodyLarge(
                    text:
                        '${model.expectedPrice!.toString().capitalize} $kRupeeSymbol',
                  ),
                ),
              if (model.ageGroup != null)
                CupertinoListTile(
                  padding: const EdgeInsets.all(5),
                  leading: Icon(Icons.person_outline_outlined,
                      color: Theme.of(context).colorScheme.tertiary),
                  title: const TitleMedium(text: 'Only Age Between'),
                  additionalInfo: BodyLarge(
                    text:
                        '${model.ageGroup!.toString().replaceAll('-', ' to ').capitalize} years',
                  ),
                ),
            ],
          ),
          CupertinoListSection(
              header: const TitleLarge(
                text: 'Tags',
                weight: FontWeight.bold,
              ),
              // hasLeading: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              children: [
                CupertinoListTile(
                  padding: const EdgeInsets.all(5),
                  leading: Icon(
                    Icons.tag,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  title: Wrap(
                    spacing: 8.0,
                    children: [
                      ...model.tags.map(
                        (tag) => Chip(
                          side: BorderSide.none,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary.tone(80),
                          label: Text(
                            tag,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
          kWidgetVerticalGap,
          if (isTaskAssigned && model.isUserTaskUser)
            AppFilledButton(label: 'Mark as completed')
        ],
      ),
    );
  }
}
