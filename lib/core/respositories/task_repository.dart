import 'dart:math';

import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseTaskRepository {
  Future<List<TaskModel>> fetchTasks({LatLng? latlng});

  Future<TaskModel> getTaskById(int id);

  Future<TaskModel> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(int id);

  Future<void> acceptBid(int bidId);

  Future<List<BidModel>> bids(int bidId, {int? offset});
}

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

  @override
  Future<List<BidModel>> bids(int bidId, {int? offset}) {
    // TODO: implement bids
    throw UnimplementedError();
  }
}

class FakeTaskRepository implements BaseTaskRepository {
  FakeTaskRepository() {
    _generateAuthenticTasks();
  }
  List<TaskModel> _tasks = [];

  List<String> avatarUrls = [
    'https://randomuser.me/api/portraits/men/1.jpg',
    'https://randomuser.me/api/portraits/women/2.jpg',
    // Add more avatar URLs as needed
  ];

  List<String> names = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Brown',
    // Add more names as needed
  ];

  List<BidModel> generateBidModels(String taskId, List<String> userIds) {
    final List<BidModel> bidModels = [];
    final Random random = Random();

    for (String userId in userIds) {
      final UserModel bidder = UserModel(
        id: userId,
        name: names[random.nextInt(names.length)],
        avatarUrl: avatarUrls[random.nextInt(avatarUrls.length)],
        gender: random.nextBool() ? 'male' : 'female',
        tags: ['tag1', 'tag2', 'tag3'], // Example tags
        age: random.nextInt(80) + 18, // Random age between 18 and 98
      );

      final int amount =
          random.nextInt(1000) + 100; // Random amount between 100 and 1099

      final int daysAgo = random.nextInt(30);
      final DateTime createdAt =
          DateTime.now().subtract(Duration(days: daysAgo));

      final BidModel bidModel = BidModel(
        id: random.nextInt(1000), // Example ID
        createdAt: createdAt,
        bidder: bidder,
        amount: amount,
      );

      bidModels.add(bidModel);
    }

    return bidModels;
  }

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
    _tasks = [];
    _generateAuthenticTasks();
    return List<TaskModel>.from(_tasks);
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    await Future.delayed(const Duration(seconds: 1));
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

  void _generateAuthenticTasks() {
    final List<String> taskTitles = [
      "Grocery Shopping",
      "Dog Walking",
      "House Cleaning",
      "Yard Work",
      "Meal Preparation",
      "Laundry",
      "Errand Running",
      "Child Care",
      "Senior Companion",
      "Tutoring",
      "Pet Sitting",
      "Home Organization",
      "Event Planning",
      "Tech Support",
      "Moving Assistance",
      "Car Washing",
      "Plant Care",
      "Handyman Work",
      "Personal Shopping",
      "Fitness Training",
    ];

    final List<String> taskDescriptions = [
      "Need someone to help with grocery shopping. Will provide the list.",
      "Looking for someone to walk my dog every evening for 30 minutes.",
      "Require assistance with house cleaning on a bi-weekly basis.",
      "Help needed with mowing the lawn and trimming bushes.",
      "Seeking someone to prepare meals for the week. Will provide recipes.",
      "Need help with laundry twice a week. Clothes will be sorted.",
      "Require assistance with errands such as picking up dry cleaning and dropping off packages.",
      "Looking for a responsible individual to care for my child after school.",
      "Seeking a companion for my elderly parent. Engage in conversation and accompany to appointments.",
      "Require tutoring for high school math twice a week.",
      "Need someone to look after my cat while I'm away for the weekend.",
      "Help needed with organizing closets and decluttering rooms.",
      "Looking for assistance with planning a birthday party for 20 guests.",
      "Require tech support to set up home WiFi network and install smart devices.",
      "Need help with packing and moving furniture to a new apartment.",
      "Looking for someone to wash and wax my car once a week.",
      "Require assistance with watering plants and pruning.",
      "Need a handyman to fix a leaky faucet and repair a broken shelf.",
      "Seeking someone to pick up groceries and deliver to my home.",
      "Require personal trainer for weekly workout sessions at home.",
    ];

    final List<String> addresses = [
      "123 Main St, Anytown, USA",
      "456 Elm St, Springfield, USA",
      "789 Oak Ave, Lakeside, USA",
      "101 Pine St, Mountainview, USA",
      "246 Maple Dr, Rivertown, USA",
      "369 Cedar Ln, Sunnyside, USA",
      "482 Birch Rd, Hillcrest, USA",
      "575 Walnut Ave, Riverdale, USA",
      "698 Cherry St, Brookside, USA",
      "702 Apple Ln, Greenside, USA",
      "823 Peach Ave, Meadowview, USA",
      "936 Grape St, Hilltop, USA",
      "104 Lemon Dr, Oakside, USA",
      "217 Orange Blvd, Parkview, USA",
      "320 Banana Ln, Sunset, USA",
      "435 Kiwi Dr, Valleyview, USA",
      "548 Strawberry Rd, Lakeside, USA",
      "651 Blueberry Ave, Pineview, USA",
      "764 Raspberry St, Springview, USA",
      "877 Blackberry Ln, Riverside, USA",
    ];

    for (int i = 0; i < 20; i++) {
      TaskModel task = TaskModel(
        owner: TaskOwner(
          id: 'user_${i + 1}',
          imageUrl:
              'https://randomuser.me/api/portraits/med/women/${i + 1}.jpg', // Assuming user profile images
        ),
        tags: _generateRandomTags(Random().nextInt(6)),

        address: TaskAddress(
          latlng: (lat: 23, lng: 32),
          id: 'user_${i + 1}',
          address: addresses[i],
          houseNumber: '${i + 1}',
        ),
        deadline: DateTime.now().add(Duration(days: Random().nextInt(2))),
        title: taskTitles[i],
        description: taskDescriptions[i],
        ageGroup: '${Random().nextInt(100)}-${Random().nextInt(100)}',
        distance: Random().nextDouble() *
            10, // Distance can be left as null for local tasks
        gender: Gender.values[Random().nextInt(Gender.values.length)],
        expectedPrice: (Random().nextInt(10) + 1) *
            100, // Random price between $100 and $1000
        status: TaskStatus.unassigned, // Tasks start as unassigned
        id: _tasks.length + 1, // Incremental ID
        assigned: null, // Initially unassigned
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

  @override
  Future<List<BidModel>> bids(int bidId, {int? offset}) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    return generateBidModels('3', ['d', 's']);
  }
}
