import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/tasks/controllers/task_bid/task_bid_widget_controller.dart';
import 'package:assisto/features/tasks/widgets/bidder_profile_bottomsheet.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/bid_tile/bid_tile.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BidPageView extends ConsumerWidget {
  final TaskModel model;
  const BidPageView(this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskBidWidgetControllerProvider(model.id));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleLarge(
          text: 'Offers',
          weight: FontWeight.bold,
        ),
        kWidgetVerticalGap,
        state.when(loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, data: (bids) {
          return Expanded(
            child: ListView.builder(
              itemCount: bids.length,
              itemBuilder: (context, index) {
                return BidTile(
                    bidModel: bids[index],
                    onPressed: () {
                      showBidderProfileBottomSheet(
                          context: context, model: bids[index]);
                    });
              },
            ),
          );
        }, networkError: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, error: (e) {
          return Text(e.toString());
        })
      ],
    );
  }
}
