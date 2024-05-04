part of 'task_profile_page.dart';

@freezed
sealed class TaskProfilePageState with _$TaskProfilePageState {
  const TaskProfilePageState._();
  const factory TaskProfilePageState.loading() = TaskProfilePageInitial;
  const factory TaskProfilePageState.data(TaskModel model) =
      TaskProfilePageData;
  const factory TaskProfilePageState.error(Object error) = TaskProfilePageError;
  const factory TaskProfilePageState.networkError() =
      TaskProfilePageNetworkError;
}

extension TaskProfilePageStateX on TaskProfilePageState {
  bool get isInitial => this is TaskProfilePageInitial;
  bool get isData => this is TaskProfilePageData;
  bool get isNetworkError => this is TaskProfilePageNetworkError;
  bool get isError => this is TaskProfilePageError;
}
