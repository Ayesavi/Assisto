part of '../../flutter_chatbook.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    Key? key,
    required this.message,
    required this.isMessageBySender,
    required this.onLongPress,
    required this.isLongPressEnable,
    this.chatBubbleMaxWidth,
    this.inComingChatBubbleConfig,
    this.outgoingChatBubbleConfig,
    this.longPressAnimationDuration,
    this.onDoubleTap,
    this.highlightColor = Colors.grey,
    this.shouldHighlight = false,
    this.highlightScale = 1.2,
    this.messageConfig,
    this.onMaxDuration,
    this.repliedMessageConfig,
    this.onReplyTap,
    required this.isPrevAuthorSame,
    this.controller,
  }) : super(key: key);

  /// Provides message instance of chat.
  final Message message;

  /// Represents current message is sent by current user.
  final bool isMessageBySender;

  /// Give callback once user long press on chat bubble.
  final void Function() onLongPress;

  /// Allow users to give max width of chat bubble.
  final double? chatBubbleMaxWidth;

  /// Provides configuration of chat bubble appearance from other user of chat.
  final ChatBubble? inComingChatBubbleConfig;

  /// Provides configuration of chat bubble appearance from current user of chat.
  final ChatBubble? outgoingChatBubbleConfig;

  /// Allow users to give duration of animation when user long press on chat bubble.
  final Duration? longPressAnimationDuration;

  /// Allow user to set some action when user double tap on chat bubble.
  final MessageCallBack? onDoubleTap;

  /// Allow users to pass colour of chat bubble when user taps on replied message.
  final Color highlightColor;

  /// Allow users to turn on/off highlighting chat bubble when user tap on replied message.
  final bool shouldHighlight;

  /// Provides scale of highlighted image when user taps on replied image.
  final double highlightScale;

  /// Allow user to giving customisation different types
  /// messages.
  final MessageConfiguration? messageConfig;

  /// Allow user to turn on/off long press tap on chat bubble.
  final bool isLongPressEnable;

  final ChatController? controller;

  final Function(int)? onMaxDuration;

  final bool isPrevAuthorSame;

  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides callback when user tap on replied message upon chat bubble.
  final Function(String message)? onReplyTap;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  MessageConfiguration? get messageConfig => widget.messageConfig;

  bool get isLongPressEnable => widget.isLongPressEnable;

  bool get isCupertino =>
      ChatBookInheritedWidget.of(context)?.isCupertinoApp ?? false;

  bool get isMessageBySender =>
      widget.message.authorId ==
      ChatBookInheritedWidget.of(context)?.currentUserId;

  ValueNotifier<bool> isOn = ValueNotifier(false);

  bool receiptsVisibility = true;

  bool isLastMessage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      receiptsVisibility =
          provide!.featureActiveConfig.receiptsBuilderVisibility;
      isLastMessage =
          provide!.chatController.initialMessageList.first == widget.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _messageView;
  }

  EdgeInsetsGeometry? get _padding => isMessageBySender
      ? widget.outgoingChatBubbleConfig?.padding
      : widget.inComingChatBubbleConfig?.padding;

  EdgeInsetsGeometry? get _margin => isMessageBySender
      ? widget.outgoingChatBubbleConfig?.margin
      : widget.inComingChatBubbleConfig?.margin;

  LinkPreviewConfiguration? get linkPreviewConfig => isMessageBySender
      ? widget.outgoingChatBubbleConfig?.linkPreviewConfig
      : widget.inComingChatBubbleConfig?.linkPreviewConfig;

  Color get _color => isMessageBySender
      ? widget.outgoingChatBubbleConfig?.color ??
          Theme.of(context).colorScheme.primary
      : widget.inComingChatBubbleConfig?.color ??
          Theme.of(context).colorScheme.surfaceContainerHighest;

  Widget get _messageView {
    if (!isMessageBySender) {
      Future.delayed(const Duration(milliseconds: 200), () {
        widget.inComingChatBubbleConfig?.onMessageRead?.call(widget.message);
      });
    }
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
              minWidth: 140,
              maxWidth: widget.chatBubbleMaxWidth ??
                  MediaQuery.of(context).size.width * 0.75),
          padding: _padding ??
              (
                  // Main bubble padding
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              )),
          margin: _margin ?? EdgeInsets.fromLTRB(5, 0, 6, 2),
          decoration: BoxDecoration(
              color: widget.shouldHighlight ? widget.highlightColor : _color,
              borderRadius: BorderRadius.circular(16)),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.message.repliedMessage != null)
                  ReplyMessageWidget(
                    message: widget.message,
                    repliedMessageConfig: widget.repliedMessageConfig,
                    onTap: () => widget.onReplyTap
                        ?.call(widget.message.repliedMessage!.id),
                  ),
                Column(
                  crossAxisAlignment: isMessageBySender
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.start,
                  children: [
                    if (!isMessageBySender && !widget.isPrevAuthorSame)
                      Padding(
                        // borderRadius: BorderRadius.only(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        child: const SizedBox(),
                      ),
                    (() {
                          if (widget.message.type.isText) {
                            return TextMessageView(
                              isPrevAuthorSame: widget.isPrevAuthorSame,
                              isLastMessage: isLastMessage,
                              messageConfiguration: messageConfig,
                              inComingChatBubbleConfig:
                                  widget.inComingChatBubbleConfig,
                              receiptsBuilderVisibility: receiptsVisibility,
                              outgoingChatBubbleConfig:
                                  widget.outgoingChatBubbleConfig,
                              isMessageBySender: widget.isMessageBySender,
                              message: widget.message as TextMessage,
                              chatBubbleMaxWidth: widget.chatBubbleMaxWidth,
                              highlightColor: widget.highlightColor,
                              highlightMessage: widget.shouldHighlight,
                            );
                          }
                        }()) ??
                        const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: MessageTimeWidget(
                widget.message,
                isMessageBySender,
              )),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
