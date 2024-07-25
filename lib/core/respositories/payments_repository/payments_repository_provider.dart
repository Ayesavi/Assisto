import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/respositories/payments_repository/base_payments_repository.dart';
import 'package:assisto/core/respositories/payments_repository/fake_payments_repository.dart';
import 'package:assisto/core/respositories/payments_repository/supabase_payments_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<BasePaymentsRepository> paymentsRepositoryProvider = Provider((ref) =>
    FlavorConfig().useFakeRepositories
        ? FakePaymentsRepository()
        : SupabasePaymentsRepository());
