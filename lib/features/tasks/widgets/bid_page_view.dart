import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/tasks/controllers/task_bid/task_bid_widget_controller.dart';
import 'package:assisto/features/tasks/widgets/bidder_profile_bottomsheet.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/bid_tile/bid_tile.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BidPageView extends ConsumerStatefulWidget {
  final TaskModel model;
  final int? offerId;

  const BidPageView(this.model, {this.offerId, super.key});

  @override
  _BidPageViewState createState() => _BidPageViewState();
}

class _BidPageViewState extends ConsumerState<BidPageView> {
  late final TaskBidWidgetControllerProvider provider;
  @override
  void initState() {
    provider = taskBidWidgetControllerProvider(widget.model.id);
    _showObtainedOfferFromPath();
    super.initState();
  }

  _showObtainedOfferFromPath() async {
    if (widget.offerId != null) {
      final model =
          await ref.read(provider.notifier).getBidDetails(widget.offerId!);
      if (context.mounted) {
        showBidderProfileBottomSheet(
          context: context,
          onAcceptOffer: () async {
            await ref.read(provider.notifier).acceptBid(widget.offerId!);
            AppAnalytics.instance.logEvent(
              name: AnalyticsEvent.taskProfile.acceptBidPressEvent,
            );
            if (context.mounted) {
              HomeRoute().replace(context);
            }
            return;
          },
          model: model,
          showAcceptOffer: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleLarge(
          text: 'Offers',
          weight: FontWeight.bold,
        ),
        kWidgetVerticalGap,
        state.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          data: (bids) {
            return Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {},
                    child: ListView.builder(
                      itemCount: bids.length,
                      itemBuilder: (context, index) {
                        return BidTile(
                          bidModel: bids[index],
                          onPressed: () {
                            showBidderProfileBottomSheet(
                              context: context,
                              onAcceptOffer: () async {
                                await controller.acceptBid(bids[index].id);
                                AppAnalytics.instance.logEvent(
                                  name: AnalyticsEvent
                                      .taskProfile.acceptBidPressEvent,
                                );
                                if (context.mounted) {
                                   HomeRoute().replace(context);
                                }
                                return;
                              },
                              model: bids[index],
                              showAcceptOffer: true,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (bids.isEmpty)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.square(
                            dimension: 200,
                            child: SvgPicture.asset(
                                'assets/graphics/no_offers.svg'),
                          ),
                          kWidgetVerticalGap,
                          const Text('No offers yet to display'),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
          networkError: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (e) {
            return Text(e.toString());
          },
        ),
      ],
    );
  }
}
