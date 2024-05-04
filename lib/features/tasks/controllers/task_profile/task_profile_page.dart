import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_profile_page.freezed.dart';
part 'task_profile_page.g.dart';
part 'task_profile_page_state.dart';

@riverpod
class TaskProfilePage extends _$TaskProfilePage {
  final _repository = FakeTaskRepository();
  @override
  TaskProfilePageState build(int taskId) {
    getTaskById(taskId);
    return const TaskProfilePageState.loading();
  }

  Future<void> getTaskById(int id) async {
    try {
      state = TaskProfilePageState.data(await _repository.getTaskById(id));
    } catch (e) {
      if (e is NetworkException) {
        state = const TaskProfilePageState.networkError();
      } else {
        state = TaskProfilePageState.error(appErrorHandler(e));
      }
    }
  }
}
