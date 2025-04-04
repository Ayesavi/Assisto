import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BidTile extends ConsumerWidget {
  final BidModel bidModel;
  final VoidCallback onPressed;
  const BidTile({super.key, required this.bidModel, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onPressed,
      leading: UserAvatar(
        imageUrl: bidModel.bidder.avatarUrl,
        radius: 25,
      ),
      title: Text(
        bidModel.bidder.name.capitalize,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: bidModel.bidder.description != null
          ? Text(
              bidModel.bidder.description!.capitalize,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8)),
        child: LabelMedium(
            text: '${bidModel.amount.toString()} $kRupeeSymbol',
            color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
