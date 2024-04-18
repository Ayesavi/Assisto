import 'dart:math';

import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseTaskRepository {
  Future<List<TaskModel>> fetchTasks();

  Future<TaskModel> getTaskById(int id);

  Future<TaskModel> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(int id);
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
  Future<List<TaskModel>> fetchTasks() {
    throw UnimplementedError('fetch Tasks not implemented');
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
  Future<List<TaskModel>> fetchTasks() async {
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

  void _generateRandomTasks(int count) {
    final Random random = Random();

    for (int i = 0; i < count; i++) {
      TaskModel task = TaskModel(
        ownerId: _generateRandomString(6),
        attachedLocation: (
          lat: random.nextDouble() * 180 - 90,
          lng: random.nextDouble() * 360 - 180,
        ),
        tags: _generateRandomTags(random.nextInt(5) + 1),
        deadline: DateTime.now().add(Duration(days: random.nextInt(30))),
        title: 'Task ${i + 1}',
        description: 'This is a random task description.',
        gender: Gender.values[random.nextInt(Gender.values.length)],
        age: random.nextInt(100),
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
