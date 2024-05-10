part of '../../flutter_chatbook.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget(
      {Key? key,
      required this.onSendTap,
      required this.chatController,
      this.sendMessageConfig,
      this.backgroundColor,
      this.sendMessageBuilder,
      this.onReplyCallback,
      required this.replyMessageNotfier,
      this.onReplyCloseCallback,
      this.showToolBarButtons = false})
      : super(key: key);

  /// Provides call back when user tap on send button on text field.
  final MessageCallBack onSendTap;

  /// Provides configuration for text field appearance.
  final SendMessageConfiguration? sendMessageConfig;

  /// Allow user to set background colour.
  final Color? backgroundColor;

  /// Allow user to set custom text field.
  final ReplyMessageWithReturnWidget? sendMessageBuilder;

  /// Provides callback when user swipes chat bubble for reply.
  final ReplyMessageCallBack? onReplyCallback;

  /// Provides call when user tap on close button which is showed in reply pop-up.
  final VoidCallBack? onReplyCloseCallback;

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  final ValueNotifier<Message?> replyMessageNotfier;

  /// Whether to show toolbarbuttons at the text field
  final bool showToolBarButtons;

  @override
  State<SendMessageWidget> createState() => SendMessageWidgetState();
}

class SendMessageWidgetState extends State<SendMessageWidget> {
  late final TextEditingController _textEditingController;

  final ValueNotifier<Message?> _replyMessage = ValueNotifier(null);

  Message? get replyMessage => _replyMessage.value;

  String? get repliedUser => replyMessage?.authorId;

  String get _replyTo =>
      replyMessage?.authorId == currentUserId ? PackageStrings.you : '';

  String? currentUserId;

  ChatController? chatController;

  @override
  void initState() {
    widget.replyMessageNotfier.addListener(() {
      _replyMessage.value = widget.replyMessageNotfier.value;
    });
    _textEditingController = widget.chatController.inputController;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      currentUserId = provide!.currentUserId;
      chatController = provide!.chatController;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.sendMessageBuilder != null
        ? Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: widget.sendMessageBuilder!(replyMessage),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height /
                          ((!kIsWeb && Platform.isIOS) ? 24 : 28),
                      // color: widget.backgroundColor ?? Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      bottomPadding4,
                      bottomPadding4,
                      bottomPadding4,
                      _bottomPadding,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ChatUITextField(
                            threaded: threadedMsg,
                            focusNode: chatController?.focusNode ?? FocusNode(),
                            chatController: widget.chatController,
                            textEditingController: _textEditingController,
                            onPressed: () => _onPressed.call(context),
                            sendMessageConfig: widget.sendMessageConfig,
                            showToolBarButtons: widget.showToolBarButtons)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget get threadedMsg {
    final replyTitle = "${PackageStrings.replyTo} ";

    return ValueListenableBuilder<Message?>(
      builder: (_, state, child) {
        if (state != null) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    border: Border(
                        left: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              replyTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 16,
                              ),
                              onTap: _onCloseTap,
                            ),
                          ]),
                    ),
                    if (state.type.isPayment)
                      _docMessageView
                    else
                      (() {
                        state as TextMessage;
                        return Text(
                          state.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        );
                      }())
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      valueListenable: _replyMessage,
    );
  }

  Widget get _docMessageView {
    return Row(
      children: [
        Icon(
          CupertinoIcons.doc,
          size: 20,
          color: widget.sendMessageConfig?.replyMessageColor ??
              Colors.grey.shade700,
        ),
        Text(
          PackageStrings.photo,
          style: TextStyle(
            color: widget.sendMessageConfig?.replyMessageColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  void _assignRepliedMessage() {
    if (replyMessage != null) {
      _replyMessage.value = null;
    }
  }

  void _onPressed(context) {
    if (_textEditingController.text.isNotEmpty &&
        !_textEditingController.text.startsWith('\n')) {
      widget.onSendTap.call(TextMessage(
        roomId: ChatBookInheritedWidget.of(context)?.roomId ?? "",
        authorId: currentUserId!,
        id: const Uuid().v4(),
        createdAt: DateTime.now(),
        type: MessageType.text,
        text: _textEditingController.text.trim(),
        repliedMessage: replyMessage,
      ));
      _assignRepliedMessage();
      _textEditingController.clear();
    }
  }

  void assignReplyMessage(Message message) {
    if (currentUserId != null) {
      _replyMessage.value = message;
    }
    FocusScope.of(context).requestFocus(chatController?.focusNode);
    if (widget.onReplyCallback != null) widget.onReplyCallback!(replyMessage!);
  }

  void _onCloseTap() {
    _replyMessage.value = null;
    if (widget.onReplyCloseCallback != null) widget.onReplyCloseCallback!();
  }

  double get _bottomPadding => (!kIsWeb && Platform.isIOS)
      ? (chatController?.focusNode.hasFocus ?? false
          ? bottomPadding1
          : View.of(context).viewPadding.bottom > 0
              ? bottomPadding2
              : bottomPadding3)
      : bottomPadding3;

  @override
  void dispose() {
    _textEditingController.dispose();
    chatController?.focusNode.dispose();
    _replyMessage.dispose();
    super.dispose();
  }
}
