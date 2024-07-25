import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/features/home/screens/feed_page.dart';
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
        .select('*,owner:owner_id(id,avatar_url,status)')
        .single());
  }

  @override
  Future<void> deleteTask(int id) async {
    await _supabase.from(_table).delete().eq('id', id);
  }

  @override
  Future<List<TaskModel>> fetchTasks(
      {filters = const [], LatLng? latlng, int offset = 0}) async {
    if (filters.contains(TaskFilterType.you)) {
      return await _fetchOwnTasks(limit: 30, offset: offset);
    } else if (filters.contains(TaskFilterType.bidded)) {
      return await _fetchBiddedTasks(filters, limit: 30, offset: offset);
    } else {
      final List<dynamic> data = await _supabase.rpc('get_feed_tasks', params: {
        'data': {
          'offset': offset,
          'limit': 30,
          if (latlng != null) ...{
            'center_lat': latlng.lat,
            'center_lng': latlng.lng,
          }
        }
      });
      return data.map((json) => TaskModel.fromJson(json)).toList();
    }
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final json = await _supabase.rpc('get_task_by_id', params: {
      'task_uid': id,
    });
    return TaskModel.fromJson(json[0]);
  }

  @override
  Future<void> updateTask(TaskModel newTask) async {
    final json = newTask.toJson();

    await _supabase.from(_table).update(json).eq('id', newTask.id).select();
    return;
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

  Future<List<TaskModel>> _fetchBiddedTasks(List<TaskFilterType> filters,
      {required int limit, required int offset}) async {
    final data = await _supabase
        .from('bidding')
        .select('task:task_id(*,owner:owner_id(id,avatar_url,status))')
        .eq('bidder_id', _supabase.auth.currentUser?.id ?? '')
        .range(offset, offset + limit);
    return data.map((json) {
      return TaskModel.fromJson(json['task']);
    }).toList();
  }

  Future<List<TaskModel>> _fetchOwnTasks(
      {required int limit, required int offset}) async {
    final data = await _supabase
        .from('tasks')
        .select(
            '*,owner:owner_id(id,avatar_url,status),bid:bid_id(*,bidder:bidder_id(*))')
        .eq('owner_id', '${_supabase.auth.currentUser?.id}')
        .range(offset, offset + limit)
        .order('created_at', ascending: false);
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
      return UserModel.fromSupbase(data['bid']['bidder']);
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

  @override
  Future<UserModel> getTaskOwner(int taskId) async {
    try {
      final data = await _supabase
          .from(_table)
          .select('owner:owner_id(*)')
          .eq('id', taskId)
          .single();
      return UserModel.fromSupbase(data['owner']);
    } catch (e) {
      throw const AppException(
          'Failed to get the task owner at the moment, try again later');
    }
  }

  @override
  Future<List<TaskModel>> searchTasks(String searchKey,
      {LatLng? latlng, int? offset}) async {
    final data = await _supabase.rpc('search_tasks', params: {
      'data': {
        'search_key': searchKey,
        if (latlng != null) ...{
          'center_lat': latlng.lat,
          'center_lng': latlng.lng,
          'offset': offset ?? 0,
          'limit': 30
        }
      }
    });

    // Ensure data is not null and is a List
    if (data != null && data is List) {
      // Convert each JSON object to a TaskModel and return as a list
      return data
          .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error or return empty list if data is null or not a list
      return [];
    }
  }

  @override
  Future<BidModel> fetchBidById(int bidId) async {
    try {
      final data = await _supabase
          .from('bidding')
          .select('*,bidder:bidder_id(*)')
          .eq('id', bidId)
          .limit(1)
          .single();
      return BidModel.fromJson(data);
    } catch (e) {
      throw const AppException(
          'Failed to get the bid details at the moment, try again later');
    }
  }
}
