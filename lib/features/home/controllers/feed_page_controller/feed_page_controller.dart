import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/task_repository_provider.dart';
import 'package:assisto/features/home/screens/feed_page.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_page_controller.freezed.dart';
part 'feed_page_controller.g.dart';
part 'feed_page_controller_state.dart';

@Riverpod(keepAlive: true)
class FeedPageController extends _$FeedPageController {
  late BaseTaskRepository _taskRepository;
  AddressModel? _defaultAddr;

  int offset = 0;
  final limit = 30;
  LatLng? currentLatlng;

  final List<TaskModel> _models = [];
  final ValueNotifier<bool> isPaginatingNotifier = ValueNotifier(false);

  @override
  FeedPageControllerState build() {
    getRecommendations();

    final addr = ref.watch(addressControllerProvider);

    addr.when(
      locationNotSet: () {
        getRecommendations();
      },
      locationPermissionDisabled: () {
        getRecommendations();
      },
      location: (address) {
        _defaultAddr = address;
        getRecommendations();
      },
    );
    return const FeedPageControllerState.loading();
  }

  void getRecommendations() async {
    try {
      state = const FeedPageControllerState.loading();
      _taskRepository = ref.watch(taskRepositoryProvider);
      final recommendations = await _taskRepository.fetchTasks(
          filters: [TaskFilterType.recommended], latlng: _defaultAddr?.latlng);
      state = FeedPageControllerState.data(recommendations);
    } catch (e) {
      final error = appErrorHandler(e);
      if (e is NetworkException) {
        state = const FeedPageControllerState.networkError();
      } else {
        state = FeedPageControllerState.error(error);
      }
    }
  }

  void paginate() async {
    try {
      if (!isPaginatingNotifier.value) {
        isPaginatingNotifier.value = true;
        offset += _models.length;
        final tasks = await _taskRepository.fetchTasks(
            filters: [TaskFilterType.recommended],
            offset: offset,
            latlng: _defaultAddr?.latlng);
        _models.addAll(tasks);
        isPaginatingNotifier.value = false;
        state = FeedPageControllerState.data(_models);
      }
    } catch (e) {
      isPaginatingNotifier.value = false;
      throw const AppException(
          'Unable to fetch more tasks at the moment, please try again later.');
    }
  }
}
