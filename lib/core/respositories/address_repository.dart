import 'package:assisto/models/address_model/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAddressRepository {
  Future<List<AddressModel>> fetchAddresses();

  Future<AddressModel> getAddressById(int id);

  Future<AddressModel> addAddress(AddressModel address);

  Future<void> updateAddress(AddressModel address);

  Future<void> deleteAddress(int id);
}

class FakeAddressRepository implements BaseAddressRepository {
  @override
  Future<AddressModel> addAddress(AddressModel address) {
    // Simulate adding address to a fake database
    return Future.delayed(const Duration(seconds: 1), () => address);
  }

  @override
  Future<void> deleteAddress(int id) {
    // Simulate deleting address from a fake database
    return Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Future<List<AddressModel>> fetchAddresses() {
    // Simulate fetching addresses from a fake database
    return Future.delayed(
        const Duration(seconds: 1),
        () => [
              AddressModel(
                label: 'home',
                houseNo: '4',
                address: '123 Main St',
                latlng: (lat: 0.0, lng: 0.0),
                createdAt: DateTime.now(),
                id: 1,
              )
            ]);
  }

  @override
  Future<AddressModel> getAddressById(int id) {
    // Simulate getting an address by ID from a fake database
    return Future.delayed(
        const Duration(seconds: 1),
        () => AddressModel(
              houseNo: '2',
              label: 'home',
              address: '123 Main St',
              latlng: (lat: 0.0, lng: 0.0),
              createdAt: DateTime.now(),
              id: id,
            ));
  }

  @override
  Future<void> updateAddress(AddressModel address) {
    // Simulate updating an address in a fake database
    return Future.delayed(const Duration(seconds: 1), () {});
  }
}

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
