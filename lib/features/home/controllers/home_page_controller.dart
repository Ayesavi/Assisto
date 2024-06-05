import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/supabase_task_repository.dart';
import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/filter_widget/filter_widget.dart';
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
    final filters = ref.watch(selectedFiltersProvider);
    loadData(filters);
    final state = ref.watch(addressControllerProvider);
    if (state.location) {
      _defaultAddr = (state as Location).model;
    }
    return const HomePageControllerState.loading();
  }

  void loadData([List<TaskFilterType> filters = const []]) async {
    try {
      state = const HomePageControllerState.loading();

      final data = await _repo.fetchTasks(
          filters: filters,
          latlng: _defaultAddr != null
              ? (lat: _defaultAddr!.latlng.lat, lng: _defaultAddr!.latlng.lng)
              : null);
        state = HomePageControllerState.tasks(data,filters);
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
