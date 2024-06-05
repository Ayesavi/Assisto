part of 'search_task_page_controller.dart';

@freezed
sealed class SearchTaskPageState with _$SearchTaskPageState {
  const SearchTaskPageState._();
  const factory SearchTaskPageState.initial() = SearchTaskPageStateInitial;
  const factory SearchTaskPageState.loading() = SearchTaskPageStateLoading;
  const factory SearchTaskPageState.networkError() = SearchTaskPageStateNetworkError;
  const factory SearchTaskPageState.error(AppException e) = SearchTaskPageStateError ;

  const factory SearchTaskPageState.data(List<TaskModel> tasks) = SearchTaskPageStateData;


}

extension SearchTaskPageStateX on SearchTaskPageState {
  bool get isInitial => this is SearchTaskPageStateInitial;
  bool get isLoading => this is SearchTaskPageStateLoading;
  bool get isData => this is SearchTaskPageStateData;
}
