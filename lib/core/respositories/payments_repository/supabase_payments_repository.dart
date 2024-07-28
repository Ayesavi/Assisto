import 'package:assisto/core/respositories/payments_repository/base_payments_repository.dart';
import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePaymentsRepository extends BasePaymentsRepository {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  SupabasePaymentsRepository();

  @override
  Future<List<TransactionModel>> getTransactions(
      String recipientId, int limit, int offset) async {
    final response = await supabaseClient
        .from('user_payments')
        .select(
            'id,created_at,amt,status,recipient:to_user_id(id,full_name,avatar_url,status),sender:from_user_id(id,full_name,avatar_url,status)')
        .or('from_user_id.eq.$recipientId,to_user_id.eq.$recipientId')
        .range(offset, limit + offset);

    if (response.isNotEmpty) {
      return response.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<TransactionModel>> getUserTransactions(
      int limit, int offset) async {
    final response = await supabaseClient
        .from('user_payments')
        .select(
            'id,created_at,amt,status,recipient:to_user_id(id,full_name,avatar_url,status),sender:from_user_id(id,full_name,avatar_url,status)')
        .range(offset, limit + offset);

    if (response.isNotEmpty) {
      return response.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
