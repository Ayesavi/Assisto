import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

void showBidderProfileBottomSheet(
    {required BuildContext context,
    required BidModel model,
    bool showAcceptOffer = false}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (BuildContext context) {
      return BidderProfileBottomSheet(
        model: model,
        showAcceptOffer: showAcceptOffer,
      );
    },
  );
}

class BidderProfileBottomSheet extends StatelessWidget {
  final BidModel model;
  final bool showAcceptOffer;

  const BidderProfileBottomSheet({
    super.key,
    this.showAcceptOffer = false,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UserAvatar(
                      imageUrl: (model.bidder.avatarUrl),
                    ),
                    kWidgetHorizontalGap,
                    TitleLarge(
                      text: model.bidder.name.capitalizWords,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8)),
                  child: LabelMedium(
                      text: '${model.amount.toString()} $kRupeeSymbol',
                      color: Theme.of(context).colorScheme.onPrimary),
                )
              ],
            ),
            if (model.bidder.description != null) ...[
              kWidgetMinVerticalGap,
              ReadMoreText(
                model.bidder.description!.capitalize,
                trimLines: 3,
              ),
            ],
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const TitleMedium(
                text: 'Age',
                weight: FontWeight.w500,
              ),
              trailing: BodyLarge(text: model.bidder.age.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.male),
              title: const TitleMedium(
                text: 'Gender',
                weight: FontWeight.w500,
              ),
              trailing: BodyLarge(text: model.bidder.gender.capitalize),
            ),
            if (showAcceptOffer)
              AppFilledButton(
                  asyncTap: () async {
                    await showPopup(
                      context,
                      title: 'Accept Offer',
                      content:
                          "Are you sure you want to accept this offer by ${model.bidder.name.capitalize}?",
                      onConfirm: () async {
                        await Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      },
                    );

                    await Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                    return;
                  },
                  label: 'Accept Offer'),
          ],
        ),
      ),
    );
  }
}
