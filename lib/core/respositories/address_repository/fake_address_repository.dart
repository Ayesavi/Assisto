
import 'package:assisto/core/respositories/address_repository/base_address_repository.dart';
import 'package:assisto/models/address_model/address_model.dart';

class FakeAddressRepository implements BaseAddressRepository {
  // Private constructor
  FakeAddressRepository._();

  // Singleton instance
  static final FakeAddressRepository _instance = FakeAddressRepository._();

  // Getter for singleton instance
  factory FakeAddressRepository() => _instance;

  final List<AddressModel> _addresses = [
    AddressModel(
      label: 'home',
      houseNumber: '4',
      address: '123 Main St',
      latlng: (lat: 0.0, lng: 0.0),
      id: 1,
    ),
    AddressModel(
      label: 'home',
      houseNumber: '90',
      address: '3 Main St',
      latlng: (lat: 0.0, lng: 0.0),
      id: 2,
    )
  ];

  @override
  Future<AddressModel> addAddress(AddressModel address) {
    // Simulate adding address to a fake database
    final newAddress = address.copyWith(id: _getNextId());
    _addresses.add(newAddress);
    return Future.delayed(const Duration(seconds: 1), () => newAddress);
  }

  @override
  Future<void> deleteAddress(int id) {
    // Simulate deleting address from a fake database
    _addresses.removeWhere((address) => address.id == id);
    return Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Future<List<AddressModel>> fetchAddresses() {
    // Simulate fetching addresses from a fake database
    return Future.delayed(
        const Duration(seconds: 1), () => _addresses.toList());
  }

  @override
  Future<AddressModel> getAddressById(int id) {
    // Simulate getting an address by ID from a fake database
    final address = _addresses.firstWhere(
      (address) => address.id == id,
    );
    return Future.delayed(
      const Duration(seconds: 1),
      () => address,
    );
  }

  @override
  Future<void> updateAddress(AddressModel address) {
    // Simulate updating an address in a fake database
    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      _addresses[index] = address;
    }
    return Future.delayed(const Duration(seconds: 1), () {});
  }

  int _getNextId() {
    if (_addresses.isEmpty) {
      return 1;
    } else {
      return _addresses
              .map((address) => address.id)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }
  }
}