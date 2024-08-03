part of 'home_page_controller.dart';

@freezed
sealed class HomePageControllerState with _$HomePageControllerState {
  const factory HomePageControllerState.loading() = HomePageStateLoading;
  const factory HomePageControllerState.tasks(
      List<TaskModel> models, List<TaskFilterType> filters) = HomePageStateTasks;
  const factory HomePageControllerState.error(Object e) = _Error;
  const factory HomePageControllerState.networkError() = _NetworkError;
}

extension HomePageControllerStateX on HomePageControllerState {
  bool get isLoading => this is HomePageStateLoading;
  bool get isTasks => this is HomePageStateTasks;
  bool get isError => this is _Error;
  bool get isNetworkError => this is _NetworkError;
}
