import 'package:assisto/core/error/handler.dart';
import 'package:assisto/features/home/repositories/categories_repository.dart';
import 'package:assisto/models/service_category/service_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_categories_controller.freezed.dart';
part 'select_categories_controller.g.dart';
part 'select_categories_controller_state.dart';

@riverpod
class SelectCategoriesController extends _$SelectCategoriesController {
  final _repo = FakeCategoriesRepository();
  final _selected = <ServiceCategoryModel>[];
  var _categories = <ServiceCategoryModel>[];

  @override
  SelectCategoriesControllerState build() {
    getCategories();
    return const SelectCategoriesControllerState.loading();
  }

  Future<void> getCategories() async {
    try {
      final categories = await _repo.fetchCategories();
      _categories = categories;
      state = SelectCategoriesControllerState.data(_categories, _selected);
    } catch (e) {
      if (e is NetworkException) {
        state = const SelectCategoriesControllerState.networkError();
      } else {
        state = const SelectCategoriesControllerState.error();
      }
    }
  }

  Future<void> searchCategoriesByKeys(String key) async {
    try {
      state = const SelectCategoriesControllerState.loading();
      final categories = await _repo.fetchCategoryByKey(key);
      _categories = categories;

      state = SelectCategoriesControllerState.data(_categories, _selected);
    } catch (e) {
      if (e is NetworkException) {
        state = const SelectCategoriesControllerState.networkError();
      } else {
        state = const SelectCategoriesControllerState.error();
      }
    }
  }

  void toggleSelection(ServiceCategoryModel model) {
    if (!_selected.contains(model)) {
      _selected.add(model);
    } else {
      _selected.remove(model);
    }
    state = SelectCategoriesControllerState.data(_categories, _selected);
  }

  void selectGeneratedServices(List<String> categories) {
    for (var item in categories) {
      final model = _categories.firstWhere(
          (element) => element.label.toLowerCase() == item.toLowerCase(),
          orElse: () =>
              ServiceCategoryModel(description: '', label: item.toLowerCase()));
      if (!_selected.contains(model)) {
        _selected.add(model);
      }
    }
    state = SelectCategoriesControllerState.data(_categories, _selected);
  }
}
