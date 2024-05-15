part of '../../flutter_chatbook.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget({
    required GlobalKey key,
    required this.message,
    required this.onLongPress,
    required this.slideAnimation,
    required this.onSwipe,
    this.profileCircleConfig,
    this.chatBubbleConfig,
    this.repliedMessageConfig,
    this.swipeToReplyConfig,
    this.messageTimeTextStyle,
    this.messageTimeIconColor,
    this.messageConfig,
    this.onReplyTap,
    this.prevMessage,
    this.reactionPopupConfig,
    this.shouldHighlight = false,
  }) : super(key: key);

  /// Represent current instance of message.
  final Message message;

  /// Give callback once user long press on chat bubble.
  final void Function() onLongPress;

  /// Provides configuration related to user profile circle avatar.
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Provides configurations related to chat bubble such as padding, margin, max
  /// width etc.
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Provides configurations related to replied message such as textstyle
  /// padding, margin etc. Also, this widget is located upon chat bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides configurations related to swipe chat bubble which triggers
  /// when user swipe chat bubble.
  final SwipeToReplyConfiguration? swipeToReplyConfig;

  /// Provides textStyle of message created time when user swipe whole chat.
  final TextStyle? messageTimeTextStyle;

  /// Provides default icon color of message created time view when user swipe
  /// whole chat.
  final Color? messageTimeIconColor;

  /// Provides slide animation when user swipe whole chat.
  final Animation<Offset>? slideAnimation;

  /// Provides configuration of all types of messages.
  final MessageConfiguration? messageConfig;

  /// Provides callback of when user swipe chat bubble for reply.
  final MessageCallBack onSwipe;

  /// Provides callback when user tap on replied message upon chat bubble.
  final Function(String message)? onReplyTap;

  /// Flag for when user tap on replied message and highlight actual message.
  final bool shouldHighlight;

  final Message? prevMessage;

  final ReactionPopupConfiguration? reactionPopupConfig;

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  Message? get replyMessage => widget.message.repliedMessage;

  bool get isMessageBySender => widget.message.authorId == currentUserId;

  bool get isLastMessage => true;

  bool isCupertino = false;

  ProfileCircleConfiguration? get profileCircleConfig =>
      widget.profileCircleConfig;

  FeatureActiveConfig? featureActiveConfig;

  ChatController? chatController;

  String? currentUserId;

  int? maxDuration;

  ValueNotifier<double> isOn = ValueNotifier(0.00);

  bool get isPrevMsgAuthorSame =>
      widget.message.authorId == widget.prevMessage?.authorId;

  bool get isPrevMsgDateSame => widget.prevMessage != null
      ? (widget.prevMessage!.createdAt).getDay !=
          (widget.message.createdAt).getDay
      : false;

  String get messagedUserId => widget.message.authorId;

  bool selectMultipleMessages = false;

  bool get _enableSwipeToReply =>
      (featureActiveConfig?.enableSwipeToReply ?? true);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      featureActiveConfig = provide!.featureActiveConfig;
      chatController = provide!.chatController;
      currentUserId = provide!.currentUserId;
      isCupertino = provide!.isCupertinoApp;
      selectMultipleMessages =
          provide?.featureActiveConfig.selectMultipleMessages ?? true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get user from id.

    return _chatBubbleWidget(messagedUserId);
  }

  Widget _chatBubbleWidget(String? messagedUserId) {
    return Padding(
      padding: widget.chatBubbleConfig?.padding ??
          EdgeInsets.only(left: 5.0, top: isPrevMsgAuthorSame ? 0 : 10),
      child: Padding(
        padding: EdgeInsets.zero,
        child: ConditionalWrapper(
            condition: selectMultipleMessages,
            wrapper: (child) => GestureView(
                  message: widget.message,
                  onLongPress: widget.onLongPress,
                  isLongPressEnable:
                      (featureActiveConfig?.enableReactionPopup ?? true) ||
                          (featureActiveConfig?.enableReplySnackBar ?? true),
                  child: child,
                ),
            child: Column(children: [
              featureActiveConfig?.enableSwipeToSeeTime != true
                  ? ConditionalWrapper(
                      condition: _enableSwipeToReply,
                      wrapper: (child) => _swipeWidget(child),
                      child: _messageRow)
                  : _messageRow,
              if (isLastMessage && chatController!.showTypingIndicator) ...[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                          height: 70,
                          width: 200,
                          child: ValueListenableBuilder(
                              valueListenable:
                                  chatController!.typingIndicatorNotifier,
                              builder: (context, value, child) =>
                                  TypingIndicator(
                                    // typeIndicatorConfig: widget.typeIndicatorConfig,
                                    chatBubbleConfig: widget.chatBubbleConfig
                                        ?.inComingChatBubbleConfig,
                                    showIndicator: value,
                                    profilePic: widget
                                        .profileCircleConfig?.profileImageUrl,
                                  )))
                    ])
              ]
            ])),
      ),
    );
  }

  Widget _swipeWidget(Widget child) {
    return SwipeableTile.swipeToTrigger(
        key: Key((Random().nextInt(1) * 100000).toString()),
        backgroundBuilder: (context, direction, progress) {
          progress.addListener(() {
            isOn.value = progress.value;
          });

          return ValueListenableBuilder<double>(
              valueListenable: isOn,
              builder: (context, value, child) =>
                  widget.swipeToReplyConfig?.backgroundBuilder
                      ?.call(context, direction, progress, value) ??
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: value,
                      child: AnimatedOpacity(
                        opacity: value,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          CupertinoIcons.reply,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  ));
        },
        direction: SwipeDirection.startToEnd,
        color: Colors.transparent,
        isElevated: false,
        onSwiped: (direction) {
          widget.onSwipe(widget.message);
          chatController!.getFocus();
          featureActiveConfig?.enableSwipeToReply ?? true
              ? () {
                  if (maxDuration != null) {
                    // widget.message.voiceMessageDuration =
                    //     Duration(milliseconds: maxDuration!);
                  }
                  if (widget.swipeToReplyConfig?.onRightSwipe != null) {
                    ///TODO: Add the functionality of below ones.
                    // widget.swipeToReplyConfig?.onRightSwipe!(
                    //     widget.message.message,
                    //     widget.message.sendBy);
                  }
                  widget.onSwipe(widget.message);
                }
              : null;
        },
        child: child);
  }

  Widget get _messageRow => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isMessageBySender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _messagesWidgetColumn(),
        ],
      );

  Widget _messagesWidgetColumn() {
    return MessageView(
      onReplyTap: widget.onReplyTap,
      repliedMessageConfig: widget.repliedMessageConfig,
      isPrevAuthorSame: isPrevMsgAuthorSame,
      outgoingChatBubbleConfig:
          widget.chatBubbleConfig?.outgoingChatBubbleConfig,
      isLongPressEnable: (featureActiveConfig?.enableReactionPopup ?? true) ||
          (featureActiveConfig?.enableReplySnackBar ?? true),
      inComingChatBubbleConfig:
          widget.chatBubbleConfig?.inComingChatBubbleConfig,
      message: widget.message,
      isMessageBySender: isMessageBySender,
      messageConfig: widget.messageConfig,
      onLongPress: widget.onLongPress,
      chatBubbleMaxWidth: widget.chatBubbleConfig?.maxWidth,
      longPressAnimationDuration:
          widget.chatBubbleConfig?.longPressAnimationDuration,
      shouldHighlight: widget.shouldHighlight,
      controller: chatController,
      highlightColor: widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
              .highlightColor ??
          Colors.grey,
      highlightScale: widget.repliedMessageConfig?.repliedMsgAutoScrollConfig
              .highlightScale ??
          1.1,
      onMaxDuration: _onMaxDuration,
    );
  }

  void _onMaxDuration(int duration) => maxDuration = duration;
}
