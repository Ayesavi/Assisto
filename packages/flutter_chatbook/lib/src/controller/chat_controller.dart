// ignore_for_file: invalid_use_of_visible_for_testing_member

part of '../../flutter_chatbook.dart';

/// Through ChatController User must be able to access chatTab's underlying
/// backend and database services.
class ChatController {
  /// Represents the initial message list in the chat, which can be added by the user.
  ///
  /// The [initialMessageList] variable is a [List<Message>] that holds the initial list of messages in the chat.
  /// Users can add messages to this list, and it will be displayed in the chat UI.
  final List<Message> initialMessageList;

  /// The [AutoScrollController] used for custom scrolling to messages and managing scroll positions.
  ///
  /// The [scrollController] allows you to programmatically scroll to specific messages or manage the scroll position within the chat UI.
  late final AutoScrollController scrollController;

  /// A [ValueNotifier] that indicates whether the typing indicator should be shown or hidden.
  ///
  /// The [_showTypingIndicator] variable is a [ValueNotifier] that holds a boolean value indicating whether the typing indicator should be displayed in the chat UI.
  /// By default, it is set to `false`, meaning the typing indicator is hidden.
  final ValueNotifier<bool> _showTypingIndicator = ValueNotifier(false);

  /// The [ChatDataService] used for chat-specific functions.
  ///
  /// The [chatService] provides functionality related to managing chat data, such as adding and deleting messages, updating message states, and interacting with the chat database service.
  /// It is responsible for handling the underlying data operations for the chat functionality.
  final ChatDataService? chatService;

  /// The [focusNode] is used to manage the focus state of [SendMessageWidget] within the [ChatBook].
  ///
  /// It is initialized in the [initState] method and can be used to control the focus of the input field.
  /// It is typically used in conjunction with [ChatUITextField] widget to determine which input field should receive focus.

  final FocusNode focusNode ;

  /// TypingIndicator as [ValueNotifier] for [GroupedChatList] widget's typingIndicator [ValueListenableBuilder].
  ///  Use this for listening typing indicators
  ///   ```dart
  ///    chatcontroller.typingIndicatorNotifier.addListener((){});
  ///  ```
  /// For more functionalities see [ValueNotifier].
  ValueNotifier<bool> get typingIndicatorNotifier => _showTypingIndicator;

  /// Getter for typingIndicator value instead of accessing [_showTypingIndicator.value]
  /// for better accessibility.
  bool get showTypingIndicator => _showTypingIndicator.value;

  /// Setter for changing values of typingIndicator
  /// ```dart
  ///  chatContoller.setTypingIndicator = true; // for showing indicator
  ///  chatContoller.setTypingIndicator = false; // for hiding indicator
  ///  ````
  set setTypingIndicator(bool value) => _showTypingIndicator.value = value;

  final ValueNotifier<bool> _isNextPageLoadingNotifier = ValueNotifier(false);

  // cancel the listener

  final String currentUserId;

  final Future<List<Message>> Function()? paginationCallback;

  ChatController({
    required this.focusNode,
    AutoScrollController? scrollController,
    required this.initialMessageList,
    required this.currentUserId,
    this.paginationCallback,
    this.chatService,
  }) {
    init();
    this.scrollController = scrollController ?? AutoScrollController();
  }

  void init() {}

  final TextEditingController inputController = TextEditingController();

  /// Represents message stream of chat
  final StreamController<List<Message>> messageStreamController =
      StreamController();

  /// A [ValueNotifier] that holds a list of messages for multiple message selection.
  ///
  /// The [multipleMessageSelection] variable is used to store a list of messages
  /// that have been selected for performing actions on multiple messages simultaneously.
  final ValueNotifier<List<Message>> multipleMessageSelection =
      ValueNotifier([]);

  // / Used to dispose [ChatController]
  @mustCallSuper
  void dispose() {
    multipleMessageSelection.dispose();
    messageStreamController.close();
    // _subscription.cancel();
  }

