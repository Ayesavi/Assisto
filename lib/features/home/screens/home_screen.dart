import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/home/controllers/home_page_controller.dart';
import 'package:assisto/features/home/screens/home_appbar_title.dart';
import 'package:assisto/features/tasks/screens/create_task_page.dart';
import 'package:assisto/shimmering/shimmering_task_tile.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/small_chip_widget.dart';
import 'package:assisto/widgets/task_tile.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _FilterType { location, deadline, all }

final _filterProvider = StateProvider((ref) => _FilterType.all);

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
                        child: Builder(builder: (context) {
                          final state = ref.watch(_filterProvider);
                          return Row(
                            children: [
                              SmallChipWidget(
                                onPress: () {
                                  ref
                                      .read(_filterProvider.notifier)
                                      .update((state) => _FilterType.all);
                                  controller.loadData();
                                },
                                label: 'All',
                                selected: state == _FilterType.all,
                              ),
                              SmallChipWidget(
                                onPress: () {
                                  ref
                                      .read(_filterProvider.notifier)
                                      .update((state) => _FilterType.deadline);
                                  controller.loadData();
                                },
                                label: 'Deadline',
                                selected: state == _FilterType.deadline,
                              ),
                              SmallChipWidget(
                                selected: state == _FilterType.location,
                                onPress: () {
                                  ref
                                      .read(_filterProvider.notifier)
                                      .update((state) => _FilterType.location);
                                  controller.loadData();
                                },
                                label: 'Location',
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: UserAvatar.currentUser(
                        ref,
                        onPressed: () async {
                          const ProfilePageRoute().push(context);
                        },
                      ))
                ],
              ),
              Builder(
                builder: (context) {
                  final state = ref.watch(homePageControllerProvider);

                  return state.when(loading: () {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ...List.generate(
                              12, (index) => const ShimmeringTaskTile())
                        ],
                      ),
                    );
                  }, data: (data) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate((ctx, index) {
                      return TaskTile(taskModel: data[index], onPressed: () {});
                    }, childCount: data.length));
                  }, error: (e) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Ooops An Error Occurred'),
                      ),
                    );
                  }, networkError: () {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ...List.generate(
                              12, (index) => const ShimmeringTaskTile())
                        ],
                      ),
                    );
                  });
                },
              )
            ],
          ),
        ));
  }
}
