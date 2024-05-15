import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/extensions/colorscheme_extension.dart';
import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionTile extends ConsumerWidget {
  final TransactionModel txnModel;
  const TransactionTile({super.key, required this.txnModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authControllerProvider.notifier).user?.id;
    final title = txnModel.recipient.id != userId
        ? txnModel.recipient.name
        : txnModel.sender.name;
    final amountIsCredited = txnModel.recipient.id != userId ? false : true;
    String formattedDateTime =
        DateFormat('MMMM yyyy, hh:mm a').format(txnModel.createdAt.toLocal());
    return ListTile(
      title: TitleMedium(text: title),
      subtitle: Text(formattedDateTime),
      trailing: TitleMedium(
        text: '${amountIsCredited ? '+ ' : '- '}${txnModel.amount}',
        color: amountIsCredited
            ? Theme.of(context).colorScheme.appGreen(context).color
            : Theme.of(context).colorScheme.appRed(context).color,
      ),
    );
  }
}
