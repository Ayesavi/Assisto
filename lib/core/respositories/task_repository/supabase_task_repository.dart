import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTaskRepository implements BaseTaskRepository {
  final _supabase = Supabase.instance.client;
  final _table = 'tasks';

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    final json = task.toSupaJson();
    return TaskModel.fromJson(await _supabase
        .from(_table)
        .insert(json)
        .select('*,owner:owner_id(id,avatar_url)')
        .single());
  }

  @override
  Future<void> deleteTask(int id) async {
    await _supabase.from(_table).delete().eq('id', id);
  }

  @override
  Future<List<TaskModel>> fetchTasks(
      {filters = const [], LatLng? latlng, int? offset}) async {
    if (filters.contains(TaskFilterType.you)) {
      return await _fetchOwnTasks();
    } else if (filters.contains(TaskFilterType.bidded)) {
      return await _fetchBiddedTasks(filters);
    } else {
      final List<dynamic> data = await _supabase.rpc('get_feed_tasks', params: {
        'data': {
          if (latlng != null) ...{
            'center_lat': latlng.lat,
            'center_lng': latlng.lng
          }
        }
      });
      return data.map((json) => TaskModel.fromJson(json)).toList();
    }
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final json = await _supabase
        .from(_table)
        .select('*,owner:owner_id(id,avatar_url)')
        .eq('id', id)
        .single();
    return TaskModel.fromJson(json);
  }

  @override
  Future<void> updateTask(TaskModel newTask) async {
    final json = newTask.toSupaJson();
    TaskModel.fromJson(
        await _supabase.from(_table).update(json).eq('id', newTask.id));
  }

  @override
  Future<void> acceptBid(int id) async {
    await _supabase.rpc('accept_bid', params: {'task_bid_id': id});
  }

  @override
  Future<List<BidModel>> fetchBids(int taskId, {int? offset}) async {
    final data = await _supabase
        .from('bidding')
        .select('*,bidder:bidder_id(*)')
        .eq('task_id', taskId);
    return data.map((e) => BidModel.fromJson(e)).toList();
  }

  Future<List<TaskModel>> _fetchBiddedTasks(
      List<TaskFilterType> filters) async {
    final data = await _supabase
        .from('bidding')
        .select('task:task_id(*,owner:owner_id(id,avatar_url))')
        .eq('bidder_id', _supabase.auth.currentUser?.id ?? '');
    return data.map((json) {
      return TaskModel.fromJson(json['task']);
    }).toList();
  }

  Future<List<TaskModel>> _fetchOwnTasks() async {
    final data = await _supabase
        .from('tasks')
        .select(
            '*,owner:owner_id(id,avatar_url),bid:bid_id(*,bidder:bidder_id(*))')
        .eq('owner_id', '${_supabase.auth.currentUser?.id}');
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }

  @override
  Future<void> placeBid({required int taskId, required int amount}) async {
    await _supabase
        .from('bidding')
        .insert({'task_id': taskId, 'amount': amount});
  }

  @override
  Future<BidInfo?> fetchBidInfoOnTask(int taskId) async {
    try {
      final data = await _supabase
          .from('bidding')
          .select('amount,id')
          .eq('task_id', taskId)
          .single();
      return (amount: data['amount'] as int, taskId: data['id'] as int);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> blockTask(int taskId) async {
    await _supabase
        .from(_table)
        .update({'status': TaskStatus.blocked.name}).eq('id', taskId);
  }

  @override
  Future<UserModel> getTaskAssignedUser(int taskId) async {
    try {
      final data = await _supabase
          .from('tasks')
          .select('bid:bid_id(bidder:bidder_id(*))')
          .eq('id', taskId)
          .single();
      return UserModel.fromJson(data['bid']['bidder']);
    } catch (e) {
      throw const AppException(
          'Failed to get details of the assigned user for the task at the moment, try again later.');
    }
  }

  @override
  Future<void> updateTaskStatus(int taskId, TaskStatus status) async {
    try {
      await _supabase
          .from(_table)
          .update({'status': status.name}).eq('id', taskId);
    } catch (e) {
      throw const AppException(
          'Failed to update the task status at the moment, try again later.');
    }
  }
}
