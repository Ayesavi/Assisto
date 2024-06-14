import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/models/user_model/user_model.dart';

typedef BidInfo = ({int amount, int taskId});

/// Base interface for task repository.
///
/// This interface provides methods for interacting with tasks and their related data.
abstract class BaseTaskRepository {
  /// Fetches a list of tasks based on the provided filters and location.
  ///
  /// [filters] - A list of task filters to apply.
  /// [latlng] - The location to filter tasks by.
  /// [offset] - The offset for pagination.
  ///
  /// Returns a Future that completes when the tasks are fetched.
  Future<List<TaskModel>> fetchTasks({
    List<TaskFilterType> filters = const [],
    LatLng? latlng,
    int offset = 0,
  });

  /// Retrieves a task by its ID.
  ///
  /// [id] - The ID of the task to retrieve.
  ///
  /// Returns a Future that completes when the task is fetched.
  Future<TaskModel> getTaskById(int id);

  /// Adds a new task to the repository.
  ///
  /// [task] - The task to add.
  ///
  /// Returns a Future that completes when the task is added.
  Future<TaskModel> addTask(TaskModel task);

  /// Updates an existing task in the repository.
  ///
  /// [task] - The task to update.
  ///
  /// Returns a Future that completes when the task is updated.
  Future<void> updateTask(TaskModel task);

  /// Deletes a task from the repository.
  ///
  /// [id] - The ID of the task to delete.
  ///
  /// Returns a Future that completes when the task is deleted.
  Future<void> deleteTask(int id);

  /// Accepts a bid for a task.
  ///
  /// [bidId] - The ID of the bid to accept.
  ///
  /// Returns a Future that completes when the bid is accepted.
  Future<void> acceptBid(int bidId);

  /// Fetches a list of bids for a specific task.
  ///
  /// [taskId] - The ID of the task to fetch bids for.
  /// [offset] - The offset for pagination.
  ///
  /// Returns a Future that completes when the bids are fetched.
  Future<List<BidModel>> fetchBids(int taskId, {int? offset});

  /// Retrieves a bid by its ID.
  ///
  /// [taskId] - The ID of the task the bid belongs to.
  ///
  /// Returns a Future that completes when the bid is fetched.
  Future<BidModel> fetchBidById(int taskId);

  /// Places a new bid on a task.
  ///
  /// [taskId] - The ID of the task to place a bid on.
  /// [amount] - The amount of the bid.
  ///
  /// Returns a Future that completes when the bid is placed.
  Future<void> placeBid({
    required int taskId,
    required int amount,
  });

  /// Fetches information about a bid on a task.
  ///
  /// [taskId] - The ID of the task to fetch bid info for.
  ///
  /// Returns a Future that completes when the bid info is fetched.
  Future<BidInfo?> fetchBidInfoOnTask(int taskId);

  /// Blocks a task.
  ///
  /// [taskId] - The ID of the task to block.
  ///
  /// Returns a Future that completes when the task is blocked.
  Future<void> blockTask(int taskId);

  /// Retrieves the user assigned to a task.
  ///
  /// [taskId] - The ID of the task to fetch the assigned user for.
  ///
  /// Returns a Future that completes when the assigned user is fetched.
  Future<UserModel> getTaskAssignedUser(int taskId);

  /// Updates the status of a task.
  ///
  /// [taskId] - The ID of the task to update the status for.
  /// [status] - The new status of the task.
  ///
  /// Returns a Future that completes when the task status is updated.
  Future<void> updateTaskStatus(int taskId, TaskStatus status);

  /// Retrieves the owner of a task.
  ///
  /// [taskId] - The ID of the task to fetch the owner for.
  ///
  /// Returns a Future that completes when the task owner is fetched.
  Future<UserModel> getTaskOwner(int taskId);

  /// Searches for tasks based on a search key.
  ///
  /// [searchKey] - The search key to use.
  /// [latlng] - The location to filter tasks by.
  /// [offset] - The offset for pagination.
  ///
  /// Returns a Future that completes when the tasks are fetched.
  Future<List<TaskModel>> searchTasks(String searchKey,
      {LatLng? latlng, int? offset});
}
