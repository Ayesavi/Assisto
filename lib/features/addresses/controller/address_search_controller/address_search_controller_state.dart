part of 'address_search_controller.dart';

@freezed
sealed class AddressSearchControllerState with _$AddressSearchControllerState {
  const AddressSearchControllerState._();
  const factory AddressSearchControllerState.initial() = AddressSearchControllerInitial;
  const factory AddressSearchControllerState.loading() = AddressSearchControllerLoading;
  const factory AddressSearchControllerState.error(AppException error ) = AddressSearchControllerError;
  const factory AddressSearchControllerState.networkError() = AddressSearchControllerNetworkError;

  const factory AddressSearchControllerState.data(List<PlacesSearchResult> places) = AddressSearchControllerData;


}

extension AddressSearchControllerStateX on AddressSearchControllerState {
  bool get isInitial => this is AddressSearchControllerInitial;
  bool get isLoading => this is AddressSearchControllerLoading;
  bool get isData => this is AddressSearchControllerData;
  bool get isError => this is AddressSearchControllerError;
  bool get isNetworkError => this is AddressSearchControllerNetworkError;
}
