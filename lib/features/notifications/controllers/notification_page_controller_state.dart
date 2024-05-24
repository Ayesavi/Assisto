part of 'notification_page_controller.dart';

@freezed
sealed class NotificationPageState with _$NotificationPageState {
  const NotificationPageState._();
  const factory NotificationPageState.loading() = NotificationPageLoadingState;
  const factory NotificationPageState.data(List<NotificationModel> models) = NotificationPageDataState;
  const factory NotificationPageState.error(AppException error) = NotificationPageErrorState;
}

extension NotificationPageControllerStateX on NotificationPageState {
  bool get isLoading => this is NotificationPageLoadingState;
  bool get isData => this is NotificationPageDataState;
  bool get isError => this is NotificationPageErrorState;
}
