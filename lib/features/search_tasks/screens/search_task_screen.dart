import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/search_tasks/controllers/search_task_page_controller/search_task_page_controller.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/widgets/common_network_error_widget/common_network_error_widget.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/task_tile/task_tile.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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
        
        title: const HeadlineSmall(
          text: 'Search',
          weight: FontWeight.bold,
        ),
      ),
      body: state.when(
        initial: () {
          return Stack(
            children: [
              _buildCustomScrollView(
                controller,
                state,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox.square(
                        dimension: 200,
                        child: SvgPicture.asset(Assets.graphics.search)),
                    const SizedBox(height: 30),
                    Text(
                      'Waiting for you to search...',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
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
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(Assets.lottie.searching),
                    const SizedBox(height: 10),
                    Text(
                      'Searching...',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        networkError: () {
          return _buildCustomScrollView(controller, state,
              child: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CommonNetworkErrorWidget(
                      onReload: () {
                        controller.search(_searchController.text);
                      },
                    ),
                  )));
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
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                          dimension: 200,
                          child: SvgPicture.asset(Assets.graphics.emptyList)),
                      kWidgetVerticalGap,
                      const Text(
                        'No tasks found',
                      ),
                    ],
                  ),
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
          if (child != null) ...[
            SliverPadding(
              padding: const EdgeInsets.only(top: 16.0),
              sliver: child,
            ),
          ]
        ],
      ),
    );
  }
}
