import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/respositories/address_repository.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_controller.freezed.dart';
part 'address_controller.g.dart';
part 'address_controller_state.dart';

@Riverpod(keepAlive: true)
class AddressController extends _$AddressController {
  final _repo = FakeAddressRepository();

  var _addresses = <AddressModel>[];

  AddressModel? _defaultAddress;

  AddressModel? get defaultAddress => _defaultAddress;

  List<AddressModel> get address => _addresses;

  @override
  AddressControllerState build() {
    ref.watch(authStateChangesProvider);
    fetchAddresses();
    return const AddressControllerState.locationNotSet();
  }

  void setLocation(AddressModel addrModel) {
    state = Location(addrModel);
    _defaultAddress = addrModel;
  }

  void fetchAddresses() async {
    final addrs = await Future.delayed(const Duration(seconds: 1), () async {
      return await _repo.fetchAddresses();
    });
    _addresses = addrs;
    if (addrs.isNotEmpty) {
      state = Location(addrs[0]);
    }
    if (addrs.isEmpty) {
      state = const _Empty();
    }
  }
}
