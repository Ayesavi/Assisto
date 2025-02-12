import 'package:assisto/features/home/screens/feed_page.dart';
import 'package:assisto/widgets/small_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateProvider for managing selected filters
final selectedFiltersProvider =
    StateProvider<List<TaskFilterType>>((ref) => [TaskFilterType.recommended]);

class FilterWidget extends ConsumerWidget {
  final List<TaskFilterType> filters;
  final String Function(TaskFilterType) filterLabel;
  final bool allowMultipleSelection;
  final Map<TaskFilterType, List<TaskFilterType>>? collisionMap;
  final void Function(List selectedFilters)? onSelected;
  const FilterWidget({
    super.key,
    required this.filters,
    required this.filterLabel,
    this.onSelected,
    this.allowMultipleSelection = true,
    this.collisionMap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the selected filters from the provider
    final selectedFilters = ref.watch(selectedFiltersProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: SmallChipWidget(
              label: (filterLabel(filter)),
              selected: selectedFilters.contains(filter),
              onPress: () {
                _updateSelectedFilters(ref, filter, filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  void _updateSelectedFilters(
    WidgetRef ref,
    TaskFilterType filter,
    TaskFilterType filterToRemove,
  ) {
    if (!allowMultipleSelection) {
      ref.read(selectedFiltersProvider.notifier).update((state) => [filter]);
      onSelected?.call(ref.read(selectedFiltersProvider));
      return;
    }

    if (collisionMap != null && collisionMap!.containsKey(filter)) {
      final collidedFilters = collisionMap![filter]!;
      if (collidedFilters
          .where(
              (element) => ref.read(selectedFiltersProvider).contains(element))
          .toList()
          .isNotEmpty) {
        ref.read(selectedFiltersProvider.notifier).update((state) {
          final list = List.from(state);
          list.removeWhere((f) => collidedFilters.contains(f));
          return [...list, filter];
        });
        onSelected?.call(ref.read(selectedFiltersProvider));
        return;
      }
    }

    if (ref.read(selectedFiltersProvider).contains(filter)) {
      ref.read(selectedFiltersProvider.notifier).update((state) {
        final list = List<TaskFilterType>.from(state);
        list.remove(filter);
        return list;
      });
    } else {
      ref
          .read(selectedFiltersProvider.notifier)
          .update((state) => [...state, filter]);
    }
    onSelected?.call(ref.read(selectedFiltersProvider));
    return;
  }
}
