import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class BidBottomSheet extends StatelessWidget {
  final TextEditingController amountController;
  final Future<void> Function(int) onPriceEntered;

  const BidBottomSheet(
      {super.key,
      required this.amountController,
      required this.onPriceEntered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: TitleMedium(
              text: 'Bidding Amount',
              weight: FontWeight.bold,
            ),
            subtitle: Text(
                'Enter the bidding amount for the task to be bid, It can not be edited later.'),
          ),
          const SizedBox(height: 16),
          TextField(
            autofocus: true,
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          AppFilledButton(
            asyncTap: () async {
              final amount = int.parse(amountController.text);
              await onPriceEntered(amount);
            },
            label: ('Place Bidding'),
          ),
        ],
      ),
    );
  }
}

void showBidBottomSheet(BuildContext context,
    {required Future<void> Function(int) onPriceEntered,
    required TextEditingController amountController}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
        ),
        child: BidBottomSheet(
          onPriceEntered: onPriceEntered,
          amountController: amountController,
        ),
      );
    },
  );
}
