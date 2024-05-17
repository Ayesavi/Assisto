import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
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
        .select('*,owner:owner_id(id,image_url)')
        .single());
  }

  @override
  Future<void> deleteTask(int id) async {
    await _supabase.from(_table).delete().eq('id', id);
  }

  @override
  Future<List<TaskModel>> fetchTasks(
      {filters = const [], LatLng? latlng, int? offset}) async {
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

  @override
  Future<TaskModel> getTaskById(int id) async {
    final json = await _supabase.from(_table).select('*').eq('id', id).single();
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
    final data =
        await _supabase.from('bidding').select('*').eq('task_id', taskId);
    return data.map((e) => BidModel.fromJson(e)).toList();
  }

  /// Fetched tasks made by the current user.
  @override
  Future<List<TaskModel>> fetchOwnTasks({LatLng? latlng}) async {
    final data = await _supabase
        .from('tasks')
        .select(
            '*,owner:owner_id(id,avatar_url),bid:bid_id(*,bidder:bidder_id(*))')
        .eq('owner_id', '${_supabase.auth.currentUser?.id}');
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }
}
