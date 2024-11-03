import 'package:assisto/core/admob/ad_units.dart';
import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/home/controllers/feed_page_controller/feed_page_controller.dart';
import 'package:assisto/features/home/providers/get_carousel_items_provider.dart';
import 'package:assisto/features/home/screens/home_appbar_title.dart';
import 'package:assisto/features/home/widgets/task_ad_listtile.dart';
import 'package:assisto/features/services/providers/get_services_provider.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/shimmering/shimmering_carousel_widget.dart';
import 'package:assisto/shimmering/shimmering_services_list.dart';
import 'package:assisto/shimmering/shimmering_task_tile.dart';
import 'package:assisto/widgets/auto_scroll_carousel_widget/auto_scroll_carousel_widget.dart';
import 'package:assisto/widgets/common_error_widget/common_error_widget.dart';
import 'package:assisto/widgets/common_network_error_widget/common_network_error_widget.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/services_list_widget/services_list_widget.dart';
import 'package:assisto/widgets/task_tile/task_tile.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

enum TaskFilterType {
  /// order tasks by nothing returns all tasks
  recommended,

  /// Return all tasks created by the user accomodated with other filters if speicified
  you,

  /// Return all tasks created by others in which the user has bidded in
  bidded
}

class HomeFeedPage extends ConsumerStatefulWidget {
  const HomeFeedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends ConsumerState<HomeFeedPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      // implement pagination
      ref.read(feedPageControllerProvider.notifier).paginate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(feedPageControllerProvider.notifier);
    final analytics = AppAnalytics.instance;
    const analyticsEvents = AnalyticsEvent.home;
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        controller.getRecommendations();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            title: const HomeAppBarTitle(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: SearchTextField(
                      onPressed: () {
                        const SearchPageRoute().go(context);
                      },
                      hintTexts: const ['Washing', 'Cooking'],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Tooltip(
                message: 'Settings',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserAvatar.currentUser(
                        ref,
                        onPressed: () async {
                          const ProfilePageRoute().go(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, ref, child) {
                final itemsProvider = ref.watch(getCarouselItemsProvider);
                return itemsProvider.when(
                  data: (data) {
                    return AutoScrollCarousel(
                        items: data, onPressParams: (e, v) {});
                  },
                  error: (error, stackTrace) {
                    return const ShimmeringCarouselWidget();
                  },
                  loading: () {
                    return const ShimmeringCarouselWidget();
                  },
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: Consumer(
            builder: (context, ref, child) {
              final servicesProvider = ref.watch(getServicesProvider);
              return servicesProvider.when(
                  data: (services) {
                    return ServicesList(
                      onPressViewAll: () {
                        const OurServicesPageRoute().go(context);
                      },
                      services: services,
                    );
                  },
                  error: (e, s) {
                    return const ShimmeringServiceList();
                  },
                  loading: () => const ShimmeringServiceList());
            },
          )),
          SliverToBoxAdapter(
              child: Divider(
            thickness: 10,
            color: Theme.of(context).colorScheme.onInverseSurface,
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleLarge(
                    text: "Recommended",
                    weight: FontWeight.bold,
                  ),
                  TextButton(
                      onPressed: () {
                        const ViewTasksPageRoute().go(context);
                      },
                      child: const Text("View All >>"))
                ],
              ),
            ),
          ),
          Builder(
            builder: (context) {
              final state = ref.watch(feedPageControllerProvider);

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
                data: (data) {
                  if (data.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          SizedBox.square(
                            dimension: 200,
                            child: SvgPicture.asset(Assets.graphics.emptyList),
                          ),
                          kWidgetVerticalGap,
                          const Text(
                            'No tasks found',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) {
                        // Calculate the number of ads inserted so far
                        const adInterval = 8;
                        final itemIndex = index - (index ~/ adInterval);

                        // Last index for the loading indicator
                        final lastIndex =
                            data.length + (data.length ~/ adInterval);

                        if (index == lastIndex) {
                          // Show loading indicator at the end of the list
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ValueListenableBuilder(
                              valueListenable: controller.isPaginatingNotifier,
                              builder: (BuildContext context, bool isPaginating,
                                  Widget? child) {
                                return SizedBox.square(
                                  dimension: isPaginating
                                      ? 50
                                      : 0, // Adjust the size if needed
                                  child: isPaginating
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const SizedBox.shrink(),
                                );
                              },
                            ),
                          );
                        } else if (index % adInterval == 0 && index != 0) {
                          // Insert ad widget at every 8th position
                          return TaskAdListTile(
                            adId: AdUnits.homeTasksAdUnit.unitId,
                          );
                        } else {
                          return TaskTile(
                            taskModel: data[itemIndex],
                            onPressed: () {
                              analytics.logEvent(
                                  name:
                                      AnalyticsEvent.home.homeOnPressTaskEvent);
                              TaskProfileRoute(taskId: data[itemIndex].id)
                                  .go(ctx);
                            },
                          );
                        }
                      },
                      childCount: data.length +
                          (data.length ~/ 8) +
                          1, // Adjust the count to include ads and the loading indicator
                    ),
                  );
                },
                error: (e) {
                  return SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonErrorWidget(
                            message: appErrorHandler(e).message)),
                  );
                },
                networkError: () {
                  return SliverToBoxAdapter(child: CommonNetworkErrorWidget(
                    onReload: () {
                      controller.getRecommendations();
                    },
                  ));
                },
              );
            },
          ),
        ],
      ),
    ));
  }
}
