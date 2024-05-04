part of 'task_bid_widget_controller.dart';

@freezed
sealed class TaskBidWidgetControllerState with _$TaskBidWidgetControllerState {
  const TaskBidWidgetControllerState._();
  const factory TaskBidWidgetControllerState.loading() =
      TaskBidWidgetControllerLoading;
  const factory TaskBidWidgetControllerState.data(List<BidModel> bids) =
      TaskBidWidgetControllerData;
  const factory TaskBidWidgetControllerState.networkError() =
      TaskBidWidgetControllerNetworkError;
  const factory TaskBidWidgetControllerState.error(Object error) =
      TaskBidWidgetControllerError; // replace /* your data type here */ with the actual type

  // Add more factory constructors as needed for other states
}

extension TaskBidWidgetControllerStateX on TaskBidWidgetControllerState {
  bool get isLoading => this is TaskBidWidgetControllerLoading;
  bool get isData => this is TaskBidWidgetControllerData;
  bool get isNetworkError => this is TaskBidWidgetControllerNetworkError;
  bool get isError => this is TaskBidWidgetControllerError;
}
