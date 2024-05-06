import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class BidBottomSheet extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final void Function(int) onPriceEntered;

  BidBottomSheet({super.key, required this.onPriceEntered});

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
          TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Amount',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Amount is required';
              }
              // Validate if input contains digits only
              if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                return 'Please enter digits only';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          AppFilledButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Submit bid logic here
                final amount = int.parse(_amountController.text);
                onPriceEntered(amount);
              }
            },
            label: ('Place Bidding'),
          ),
        ],
      ),
    );
  }
}

void showBidBottomSheet(BuildContext context,
    {required void Function(int) onPriceEntered}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
        ),
        child: BidBottomSheet(onPriceEntered: onPriceEntered),
      );
    },
  );
}
