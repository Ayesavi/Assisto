import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/controllers/internet_connectivity_provider/internet_connectivity_provider.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/address_repository.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_page_controller.freezed.dart';
part 'address_page_controller.g.dart';
part 'address_page_controller_state.dart';

@riverpod
class AddressPageController extends _$AddressPageController {
  List<AddressModel> _addresses = [];
  final _repo = SupabaseAddressRepository();

  @override
  AddressPageControllerState build() {
    ref.watch(internetConnectivityProvider);
    fetchAddresses();
    return const _Loading();
  }

  void fetchAddresses() async {
    try {
      _addresses = await _repo.fetchAddresses();
      state = _Data(_addresses);
    } catch (e) {
      state = _Error(e);
    }
  }

  Future<void> deleteAddress(BuildContext context, int addressId) async {
    try {
      await _repo.deleteAddress(addressId);
      _addresses.removeWhere((address) => address.id == addressId);
      state = _Data(_addresses);
      ref.invalidate(addressControllerProvider);
      return;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, appErrorHandler(e).message);
      }
    }
  }

  Future<void> updateAddress(
      BuildContext context, AddressModel updatedAddress) async {
    try {
      await _repo.updateAddress(updatedAddress);
      final index =
          _addresses.indexWhere((address) => address.id == updatedAddress.id);
      if (index != -1) {
        _addresses[index] = updatedAddress;
        state = _Data(_addresses);
      }
      ref.invalidate(addressControllerProvider);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, appErrorHandler(e).message);
      }
    }
  }

  Future<void> addAddress(BuildContext context, AddressModel newAddress) async {
    try {
      final model = await _repo.addAddress(newAddress);
      _addresses.add(model);
      state = _Data(_addresses);
      ref.invalidate(addressControllerProvider);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, appErrorHandler(e).message);
      }
    }
  }
}
