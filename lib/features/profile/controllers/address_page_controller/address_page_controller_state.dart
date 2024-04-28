part of 'address_page_controller.dart';

@freezed
sealed class AddressPageControllerState with _$AddressPageControllerState {
  const factory AddressPageControllerState.loading() = _Loading;
  const factory AddressPageControllerState.data(List<AddressModel> models) =
      _Data;
  const factory AddressPageControllerState.error(Object e) = _Error;
}

extension AddressPageControllerStateX on AddressPageControllerState {
  bool get isLoading => this is _Loading;
  bool get isData => this is _Data;
  bool get isError => this is _Error;
}
