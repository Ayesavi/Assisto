part of 'chats_list_page_controller.dart';

@freezed
sealed class ChatsListPageControllerState with _$ChatsListPageControllerState {
  const ChatsListPageControllerState._();
  const factory ChatsListPageControllerState.loading() =
      ChatsListPageControllerLoading;
  const factory ChatsListPageControllerState.data(List<ChatRoomModel> model) =
      ChatsListPageControllerData;
  const factory ChatsListPageControllerState.error(AppException e) =
      ChatsListPageControllerError;
  const factory ChatsListPageControllerState.networkError() =
      ChatsListPageControllerNetworkError;
}

extension ChatsListPageControllerStateX on ChatsListPageControllerState {
  bool get isLoading => this is ChatsListPageControllerLoading;
  bool get isData => this is ChatsListPageControllerLoading;
}
