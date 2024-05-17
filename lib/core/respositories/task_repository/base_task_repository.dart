import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';

abstract class BaseTaskRepository {
  Future<List<TaskModel>> fetchTasks(
      {List<TaskFilterType> filters = const [], LatLng? latlng, int? offset});

  Future<TaskModel> getTaskById(int id);

  Future<TaskModel> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(int id);

  Future<void> acceptBid(int bidId);

  Future<List<BidModel>> fetchBids(int taskId, {int? offset});

  @Deprecated("Use fetchTasks instead with filters")
  Future<List<TaskModel>> fetchOwnTasks({LatLng? latlng});
}
