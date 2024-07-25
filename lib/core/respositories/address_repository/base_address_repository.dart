import 'package:assisto/models/address_model/address_model.dart';

abstract class BaseAddressRepository {
  Future<List<AddressModel>> fetchAddresses();

  Future<AddressModel> getAddressById(int id);

  Future<AddressModel> addAddress(AddressModel address);

  Future<void> updateAddress(AddressModel address);

  Future<void> deleteAddress(int id);
}
