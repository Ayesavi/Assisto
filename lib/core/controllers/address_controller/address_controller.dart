import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/controllers/internet_connectivity_provider/internet_connectivity_provider.dart';
import 'package:assisto/core/respositories/address_repository/address_repository_provider.dart';
import 'package:assisto/core/respositories/address_repository/base_address_repository.dart';
import 'package:assisto/core/services/permission_service/permission_service.dart';
import 'package:assisto/core/services/permission_service/permission_service_provider.dart';
import 'package:assisto/features/addresses/repositories/places_repository.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'address_controller.freezed.dart';
part 'address_controller.g.dart';
part 'address_controller_state.dart';

@Riverpod(keepAlive: true)
class AddressController extends _$AddressController {
  late BaseAddressRepository _repo;
  late BasePlacesRepository _placesRepository;
  late BasePermissionService _permissionService;

  var _addresses = <AddressModel>[];

  AddressModel? _defaultAddress;

  AddressModel? get defaultAddress => _defaultAddress;

  List<AddressModel> get address => _addresses;

  late SharedPreferences _sharedPreferences;
  @override
  AddressControllerState build() {
    ref.watch(authStateChangesProvider);
    ref.watch(internetConnectivityProvider);
    _permissionService = ref.watch(permissionServiceProvider);
    _placesRepository = ref.watch(placesRepositoryProvider);
    _repo = ref.watch(addressRepositoryProvider);

    fetchAddresses();
    return const AddressControllerState.locationNotSet();
  }

  void setLocation(AddressModel addrModel) {
    state = Location(addrModel);
    _defaultAddress = addrModel;
    _sharedPreferences.setInt("default_address_id", addrModel.id);
  }

  void fetchAddresses() async {
    final addrs = await _repo.fetchAddresses();
    _sharedPreferences = await SharedPreferences.getInstance();
    final defaultAddrId = _sharedPreferences.getInt("default_address_id");
    _addresses = addrs;
    if (addrs.isNotEmpty) {
      if (defaultAddrId != null) {
        _defaultAddress =
            addrs.firstWhere((e) => e.id == defaultAddrId, orElse: () {
          return _addresses[0];
        });
        state = AddressControllerState.location(_defaultAddress!);
      } else {
        _defaultAddress = _addresses[0];
        state = AddressControllerState.location(_addresses[0]);
      }
      if (addrs.isEmpty) {
        await setCurrentLocation();
      }
    }
  }

  Future<bool> setCurrentLocation() async {
    try {
      final status = await _permissionService
          .requestPermissionIfNeeded(DevicePermission.location);
      if ([DevicePermissionStatus.granted, DevicePermissionStatus.limited]
          .contains(status)) {
        final pos = await _placesRepository.getCurrentLocation();
        final addr = AddressModel(
            address: "Your current location",
            latlng: (lat: pos.latitude, lng: pos.longitude),
            label: "You",
            houseNumber: "44",
            id: 0);
        setLocation(addr);
        return true;
      } else {
        state = const AddressControllerState.locationPermissionDisabled();
        return false;
      }
    } catch (e) {
      state = const AddressControllerState.locationPermissionDisabled();
      return false;
    }
  }
}
