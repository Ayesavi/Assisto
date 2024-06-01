import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/controllers/internet_connectivity_provider/internet_connectivity_provider.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/supabase_task_repository.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_task_page_controller.freezed.dart';
part 'search_task_page_controller.g.dart';
part 'search_task_page_controller_state.dart';

@riverpod
class SearchTaskPageController extends _$SearchTaskPageController {
  final _repo = SupabaseTaskRepository();
  int offset = 0;
  final limit = 30;
  LatLng? currentLatlng;
  List<TaskModel> _models = [];
  final ValueNotifier<bool> isPaginatingNotifier = ValueNotifier(false);

  @override
  SearchTaskPageState build() {
    ref.watch(internetConnectivityProvider);
    final currentAddress = ref.watch(addressControllerProvider);
    if (currentAddress.location) {
      currentLatlng = (
        lat: (currentAddress as Location).model.latlng.lat,
        // ignore: unnecessary_cast
        lng: (currentAddress as Location).model.latlng.lng,
      );
    }
    return const SearchTaskPageState.initial();
  }

  void search(String key) async {
    try {
      state = const SearchTaskPageState.loading();
      _models = await _repo.searchTasks(key, latlng: currentLatlng);
      state = SearchTaskPageState.data(_models);
    } catch (e) {
      final error = appErrorHandler(e);
      if (e is NetworkException) {
        state = const SearchTaskPageState.networkError();
      } else {
        state = SearchTaskPageState.error(error);
      }
    }
  }

  void paginate(String searchKey) async {
    try {
      if (!isPaginatingNotifier.value) {
        isPaginatingNotifier.value = true;
        offset += _models.length;
        final tasks = await _repo.searchTasks(searchKey,
            latlng: currentLatlng, offset: offset);
        _models.addAll(tasks);
        isPaginatingNotifier.value = false;
        state = SearchTaskPageState.data(_models);
      }
    } catch (e) {
      isPaginatingNotifier.value = false;
      throw const AppException(
          'Unable to fetch more tasks at the moment, please try again later.');
    }
  }
}
