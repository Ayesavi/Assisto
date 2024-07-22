import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

void showBidderProfileBottomSheet({
  required BuildContext context,
  required BidModel model,
  required Future<void> Function()? onAcceptOffer,
  bool showAcceptOffer = false,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return BidderProfileBottomSheet(
        model: model,
        onAcceptOffer: onAcceptOffer,
        showAcceptOffer: showAcceptOffer,
      );
    },
  );
}

class BidderProfileBottomSheet extends StatelessWidget {
  final BidModel model;
  final bool showAcceptOffer;
  final Future<void> Function()? onAcceptOffer;

  const BidderProfileBottomSheet({
    super.key,
    this.onAcceptOffer,
    this.showAcceptOffer = false,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(imageUrl: model.bidder.avatarUrl),
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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: LabelMedium(
                  text: '${model.amount.toString()} $kRupeeSymbol',
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          if (model.bidder.description != null) ...[
            kWidgetMinVerticalGap,
            ReadMoreText(
              model.bidder.description!.capitalize,
              trimLines: 3,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
          ListTile(
            leading: const Icon(Icons.male),
            title: const TitleMedium(
              text: 'Gender',
              weight: FontWeight.w500,
            ),
            trailing: BodyLarge(text: model.bidder.gender.capitalize),
          ),
          if (showAcceptOffer)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AppFilledButton(
                onTap: () async {
                  Navigator.pop(context);

                  await showPopup(
                    context,
                    title: 'Accept Offer',
                    content:
                        "Are you sure you want to accept this offer by ${model.bidder.name.capitalize}?",
                    onConfirm: () async {
                      try {
                        await onAcceptOffer?.call();
                        Navigator.pop(context);
                      } catch (e) {
                        Navigator.pop(context);
                        showSnackBar(context, appErrorHandler(e).message);
                      }
                    },
                  );
                },
                label: 'Accept Offer',
              ),
            ),
        ],
      ),
    );
  }
}
