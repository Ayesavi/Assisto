import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.freezed.dart';
part 'home_page_controller.g.dart';
part 'home_page_controller_state.dart';

@riverpod
class HomePageController extends _$HomePageController {
  final _repo = SupabaseTaskRepository();
  AddressModel? _defaultAddr;

  @override
  HomePageControllerState build() {
    loadData();
    final state = ref.watch(addressControllerProvider);
    if (state.location) {
      _defaultAddr = (state as Location).model;
    }
    return const HomePageControllerState.loading();
  }

  void loadData({Map<String, dynamic>? filter}) async {
    try {
      final data = await _repo.fetchTasks(
          latlng: _defaultAddr != null
              ? (lat: _defaultAddr!.latlng.lat, lng: _defaultAddr!.latlng.lng)
              : null);
      state = HomePageControllerState.data(data);
    } catch (e) {
      if (e is NetworkException) {
        state = const HomePageControllerState.networkError();
        return;
      }
      state = HomePageControllerState.error(e);
      return;
    }
  }
}
