import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/supabase_task_repository.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_profile_page_controller.freezed.dart';
part 'task_profile_page_controller.g.dart';
part 'task_profile_page_controller_state.dart';

@riverpod
class TaskProfilePage extends _$TaskProfilePage {
  final _repository = SupabaseTaskRepository();
  @override
  TaskProfilePageState build(int taskId) {
    getTaskById(taskId);
    return const TaskProfilePageState.loading();
  }

  Future<void> getTaskById(int id) async {
    try {
      final model = await _repository.getTaskById(id);
      final bidInfo = await _getBidInfo();
      state = model.isUserTaskUser
          ? TaskProfilePageState.taskUserData(model)
          : TaskProfilePageState.taskConsumerData(model, bidInfo);
    } catch (e) {
      if (e is NetworkException) {
        state = const TaskProfilePageState.networkError();
      } else {
        state = TaskProfilePageState.error(appErrorHandler(e));
      }
    }
  }

  placeBid(int amount) async {
    await _repository.placeBid(taskId: taskId, amount: amount);
  }

  Future<BidInfo?> _getBidInfo() async {
    return await _repository.fetchBidInfoOnTask(taskId);
  }
}
