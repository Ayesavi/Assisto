part of 'view_tasks_page_controller.dart';

@freezed
sealed class ViewTasksPageControllerState with _$ViewTasksPageControllerState {
  const factory ViewTasksPageControllerState.loading() = HomePageStateLoading;
  const factory ViewTasksPageControllerState.tasks(
          List<TaskModel> models, List<TaskFilterType> filters) =
      HomePageStateTasks;
  const factory ViewTasksPageControllerState.error(Object e) = _Error;
  const factory ViewTasksPageControllerState.networkError() = _NetworkError;
}

extension ViewTasksPageControllerStateX on ViewTasksPageControllerState {
  bool get isLoading => this is HomePageStateLoading;
  bool get isTasks => this is HomePageStateTasks;
  bool get isError => this is _Error;
  bool get isNetworkError => this is _NetworkError;
}
