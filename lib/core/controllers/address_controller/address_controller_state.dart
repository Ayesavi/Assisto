part of 'address_controller.dart';

@freezed
sealed class AddressControllerState with _$AddressControllerState {

    const factory AddressControllerState.locationNotSet() = _Initial;
    const factory AddressControllerState.empty() = _Empty;

    const factory AddressControllerState.location(AddressModel model) = Location;
}

extension AddressControllerStateX on AddressControllerState {
  bool get locationNotSet => this is _Initial;
  bool get empty => this is _Empty;
  bool get location => this is Location;

}
