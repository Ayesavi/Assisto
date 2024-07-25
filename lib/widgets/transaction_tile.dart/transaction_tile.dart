import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/extensions/colorscheme_extension.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionTile extends ConsumerWidget {
  final TransactionModel txnModel;
  final VoidCallBack? onPress;
  const TransactionTile({
    super.key,
    required this.txnModel,
    this.onPress,
  });

  Widget _getTrailingWidget(BuildContext context, String? userId) {
    if (txnModel.paymentStatus == PaymentStatus.success) {
      final amountIsCredited = txnModel.recipient.id != userId ? false : true;
      if (amountIsCredited) {
        return TitleMedium(
          text: '+ $kRupeeSymbol${txnModel.amount}',
          color: Theme.of(context).colorScheme.appGreen(context).color,
        );
      } else {
        return TitleMedium(
          text: '- $kRupeeSymbol${txnModel.amount}',
          color: Theme.of(context).colorScheme.appRed(context).color,
        );
      }
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleMedium(text: '$kRupeeSymbol${txnModel.amount}'),
          const SizedBox(
            height: 5,
          ),
          Text(
            txnModel.paymentStatus.name.capitalize,
            style: TextStyle(
                fontSize: 12,
                color: PaymentStatus.pending == txnModel.paymentStatus
                    ? Theme.of(context).colorScheme.appYellow(context).color
                    : Theme.of(context).colorScheme.appRed(context).color),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authControllerProvider.notifier).user?.id;
    final userModel =
        txnModel.recipient.id != userId ? txnModel.recipient : txnModel.sender;

    final String formattedDateTime =
        DateFormat('MMMM yyyy, hh:mm a').format(txnModel.createdAt.toLocal());
    return ListTile(
      onTap: onPress,
      leading: UserAvatar(
        radius: 20,
        imageUrl: userModel.avatarUrl,
      ),
      title: Text(
        userModel.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(formattedDateTime),
      trailing: _getTrailingWidget(context, userId),
    );
  }
}
