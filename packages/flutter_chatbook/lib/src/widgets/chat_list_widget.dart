part of '../../flutter_chatbook.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({
    Key? key,
    required this.chatController,
    required this.chatBackgroundConfig,
    required this.assignReplyMessage,
    required this.replyMessage,
    this.loadingWidget,
    this.reactionPopupConfig,
    this.messageConfig,
    this.chatBubbleConfig,
    this.profileCircleConfig,
    this.swipeToReplyConfig,
    this.repliedMessageConfig,
    this.typeIndicatorConfig,
    this.replyPopupConfig,
    this.loadMoreData,
    this.isLastPage,
  }) : super(key: key);

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides configuration for background of chat.
  final ChatBackgroundConfiguration chatBackgroundConfig;

  /// Provides widget for loading view while pagination is enabled.
  final Widget? loadingWidget;

  /// Provides configuration for reaction pop up appearance.
  final ReactionPopupConfiguration? reactionPopupConfig;

  /// Provides configuration for customisation of different types
  /// messages.
  final MessageConfiguration? messageConfig;

  /// Provides configuration of chat bubble's appearance.
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Provides configuration for profile circle avatar of user.
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Provides configuration for when user swipe to chat bubble.
  final SwipeToReplyConfiguration? swipeToReplyConfig;

  /// Provides configuration for replied message view which is located upon chat
  /// bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides configuration of typing indicator's appearance.
  final TypeIndicatorConfiguration? typeIndicatorConfig;

  /// Provides reply message when user swipe to chat bubble.
  final Message? replyMessage;

  /// Provides configuration for reply snack bar's appearance and options.
  final ReplyPopupConfiguration? replyPopupConfig;

  /// Provides callback when user actions reaches to top and needs to load more
  /// chat
  final VoidCallBackWithFuture? loadMoreData;

  /// Provides flag if there is no more next data left in list.
  final bool? isLastPage;

  /// Provides callback for assigning reply message when user swipe to chat
  /// bubble.
  final MessageCallBack assignReplyMessage;

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget>
    with SingleTickerProviderStateMixin {
  ChatController get chatController => widget.chatController;

  List<Message> get messageList => chatController.initialMessageList;

  AutoScrollController get scrollController => chatController.scrollController;

  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  FeatureActiveConfig? featureActiveConfig;

  String? currentUserId;

  bool isCupertino = false;

  late ValueNotifier<bool> showScrollToBottomButtonNotifier;

  @override
  void initState() {
    super.initState();
    showScrollToBottomButtonNotifier = ValueNotifier(false);
    chatController.scrollController.addListener(_scrollListener);
    _initialize();
  }

  void _scrollListener() {
    if (chatController.scrollController.offset >=
        chatController.scrollController.position.minScrollExtent + 100) {
      showScrollToBottomButtonNotifier.value = true;
    } else {
      showScrollToBottomButtonNotifier.value = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      featureActiveConfig = provide!.featureActiveConfig;
      currentUserId = provide!.currentUserId;
      isCupertino = provide!.isCupertinoApp;
    }

    if (featureActiveConfig?.enablePagination ?? false) {
      // When flag is on then it will include pagination logic to scroll
      // controller.
      // _pagination();
    }
  }

  void _initialize() {
    if (!chatController.messageStreamController.isClosed) {
      chatController.messageStreamController.sink.add(messageList);
    }

    // if (messageList.isNotEmpty) chatController.scrollToLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ChatGroupedListWidget(
                // reactionPopupConfig: widget.reactionPopupConfig,
                scrollController: scrollController,
                chatBackgroundConfig: widget.chatBackgroundConfig,
                assignReplyMessage: widget.assignReplyMessage,
                replyMessage: widget.replyMessage,
                swipeToReplyConfig: widget.swipeToReplyConfig,
                repliedMessageConfig: widget.repliedMessageConfig,
                profileCircleConfig: widget.profileCircleConfig,
                messageConfig: widget.messageConfig,
                chatBubbleConfig: widget.chatBubbleConfig,
                typeIndicatorConfig: widget.typeIndicatorConfig,
                onChatBubbleLongPress: (message) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return MessageActionsSheet(
                              message,
                              chatController,
                              currentUserId!,
                              widget.assignReplyMessage,
                              chatController.onEdit);
                        });
                  });
                },
                onChatListTap: _onChatListTap,
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: ValueListenableBuilder<bool>(
                  valueListenable: showScrollToBottomButtonNotifier,
                  builder: (context, value, child) {
                    return AnimatedOpacity(
                      opacity: value ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: FloatingActionButton(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        onPressed: () {
                          chatController.scrollController.animateTo(
                            chatController
                                .scrollController.position.minScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Icon(Icons.arrow_downward),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _onChatListTap() {}

  @override
  void dispose() {
    scrollController.dispose();
    chatController._isNextPageLoadingNotifier.dispose();

    super.dispose();
  }
}
