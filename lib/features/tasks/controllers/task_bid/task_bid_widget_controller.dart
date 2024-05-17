import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/fake_task_repository.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_bid_widget_controller.freezed.dart';
part 'task_bid_widget_controller.g.dart';
part 'task_bid_widget_controller_state.dart';

@riverpod
class TaskBidWidgetController extends _$TaskBidWidgetController {
  final _repository = FakeTaskRepository();

  @override
  TaskBidWidgetControllerState build(int bidId) {
    getBids(bidId);
    return const TaskBidWidgetControllerState.loading();
  }

  Future<void> getBids(int bidId) async {
    try {
      final bids = await _repository.fetchBids(bidId);
      state = TaskBidWidgetControllerState.data(bids);
    } catch (e) {
      if (e is NetworkException) {
        state = const TaskBidWidgetControllerState.networkError();
      } else {
        state = TaskBidWidgetControllerState.error(e);
      }
    }
  }
}
