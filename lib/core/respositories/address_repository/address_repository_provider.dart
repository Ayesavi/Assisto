import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/respositories/address_repository/base_address_repository.dart';
import 'package:assisto/core/respositories/address_repository/fake_address_repository.dart';
import 'package:assisto/core/respositories/address_repository/supabase_address_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final addressRepositoryProvider = Provider<BaseAddressRepository>((ref) {
  return FlavorConfig().useFakeRepositories
      ? FakeAddressRepository()
      : SupabaseAddressRepository();
});
