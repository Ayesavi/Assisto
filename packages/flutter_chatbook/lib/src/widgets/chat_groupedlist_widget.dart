part of '../../flutter_chatbook.dart';

class ChatGroupedListWidget extends StatefulWidget {
  const ChatGroupedListWidget({
    Key? key,
    required this.scrollController,
    required this.chatBackgroundConfig,
    this.replyMessage,
    required this.assignReplyMessage,
    required this.onChatListTap,
    required this.onChatBubbleLongPress,
    this.messageConfig,
    this.chatBubbleConfig,
    this.profileCircleConfig,
    this.swipeToReplyConfig,
    this.repliedMessageConfig,
    this.typeIndicatorConfig,
  }) : super(key: key);

  final AutoScrollController scrollController;

  /// Allow user to give customisation to background of chat
  final ChatBackgroundConfiguration chatBackgroundConfig;

  /// Allow user to giving customisation different types
  /// messages
  final MessageConfiguration? messageConfig;

  /// Allow user to giving customisation to chat bubble
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Allow user to giving customisation to profile circle
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Allow user to giving customisation to swipe to reply
  final SwipeToReplyConfiguration? swipeToReplyConfig;
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Allow user to giving customisation typing indicator
  final TypeIndicatorConfiguration? typeIndicatorConfig;

  /// Provides reply message if actual message is sent by replying any message.
  final Message? replyMessage;

  /// Provides callback for assigning reply message when user swipe on chat bubble.
  final MessageCallBack assignReplyMessage;

  /// Provides callback when user tap anywhere on whole chat.
  final VoidCallBack onChatListTap;

  /// Provides callback when user press chat bubble for certain time then usual.
  final void Function(Message) onChatBubbleLongPress;

  @override
  State<ChatGroupedListWidget> createState() => _ChatGroupedListWidgetState();
}

class _ChatGroupedListWidgetState extends State<ChatGroupedListWidget>
    with TickerProviderStateMixin {
  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  bool highlightMessage = false;

  final ValueNotifier<String?> _replyId = ValueNotifier(null);

  ChatBubbleConfiguration? get chatBubbleConfig => widget.chatBubbleConfig;

  ProfileCircleConfiguration? get profileCircleConfig =>
      widget.profileCircleConfig;
  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;

  FeatureActiveConfig? featureActiveConfig;

  ChatController? chatController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      featureActiveConfig = provide!.featureActiveConfig;
      chatController = provide!.chatController;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _chatStreamBuilder;
  }

  Future<void> _onReplyTap(String id, List<Message>? messages) async {
    // Finds the replied message if exists
    // final repliedMessages = messages?.firstWhere((message) => id == message.id);
    final int index = messages?.indexWhere((element) => element.id == id) ?? -1;

    // // Scrolls to replied message and highlights
    // if (repliedMessages != null) {
    //   if (repliedMessages.key.currentState == null && index != -1) {
    _replyId.value = id;
    widget.scrollController.scrollToIndex(index,
        duration: const Duration(seconds: 1),
        preferPosition: AutoScrollPosition.middle);
    Future.delayed(
        widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
                .highlightDuration ??
            const Duration(seconds: 2), () {
      _replyId.value = null;
    });
    // } else {
    //   await Scrollable.ensureVisible(
    //     repliedMessages.key.currentState!.context,
    //     // This value will make widget to be in center when auto scrolled.
    //     alignment: 0.5,
    //     curve: widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
    //             .highlightScrollCurve ??
    //         Curves.easeIn,
    //     duration: widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
    //             .highlightDuration ??
    //         const Duration(milliseconds: 300),
    //   );
    //   if (widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
    //           .enableHighlightRepliedMsg ??
    //       false) {
    //     _replyId.value = id;

    //     Future.delayed(
    //       widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
    //               .highlightDuration ??
    //           const Duration(milliseconds: 300),
    //       () {
    //         _replyId.value = null;
    //       },
    //     );
    //   }
    // }
    // }
  }
  @override
  void dispose() {
    _animationController?.dispose();
    _replyId.dispose();
    super.dispose();
  }

  Widget get _chatStreamBuilder {
    return StreamBuilder<List<Message>>(
      stream: chatController?.messageStreamController.stream,
      builder: (context, snapshot) {
        return snapshot.connectionState.isActive
            ? RefreshIndicator(
                onRefresh: chatController?.pagintationLoadMore ?? () async {},
                child: GroupedListView<Message, String>(
                  shrinkWrap: true,
                  elements: snapshot.data!,
                  reverse: true,
                  groupBy: (element) =>
                      chatBackgroundConfig.groupBy?.call(element) ??
                      (element.createdAt).getDateFromDateTime,
                  itemComparator: (message1, message2) =>
                      message1.createdAt.compareTo(message2.createdAt),
                  controller: widget.scrollController,
                  order: chatBackgroundConfig.groupedListOrder,
                  sort: chatBackgroundConfig.sortEnable,
                  groupSeparatorBuilder: (separator) =>
                      featureActiveConfig?.enableChatSeparator ?? false
                          ? _GroupSeparatorBuilder(
                              separator: separator,
                              defaultGroupSeparatorConfig: chatBackgroundConfig
                                  .defaultGroupSeparatorConfig,
                              groupSeparatorBuilder:
                                  chatBackgroundConfig.groupSeparatorBuilder,
                            )
                          : const SizedBox.shrink(),
                  indexedItemBuilder: (context, message, index) {
                    return ValueListenableBuilder<String?>(
                      valueListenable: _replyId,
                      builder: (context, state, child) {
                        return AutoScrollTag(
                          key: ValueKey(message.id),
                          controller: widget.scrollController,
                          index: index,
                          child: ChatBubbleWidget(
                            key: GlobalKey(),
                            prevMessage: index == snapshot.data!.length - 1
                                ? null
                                : snapshot.data![index + 1],
                            messageTimeTextStyle:
                                chatBackgroundConfig.messageTimeTextStyle,
                            messageTimeIconColor:
                                chatBackgroundConfig.messageTimeIconColor,
                            message: message,
                            messageConfig: widget.messageConfig,
                            chatBubbleConfig: chatBubbleConfig,
                            profileCircleConfig: profileCircleConfig,
                            swipeToReplyConfig: widget.swipeToReplyConfig,
                            repliedMessageConfig: widget.repliedMessageConfig,
                            slideAnimation: _slideAnimation,
                            onLongPress: () => widget.onChatBubbleLongPress(
                              message,
                            ),
                            onSwipe: widget.assignReplyMessage,
                            shouldHighlight: state == message.id,
                            onReplyTap: widget
                                        .repliedMessageConfig
                                        ?.repliedMsgAutoScrollConfig
                                        .enableScrollToRepliedMsg ??
                                    false
                                ? (replyId) =>
                                    _onReplyTap(replyId, snapshot.data)
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ))
            : Center(
                child: chatBackgroundConfig.loadingWidget ??
                    const CircularProgressIndicator(),
              );
      },
    );
  }
}

class _GroupSeparatorBuilder extends StatelessWidget {
  const _GroupSeparatorBuilder({
    Key? key,
    required this.separator,
    this.groupSeparatorBuilder,
    this.defaultGroupSeparatorConfig,
  }) : super(key: key);
  final String separator;
  final StringWithReturnWidget? groupSeparatorBuilder;
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;

  @override
  Widget build(BuildContext context) {
    return groupSeparatorBuilder != null
        ? groupSeparatorBuilder!(separator)
        : ChatGroupHeader(
            day: DateTime.parse(separator),
            groupSeparatorConfig: defaultGroupSeparatorConfig,
          );
  }
}
