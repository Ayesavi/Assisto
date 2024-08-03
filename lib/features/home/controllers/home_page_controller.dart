import 'dart:io';

import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/task_repository_provider.dart';
import 'package:assisto/features/home/screens/feed_page.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/filter_widget/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.freezed.dart';
part 'home_page_controller.g.dart';
part 'home_page_controller_state.dart';

@riverpod
class HomePageController extends _$HomePageController {
  late BaseTaskRepository _repo;
  AddressModel? _defaultAddr;

  int offset = 0;
  final limit = 30;
  LatLng? currentLatlng;

  List<TaskModel> _models = [];
  final ValueNotifier<bool> isPaginatingNotifier = ValueNotifier(false);

  @override
  HomePageControllerState build() {
    _repo = ref.watch(taskRepositoryProvider);
    final filters = ref.watch(selectedFiltersProvider);

    final addr = ref.watch(addressControllerProvider);

    addr.when(
      locationNotSet: () {
        loadData(filters);
      },
      locationPermissionDisabled: () {},
      location: (address) {
        _defaultAddr = address;
        loadData(filters);
      },
    );

    return const HomePageControllerState.loading();
  }

  void loadData([List<TaskFilterType> filters = const []]) async {
    try {
      state = const HomePageControllerState.loading();
      offset = 0;
      final data = await _repo.fetchTasks(
          filters: filters,
          offset: 0,
          latlng: _defaultAddr != null
              ? (
                  lat: _defaultAddr!.latlng.lat,
                  lng: _defaultAddr!.latlng.lng,
                )
              : null);
      _models = data;
      state = HomePageControllerState.tasks(_models, filters);
    } catch (e) {
      final error = appErrorHandler(e);
      if (error is NetworkException || error is SocketException) {
        state = const HomePageControllerState.networkError();
        return;
      }
      state = HomePageControllerState.error(error);
      return;
    }
  }

  void paginate() async {
    try {
      if (!isPaginatingNotifier.value) {
        isPaginatingNotifier.value = true;
        offset += _models.length;
        final tasks = await _repo.fetchTasks(
            filters: ref.read(selectedFiltersProvider),
            offset: offset,
            latlng: _defaultAddr != null
                ? (lat: _defaultAddr!.latlng.lat, lng: _defaultAddr!.latlng.lng)
                : null);
        _models.addAll(tasks);
        isPaginatingNotifier.value = false;
        state = HomePageControllerState.tasks(
            _models, ref.read(selectedFiltersProvider));
      }
    } catch (e) {
      isPaginatingNotifier.value = false;
      throw const AppException(
          'Unable to fetch more tasks at the moment, please try again later.');
    }
  }
}