  /// Adds a message to the message list.
  ///
  /// The [addMessage] method is used to add a [Message] to the [initialMessageList].
  /// It inserts the message into the list using a [ValueNotifier] and notifies the [messageStreamController] to update the UI.
  /// Additionally, it calls the `addMessageWrapper` method of the [chatService] to handle the message addition.
  @mustCallSuper
  Future<void> addMessage(Message message) async {
    initialMessageList.insert(0, message);
    reRender();
    if ((message.authorId == currentUserId)) {
      await chatService?.addMessageWrapper(message);
    }
    return;
  }

  /// Deletes the specified list of messages from the message list.
  ///
  /// The [deleteMessage] method iterates over the given [messages] list and removes each message
  /// from the [initialMessageList] using the `removeWhere` method based on the message's ID.
  /// It notifies the [messageStreamController] to update the UI.
  /// Additionally, it calls the `deleteMessage` method of the [chatService] to handle the message deletion.
  /// If the [initialMessageList] is not empty, it updates the last message using the [lastMessageStream].
  @mustCallSuper
  void deleteMessage(List<Message> messages) {
    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      initialMessageList.removeWhere((item) => item.id == message.id);
      reRender();
      chatService?.deleteMessage(message);

      if (initialMessageList.isNotEmpty) {
        chatService?.lastMessage.value = (initialMessageList.first);
      }
    }
  }

  /// Re  quests focus for the [focusNode].
  ///
  /// The [getFocus] method is used to request focus for the [focusNode].
  /// It ensures that the focus is set to the [focusNode] so that the corresponding text field receives input focus.

  void getFocus() {
    focusNode.requestFocus();
  }

  /// Removes focus from the [focusNode].
  ///
  /// The [unFocus] method is used to remove focus from the [focusNode].
  /// It unfocuses the [focusNode], removing the input focus from the associated text field.

  void unFocus() {
    focusNode.unfocus();
  }

  void reRender() {
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
    ;
  }

  /// Toggles the visibility of the typing indicator.
  ///
  /// The [showHideTyping] method is used to toggle the visibility of the typing indicator.
  /// It sets the value of [setTypingIndicator] to the opposite of [showTypingIndicator]
  /// and notifies the [messageStreamController] to update the UI.

  @mustCallSuper
  void showHideTyping(String id) {
    setTypingIndicator = !showTypingIndicator;
    reRender();
  }

  void onEdit(Message message) {
    inputController.text = (message as TextMessage).text;
    getFocus();
  }

  JsonList getChatHistory({int threshHold = 5}) {
    final JsonList msgList = [];

    return msgList;
  }

  /// Loads more messages for pagination.
  ///
  /// The [_pagintationLoadMore] function is called to load more messages for pagination.
  /// It triggers the chat service to fetch the last messages and updates the UI by notifying the [messageStreamController].
  @mustCallSuper
  Future<void> pagintationLoadMore() async {
    await chatService?.fetchlastMessages();
    initialMessageList.addAll(await paginationCallback?.call() ?? []);
    reRender();
  }

  /// Scrolls to the last message in the chat view.
  ///
  /// The [scrollToLastMessage] function scrolls to the last message in the [ChatBook].
  /// It animates the scroll to the minimum scroll extent using the [scrollController].
  /// This is typically used when new messages are added to the chat, and you want to automatically scroll to the latest message.
  void scrollToLastMessage() => Timer(
        const Duration(milliseconds: 300),
        () => scrollController.animateTo(
          scrollController.position.minScrollExtent,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 300),
        ),
      );

  /// Loads more data for pagination.
  ///
  /// The [loadMoreData] function is used to load more data for pagination.
  /// It appends the [messageList] to the [initialMessageList], notifies the [messageStreamController], and refreshes the UI.
  void loadMoreData(List<Message> messageList) {
    initialMessageList.addAll(messageList);
    reRender();
  }

  @mustCallSuper
  void updateMessage(Message newMessage) {
    final index =
        initialMessageList.indexWhere((element) => element.id == newMessage.id);
    initialMessageList[index] = newMessage;
    if ((newMessage.authorId == currentUserId)) {
      chatService?.updateMessage(newMessage);
    }
    if (index == 0) {
      chatService?.lastMessage.value = initialMessageList[0];
    }
    reRender();
  }
}
