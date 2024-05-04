part of 'task_page_controller.dart';

@freezed
sealed class TaskPageControllerState with _$TaskPageControllerState {
  const TaskPageControllerState._();
  const factory TaskPageControllerState.loading() = TaskPageControllerLoading;
  const factory TaskPageControllerState.initial() = TaskPageControllerInitial;
  const factory TaskPageControllerState.error(Object e) =
      TaskPageControllerError;
  const factory TaskPageControllerState.networkError() =
      TaskPageControllerNetworkError;
}

extension TaskPageControllerStateX on TaskPageControllerState {
  bool get isLoading => this is TaskPageControllerLoading;
  bool get isInitial => this is TaskPageControllerInitial;
  bool get isError => this is TaskPageControllerError;
  bool get isNetworkError => this is TaskPageControllerNetworkError;
}
