


import 'package:assisto/core/respositories/address_repository/base_address_repository.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAddressRepository implements BaseAddressRepository {
  final _supabase = Supabase.instance.client;
  final _table = 'addresses';

  @override
  Future<AddressModel> addAddress(AddressModel address) async {
    final json = address.toSupaJson();
    return AddressModel.fromJson(
        await _supabase.from(_table).insert(json).select().single());
  }

  @override
  Future<void> deleteAddress(int id) async {
    await _supabase.from(_table).delete().eq('id', id);
  }

  @override
  Future<List<AddressModel>> fetchAddresses() async {
    return (await _supabase.from(_table).select('*'))
        .map((e) => AddressModel.fromJson(e))
        .toList();
  }

  @override
  Future<AddressModel> getAddressById(int id) async {
    final json = await _supabase.from(_table).select('*').eq('id', id).single();
    return AddressModel.fromJson(json);
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    final json = address.toSupaJson();
    await _supabase.from(_table).update(json).eq('id', address.id);
  }
}
