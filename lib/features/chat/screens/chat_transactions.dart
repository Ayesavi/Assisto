import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/transaction_tile.dart/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatTransactionsPage extends ConsumerWidget {
  final String recipientId;

  const ChatTransactionsPage({super.key, required this.recipientId});

  @override
  Widget build(BuildContext context, ref) {
    final List<TransactionModel> models = [
      TransactionModel(
        id: '1',
        recipient: const TransactionUserModel(
          name: 'Alice',
          id: '1001',
          avatarUrl: 'https://example.com/avatar/alice.jpg',
        ),
        sender: const TransactionUserModel(
          name: 'Bob',
          id: '2001',
          avatarUrl: 'https://example.com/avatar/bob.jpg',
        ),
        amount: 100,
        createdAt: DateTime(2024, 5, 10, 13, 30), // Example date and time
        paymentStatus: PaymentStatus.completed,
      ),
      TransactionModel(
        id: '2',
        recipient: TransactionUserModel(
          name: 'Charlie',
          id: Supabase.instance.client.auth.currentUser?.id ?? '',
          avatarUrl: 'https://example.com/avatar/charlie.jpg',
        ),
        sender: const TransactionUserModel(
          name: 'David',
          id: '2002',
          avatarUrl: 'https://example.com/avatar/david.jpg',
        ),
        amount: 200,
        createdAt: DateTime(2024, 5, 11, 10, 15), // Example date and time
        paymentStatus: PaymentStatus.pending,
      ),
      TransactionModel(
        id: '3',
        recipient: const TransactionUserModel(
          name: 'Eve',
          id: '1003',
          avatarUrl: 'https://example.com/avatar/eve.jpg',
        ),
        sender: const TransactionUserModel(
          name: 'Frank',
          id: '2003',
          avatarUrl: 'https://example.com/avatar/frank.jpg',
        ),
        amount: 150,
        createdAt: DateTime(2024, 5, 12, 9, 45), // Example date and time
        paymentStatus: PaymentStatus.failed,
      ),
      TransactionModel(
        id: '4',
        recipient: const TransactionUserModel(
          name: 'Grace',
          id: '1004',
          avatarUrl: 'https://example.com/avatar/grace.jpg',
        ),
        sender: const TransactionUserModel(
          name: 'Henry',
          id: '2004',
          avatarUrl: 'https://example.com/avatar/henry.jpg',
        ),
        amount: 300,
        createdAt: DateTime(2024, 5, 13, 11, 20), // Example date and time
        paymentStatus: PaymentStatus.completed,
      ),
      TransactionModel(
        id: '5',
        recipient: const TransactionUserModel(
          name: 'Ivy',
          id: '1005',
          avatarUrl: 'https://example.com/avatar/ivy.jpg',
        ),
        sender: const TransactionUserModel(
          name: 'Jack',
          id: '2005',
          avatarUrl: 'https://example.com/avatar/jack.jpg',
        ),
        amount: 250,
        createdAt: DateTime(2024, 5, 14, 15, 10), // Example date and time
        paymentStatus: PaymentStatus.pending,
      ),
    ];

    // Group the sorted list by month and year
    Map<String, List<TransactionModel>> groupedDates = {};
    for (var txnModel in models) {
      String k = DateFormat('MMMM yyyy').format(txnModel.createdAt);
      if (!groupedDates.containsKey(k)) {
        groupedDates[k] = [];
      }
      groupedDates[k]?.add(txnModel);
    }

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
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
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: LabelLarge(
                  text: monthYear,
                  // style: const TextStyle(fontSize: 20),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dates.length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionTile(txnModel: models[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
