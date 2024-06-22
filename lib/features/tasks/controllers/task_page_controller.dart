import 'package:assisto/core/respositories/task_repository/supabase_task_repository.dart';
import 'package:assisto/features/home/controllers/home_page_controller.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_page_controller.freezed.dart';
part 'task_page_controller.g.dart';
part 'task_page_controller_state.dart';

@riverpod
class TaskPageController extends _$TaskPageController {
  final _repository = SupabaseTaskRepository();

  @override
  TaskPageControllerState build() {
    return const TaskPageControllerState.loading();
  }

  Future<void> createTask(TaskModel model) async {
    await _repository.addTask(model);
    ref.invalidate(homePageControllerProvider);

    return;
  }

  Future<void> updateTask(TaskModel model) async {
    await _repository.updateTask(model);
    ref.invalidate(homePageControllerProvider);

    return;
  }
}
