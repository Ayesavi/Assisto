import 'package:assisto/models/transaction_model/transaction_model.dart';

abstract class BasePaymentsRepository {
  // Abstract function to get transactions
  Future<List<TransactionModel>> getTransactions(
      String recipientId, int limit, int offset);

  // Abstract function to get user transactions
  Future<List<TransactionModel>> getUserTransactions(int limit, int offset);
}
