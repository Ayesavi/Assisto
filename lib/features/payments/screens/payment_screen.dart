import 'package:assisto/features/payments/controllers/payments_page_controller.dart';
import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:assisto/widgets/common_error_widget/common_error_widget.dart';
import 'package:assisto/widgets/common_network_error_widget/common_network_error_widget.dart';
import 'package:assisto/widgets/show_transaction_details_popup/show_transaction_details_popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/transaction_tile.dart/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends ConsumerWidget {
  final String? recipientId;
  const PaymentScreen({super.key, this.recipientId});

  Map<String, List<TransactionModel>> groupDate(List<TransactionModel> models) {
    Map<String, List<TransactionModel>> groupedDates = {};
    for (var txnModel in models) {
      String k = DateFormat('MMMM yyyy').format(txnModel.createdAt);
      if (!groupedDates.containsKey(k)) {
        groupedDates[k] = [];
      }
      groupedDates[k]?.add(txnModel);
    }
    return groupedDates;
  }

  @override
  Widget build(BuildContext context, ref) {
    // Group the sorted list by month and year
    final state = ref.watch(paymentsPageControllerProvider(recipientId));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Payments'),
        ),
        body: state.when(loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, data: (models) {
          final groupedDates = groupDate(models);

          if (models.isEmpty) {
            return const Center(
              child: Text('No Payments Found'),
            );
          }
          return ListView.builder(
            itemCount: groupedDates.length,
            itemBuilder: (BuildContext context, int index) {
              String monthYear = groupedDates.keys.elementAt(index);
              List<TransactionModel> dates = groupedDates[monthYear]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    alignment: Alignment.centerLeft,
                    child: TitleMedium(
                      text: monthYear,
                      weight: FontWeight.w400,
                      // style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TransactionTile(
                        txnModel: models[index],
                        onPress: () {
                          showTransactionPopup(context, models[index]);
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        }, error: (error) {
          return CommonErrorWidget(message: error.message);
        }, networkError: () {
          return CommonNetworkErrorWidget(
            onReload: () {
              ref
                  .read(paymentsPageControllerProvider(recipientId).notifier)
                  .loadData(refresh: true);
            },
          );
        }));
  }
}
