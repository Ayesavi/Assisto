part of 'home_page_controller.dart';

@freezed
sealed class HomePageControllerState with _$HomePageControllerState {
  const factory HomePageControllerState.loading() = _Loading;
  const factory HomePageControllerState.ownTasks(List<TaskModel> models) = _OwnTasks;
  const factory HomePageControllerState.tasks(List<TaskModel> models) = _Tasks;

  const factory HomePageControllerState.error(Object e) = _Error;
  const factory HomePageControllerState.networkError() = _NetworkError;
}

extension HomePageControllerStateX on HomePageControllerState {
  bool get isLoading => this is _Loading;
  bool get isOwnTasks => this is _OwnTasks;
  bool get isOtherTasks => this is _Tasks;
  bool get isBiddedTasks => this is _Tasks;
  bool get isError => this is _Error;
  bool get isNetworkError => this is _NetworkError;
}
