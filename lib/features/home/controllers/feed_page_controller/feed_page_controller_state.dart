part of 'feed_page_controller.dart';

@freezed
sealed class FeedPageControllerState with _$FeedPageControllerState {
  const FeedPageControllerState._();
  const factory FeedPageControllerState.loading() = FeedPageLoadingState;
  const factory FeedPageControllerState.data(List<TaskModel> data) = FeedPageDataState;
  const factory FeedPageControllerState.error(AppException) = FeedPageErrorState;
  const factory FeedPageControllerState.networkError() = FeedPageNetworkErrorState;

}
