import 'package:assisto/core/extensions/colorscheme_extension.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void showTransactionPopup(BuildContext context, TransactionModel transaction) {
  Color getStatusColor(String status) {
    switch (status) {
      case 'success':
        return Theme.of(context).colorScheme.appGreen(context).color;
      case 'pending':
        return Theme.of(context).colorScheme.appYellow(context).color;
      case 'failed':
        return Theme.of(context).colorScheme.appRed(context).color;
      default:
        return Colors.black;
    }
  }

  TextStyle boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Theme.of(context).colorScheme.onSurface);
  TextStyle regularStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 16);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Transaction Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: transaction.id));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Transaction ID copied to clipboard')),
                );
              },
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Transaction ID: ', style: boldStyle),
                    TextSpan(text: transaction.id, style: regularStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Amount: ', style: boldStyle),
                  TextSpan(
                      text:
                          '$kRupeeSymbol${transaction.amount.toStringAsFixed(2)}',
                      style: regularStyle),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Date: ', style: boldStyle),
                  TextSpan(
                      text: DateFormat('MMM dd, yyyy')
                          .format(transaction.createdAt),
                      style: regularStyle),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Status: ', style: boldStyle),
                  TextSpan(
                    text: transaction.paymentStatus.name.capitalizWords,
                    style: regularStyle.copyWith(
                      color: getStatusColor(transaction.paymentStatus.name),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
