import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/task_repository_provider.dart';
import 'package:assisto/features/home/controllers/home_page_controller.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_bid_widget_controller.freezed.dart';
part 'task_bid_widget_controller.g.dart';
part 'task_bid_widget_controller_state.dart';

@riverpod
class TaskBidWidgetController extends _$TaskBidWidgetController {
  late final BaseTaskRepository _repository;

  @override
  TaskBidWidgetControllerState build(int bidId) {
    _repository = ref.watch(taskRepositoryProvider);

    getBids(bidId);
    return const TaskBidWidgetControllerState.loading();
  }

  Future<void> getBids(int taskId) async {
    try {
      final bids = await _repository.fetchBids(taskId);
      state = TaskBidWidgetControllerState.data(bids);
    } catch (e) {
      if (e is NetworkException) {
        state = const TaskBidWidgetControllerState.networkError();
      } else {
        state = TaskBidWidgetControllerState.error(e);
      }
    }
  }

  Future<void> acceptBid(int bidId) async {
    try {
      await _repository.acceptBid(bidId);
      ref.invalidate(homePageControllerProvider);
      return;
    } catch (e) {
      throw const AppException(
          'Could not accept offer at the moment, try again later');
    }
  }

  Future<BidModel> getBidDetails(int id) async {
    return await _repository.fetchBidById(id);
  }
}
