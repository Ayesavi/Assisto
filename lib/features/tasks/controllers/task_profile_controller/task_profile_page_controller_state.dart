part of 'task_profile_page_controller.dart';

@freezed
sealed class TaskProfilePageState with _$TaskProfilePageState {
  const TaskProfilePageState._();
  const factory TaskProfilePageState.loading() = TaskProfilePageInitial;
  const factory TaskProfilePageState.taskUserData(TaskModel model) =
      TaskProfilePageOwnerData;
  const factory TaskProfilePageState.taskConsumerData(TaskModel model,BidInfo? info) =
      TaskProfilePageConsumerData;
  const factory TaskProfilePageState.error(Object error) = TaskProfilePageError;
  const factory TaskProfilePageState.networkError() =
      TaskProfilePageNetworkError;
}

extension TaskProfilePageStateX on TaskProfilePageState {
  bool get isInitial => this is TaskProfilePageInitial;
  bool get isTaskUserData => this is TaskProfilePageOwnerData;
  bool get isTaskConsumerData => this is TaskProfilePageConsumerData;
  bool get isNetworkError => this is TaskProfilePageNetworkError;
  bool get isError => this is TaskProfilePageError;
}
