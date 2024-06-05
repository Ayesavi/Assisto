import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/home/controllers/home_page_controller.dart';
import 'package:assisto/features/home/screens/home_appbar_title.dart';
import 'package:assisto/features/home/widgets/task_filter_widget.dart';
import 'package:assisto/features/tasks/widgets/bidder_profile_bottomsheet.dart';
import 'package:assisto/shimmering/shimmering_task_tile.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/task_tile/task_tile.dart';
import 'package:assisto/widgets/task_tile/tile_status.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

enum TaskFilterType {
  /// order tasks by location
  location,

  /// order tasks by deadline
  deadline,

  /// order tasks by nothing returns all tasks
  all,

  /// Return all tasks created by the user accomodated with other filters if speicified
  you,

  /// Return all tasks created by others in which the user has bidded in
  bidded
}

List<TaskFilterType> _filters = [];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(homePageControllerProvider.notifier);
    final analytics = AppAnalytics.instance;
    const analyticsEvents = AnalyticsEvent.home;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            analytics.logEvent(name: analyticsEvents.createTaskFABEvent);
            const CreateTaskRoute().go(context);
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData(_filters);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                title: const HomeAppBarTitle(),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight + 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: SearchTextField(
                          hintTexts: ['Washing', 'Cooking'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TaskFilterWidget(
                                  onSelected: (selectedFilters) {
                                final taskFilters = selectedFilters
                                    .map((filter) => filter as TaskFilterType)
                                    .toList();

                                _filters = taskFilters;
                                analytics.logEvent(
                                    name: analyticsEvents.taskFilterTypeEvent,
                                    parameters: {
                                      'filters':
                                          _filters.map((e) => e.name).join(',')
                                    });
                                // controller.loadData(taskFilters);
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                const NotificationPageRoute().go(context);
                              },
                              icon: const Icon(CupertinoIcons.bell)),
                          UserAvatar.currentUser(
                            ref,
                            onPressed: () async {
                              const ProfilePageRoute().go(context);
                            },
                          ),
                        ],
                      ))
                ],
              ),
              Builder(
                builder: (context) {
                  final state = ref.watch(homePageControllerProvider);

                  return state.when(
                    loading: () {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ...List.generate(
                                12, (index) => const ShimmeringTaskTile())
                          ],
                        ),
                      );
                    },
                    tasks: (data, filters) {
                      if (data.isEmpty) {
                        return SliverToBoxAdapter(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            SizedBox.square(
                              dimension: 200,
                              child: SvgPicture.asset(
                                  'assets/graphics/empty_list.svg'),
                            ),
                            kWidgetVerticalGap,
                            const Text(
                              'No tasks found',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ));
                      }
                      return SliverList(
                          delegate: SliverChildBuilderDelegate((ctx, index) {
                        if (filters.contains(TaskFilterType.you)) {
                          return TaskTile.owner(
                              taskModel: data[index],
                              onAvatarPressed: () {
                                if (data[index].bid != null) {
                                  showBidderProfileBottomSheet(
                                      context: context,
                                      model: data[index].bid!,
                                      onAcceptOffer: () async {});
                                }
                              },
                              onPressed: () {
                                TaskProfileRoute(taskId: data[index].id)
                                    .push(ctx);
                              });
                        } else {
                          return TaskTile(
                              taskModel: data[index],
                              trailing: filters.contains(TaskFilterType.bidded)
                                  ? TileStatusWidget(data[index].status)
                                  : null,
                              onPressed: () {
                                TaskProfileRoute(taskId: data[index].id)
                                    .push(ctx);
                              });
                        }
                      }, childCount: data.length));
                    },
                    error: (e) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text('Ooops An Error Occurred'),
                        ),
                      );
                    },
                    networkError: () {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ...List.generate(
                                12, (index) => const ShimmeringTaskTile())
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}
