import 'dart:math';

import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseTaskRepository {
  Future<List<TaskModel>> fetchTasks({LatLng? latlng});

  Future<TaskModel> getTaskById(int id);

  Future<TaskModel> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(int id);

  Future<void> acceptBid(int bidId);
}

class SupabaseTaskRepository implements BaseTaskRepository {
  final _supabase = Supabase.instance.client;
  final _table = 'tasks';

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    final json = task.toSupaJson();
    return TaskModel.fromJson(
        await _supabase.from(_table).insert(json).select().single());
  }

  @override
  Future<void> deleteTask(int id) async {
    await _supabase.from(_table).delete().eq('id', id);
  }

  @override
  Future<List<TaskModel>> fetchTasks({LatLng? latlng}) async {
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
}

class FakeTaskRepository implements BaseTaskRepository {
  FakeTaskRepository() {
    _generateRandomTasks(20);
  }
  final List<TaskModel> _tasks = [];

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    _tasks.add(task.copyWith(id: _tasks.length + 1)); // Assign a unique ID
    return task;
  }

  @override
  Future<void> deleteTask(int id) async {
    _tasks.removeWhere((task) => task.id == id);
  }

  @override
  Future<List<TaskModel>> fetchTasks({LatLng? latlng}) async {
    return List<TaskModel>.from(_tasks);
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    return _tasks.firstWhere((task) => task.id == id,
        orElse: () => throw Exception('Task not found'));
  }

  @override
  Future<void> updateTask(TaskModel newTask) async {
    final index = _tasks.indexWhere((task) => task.id == newTask.id);
    if (index != -1) {
      _tasks[index] = newTask;
    } else {
      throw Exception('Task not found');
    }
  }

  @override
  Future<void> acceptBid(int bidId) async {
    return;
  }

  void _generateRandomTasks(int count) {
    final Random random = Random();

    for (int i = 0; i < count; i++) {
      TaskModel task = TaskModel(
        owner: TaskOwner(
            id: 'd',
            imageUrl: 'https://picsum.photos/seed/${i.toString()}/200/300'),
        tags: _generateRandomTags(random.nextInt(5) + 1),
        deadline: DateTime.now().add(Duration(days: random.nextInt(30))),
        title: 'Task ${i + 1}',
        description: 'This is a random task description.',
        gender: Gender.values[random.nextInt(Gender.values.length)],
        expectedPrice: random.nextDouble() * 100,
        status: TaskStatus.values[random.nextInt(TaskStatus.values.length)],
        id: _tasks.length + 1,
        assigned: null,
        createdAt: DateTime.now(),
      );

      _tasks.add(task);
    }
  }

  String _generateRandomString(int length) {
    final Random random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  List<String> _generateRandomTags(int count) {
    final Random random = Random();
    const tags = [
      'tag1',
      'tag2',
      'tag3',
      'tag4',
      'tag5',
      'tag6',
      'tag7',
      'tag8',
      'tag9',
      'tag10'
    ];
    return List.generate(count, (index) => tags[random.nextInt(tags.length)]);
  }
}
