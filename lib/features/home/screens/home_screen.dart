import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/home/controllers/home_page_controller.dart';
import 'package:assisto/features/home/screens/home_appbar_title.dart';
import 'package:assisto/features/home/widgets/task_filter_widget.dart';
import 'package:assisto/features/tasks/screens/create_task_page.dart';
import 'package:assisto/features/tasks/widgets/bidder_profile_bottomsheet.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/shimmering/shimmering_task_tile.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/task_tile/task_tile.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TaskFilterType { location, deadline, all, you }

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.read(homePageControllerProvider.notifier);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const TaskCreationPage();
              },
            ));
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
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
                            TaskFilterWidget(onSelected: (selectedFilters) {
                              if (selectedFilters
                                  .contains(TaskFilterType.you)) {
                                controller.loadOwnTasks();
                              } else {
                                controller.loadData();
                              }
                            }),
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
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.bell)),
                          UserAvatar.currentUser(
                            ref,
                            onPressed: () async {
                              const ProfilePageRoute().push(context);
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
                    ownTasks: (List<TaskModel> models) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate((ctx, index) {
                        return TaskTile.owner(
                            taskModel: models[index],
                            onAvatarPressed: () {
                              if (models[index].bid != null) {
                                showBidderProfileBottomSheet(
                                    context: context,
                                    model: models[index].bid!);
                              }
                            },
                            onPressed: () {
                              TaskProfileRoute(taskId: models[index].id)
                                  .push(ctx);
                            });
                      }, childCount: models.length));
                    },
                    tasks: (data) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate((ctx, index) {
                        return TaskTile(
                            taskModel: data[index],
                            onPressed: () {
                              TaskProfileRoute(taskId: data[index].id)
                                  .push(ctx);
                            });
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
