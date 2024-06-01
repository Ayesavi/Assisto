import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/search_tasks/controllers/search_task_page_controller/search_task_page_controller.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/task_tile/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTaskScreen extends ConsumerStatefulWidget {
  const SearchTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchTaskScreenState();
}

class _SearchTaskScreenState extends ConsumerState<SearchTaskScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final SearchTaskPageController controller;

  @override
  void initState() {
    super.initState();
    controller = ref.read(searchTaskPageControllerProvider.notifier);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      // implement pagination
      controller.paginate(_searchController.text);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchTaskPageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: state.when(
        initial: () {
          return Stack(
            children: [
              _buildCustomScrollView(
                controller,
                state,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text('Search Tasks'),
              )
            ],
          );
        },
        loading: () {
          return Stack(
            children: [
              _buildCustomScrollView(
                controller,
                state,
              ),
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            ],
          );
        },
        networkError: () {
          return Stack(
            children: [
              _buildCustomScrollView(
                controller,
                state,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text('Network Error'),
              )
            ],
          );
        },
        error: (error) {
          return Stack(
            children: [
              _buildCustomScrollView(
                controller,
                state,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(error.message),
              )
            ],
          );
        },
        data: (data) {
          return Stack(
            children: [
              _buildCustomScrollView(controller, state,
                  child: Builder(builder: (context) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Build your list item here
                      // Example:
                      if (index == data.length) {
                        // Show loading indicator at the end of the list
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ValueListenableBuilder(
                            valueListenable: controller.isPaginatingNotifier,
                            builder: (BuildContext context, bool isPaginating,
                                Widget? child) {
                              return SizedBox.square(
                                dimension: isPaginating ? 100 : 0,
                                child: isPaginating
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox.shrink(),
                              );
                            },
                          ),
                        );
                      } else {
                        return TaskTile(
                            taskModel: data[index],
                            onPressed: () {
                              TaskProfileRoute(taskId: data[index].id)
                                  .go(context);
                            });
                      }
                    },
                    childCount: data.length + 1,
                  ),
                );
              })),
              if (data.isEmpty)
                const Align(
                  alignment: Alignment.center,
                  child: Text('Empty Search'),
                )
            ],
          );
        },
      ),
    );
  }

  Widget _buildCustomScrollView(
      SearchTaskPageController controller, SearchTaskPageState state,
      {Widget? child}) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.search(_searchController.text);
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SearchTextField(
                      hintTexts: const ['Washing', 'Driving'],
                      textController: _searchController,
                      onSearch: (key) {
                        controller.search(key);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (child != null) child,
        ],
      ),
    );
  }
}
