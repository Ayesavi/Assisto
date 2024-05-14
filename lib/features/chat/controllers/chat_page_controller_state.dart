part of 'chat_page_controller.dart';

@freezed
sealed class ChatPageControllerState with _$ChatPageControllerState {
  const ChatPageControllerState._();
  const factory ChatPageControllerState.loading() = ChatPageLoading;
  const factory ChatPageControllerState.data({
    required UserModel userModel,
    required List<Message> messages,
  }) = ChatPageData;
  const factory ChatPageControllerState.error(AppException error) = ChatPageError;
  const factory ChatPageControllerState.networkError() = ChatPageNetworkError;
}

extension ChatPageControllerStateX on ChatPageControllerState {
  bool get isInitial => this is ChatPageLoading;
  bool get isData => this is ChatPageData;
  bool get isError => this is ChatPageError;
  bool get isNetworkError => this is ChatPageNetworkError;
}
