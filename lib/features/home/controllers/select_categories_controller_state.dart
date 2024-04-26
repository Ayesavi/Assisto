part of 'select_categories_controller.dart';

@freezed
sealed class SelectCategoriesControllerState
    with _$SelectCategoriesControllerState {
  const SelectCategoriesControllerState._();
  const factory SelectCategoriesControllerState.loading() = _Loading;
  const factory SelectCategoriesControllerState.data(
      List<ServiceCategoryModel> categories, List<ServiceCategoryModel> selected) = _Data;
  const factory SelectCategoriesControllerState.error() = _Error;
  const factory SelectCategoriesControllerState.networkError() = _NetworkError;
}

extension SelectCategoriesControllerStateX on SelectCategoriesControllerState {
  bool get isLoading => this is _Loading;
  bool get isData => this is _Data;
  bool get isError => this is _Error;
  bool get isNetworkError => this is _NetworkError;
}
