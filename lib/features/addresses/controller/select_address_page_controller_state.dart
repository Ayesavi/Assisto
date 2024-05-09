// ignore_for_file: unused_element

part of 'select_address_page_controller.dart';

class _MapConfig {
  final CameraPosition cameraPosition;
  final String? style;
  final Marker? marker;
  final bool enableLocation;
  final AddressModel? addressModel;
  final places.PlacesSearchResult? pickResult;
  const _MapConfig({
    required this.cameraPosition,
    this.marker,
    this.pickResult,
    this.enableLocation = false,
    this.style,
    this.addressModel,
  });
}

@freezed
sealed class SelectAddressPageControllerState
    with _$SelectAddressPageControllerState {
  const SelectAddressPageControllerState._();
  const factory SelectAddressPageControllerState.initial() =
      SelectAddressPageControllerInitial;
  const factory SelectAddressPageControllerState.error(AppException error) =
      SelectAddressPageControllerError;
  const factory SelectAddressPageControllerState.networkError() =
      SelectAddressPageControllerNetworkError;
  const factory SelectAddressPageControllerState.loadMap(_MapConfig config) =
      SelectAddressPageControllerLoadMap;
}

extension SelectAddressPageControllerStateX
    on SelectAddressPageControllerState {
  bool get isInitial => this is SelectAddressPageControllerInitial;
  bool get isError => this is SelectAddressPageControllerError;
  bool get isNetworkError => this is SelectAddressPageControllerNetworkError;
  bool get isLoadMap => this is SelectAddressPageControllerLoadMap;
}
