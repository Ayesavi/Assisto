part of '../../flutter_chatbook.dart';

class ChatBook extends StatefulWidget {
  const ChatBook({
    super.key,
    required this.chatController,
    required this.currentUserId,
    this.isCupertinoApp = false,
    this.onSendTap,
    this.profileCircleConfig,
    this.chatBubbleConfig,
    this.repliedMessageConfig,
    this.swipeToReplyConfig,
    this.replyPopupConfig,
    this.reactionPopupConfig,
    this.loadMoreData,
    this.loadingWidget,
    this.theme,
    this.messageConfig,
    this.isLastPage,
    this.appBar,
    this.cupertinoWidgetConfig,
    this.chatBackgroundConfig = const ChatBackgroundConfiguration(),
    this.typeIndicatorConfig,
    this.sendMessageBuilder,
    this.actions,
    this.sendMessageConfig,
    required this.roomId,
    required this.chatBookState,
    required this.recipientName,
    this.chatBookStateConfig = const ChatBookStateConfiguration(),
    this.featureActiveConfig = const FeatureActiveConfig(),
    this.textMessageParsers,
  });

  final String recipientName;

  /// Provides configuration related to user profile circle avatar.
  final ProfileCircleConfiguration? profileCircleConfig;

  /// Provides configurations related to chat bubble such as padding, margin, max
  /// width etc.
  final ChatBubbleConfiguration? chatBubbleConfig;

  /// Allow user to giving customisation different types
  /// messages.
  final MessageConfiguration? messageConfig;

  /// Provides configuration for replied message view which is located upon chat
  /// bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides configurations related to swipe chat bubble which triggers
  /// when user swipe chat bubble.
  final SwipeToReplyConfiguration? swipeToReplyConfig;

  /// Provides configuration for reply snack bar's appearance and options.
  final ReplyPopupConfiguration? replyPopupConfig;

  /// Provides configuration for reaction pop up appearance.
  final ReactionPopupConfiguration? reactionPopupConfig;

  /// Allow user to give customisation to background of chat
  final ChatBackgroundConfiguration chatBackgroundConfig;

  /// Provides callback when user actions reaches to top and needs to load more
  /// chat
  final VoidCallBackWithFuture? loadMoreData;

  /// Provides widget for loading view while pagination is enabled.
  final Widget? loadingWidget;

  /// Provides flag if there is no more next data left in list.
  final bool? isLastPage;

  /// Provides call back when user tap on send button in text field. It returns
  /// message, reply message and message type.
  final MessageCallBack? onSendTap;

  /// Provides builder which helps you to make custom text field and functionality.
  final ReplyMessageWithReturnWidget? sendMessageBuilder;

  /// Allow user to giving customisation typing indicator.
  final TypeIndicatorConfiguration? typeIndicatorConfig;

  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// Provides configuration of default text field in chat.
  final SendMessageConfiguration? sendMessageConfig;

  /// Provides current state of chat.
  final ChatBookState chatBookState;

  /// Provides configuration for chat view state appearance and functionality.
  final ChatBookStateConfiguration? chatBookStateConfig;

  /// Provides current user which is sending messages.
  final String currentUserId;

  /// Provides configuration for turn on/off specific features.
  final FeatureActiveConfig featureActiveConfig;

  /// Provides parameter so user can assign ChatBookAppbar.
  final Widget? appBar;

  /// Whether ChatBook is used inside [CupertinoApp] or not
  final bool isCupertinoApp;

  /// Configuration for CupertinoWidgets
  final CupertinoWidgetConfiguration? cupertinoWidgetConfig;

  /// Theme for the chatbook
  final AppTheme? theme;

  final int roomId;

  /// List of TextMessageParsers
  final List<TextMessageParser>? textMessageParsers;

  /// For onTapMoreActions in bottom sheet
  final OnTapMoreActions? actions;

  @override
  State<ChatBook> createState() => _ChatBookState();
}

class _ChatBookState extends State<ChatBook>
    with SingleTickerProviderStateMixin {
  /// [replyMessageNotifier] is used when a users tags a message to reply for it.
  /// It is used to in conjunction with [ValueListenableBuilder] to build tagged
  /// message at top of the [SendMessageWidget]
  ValueNotifier<Message?> replyMessageNotifier = ValueNotifier(null);

  /// ChatControleller attached by the User
  ChatController get _chatController => widget.chatController;

  /// Returns the configuration object for the chat background settings of the widget.
  ///
  /// The [chatBackgroundConfig] determines how the background of the chat interface is displayed.
  ChatBackgroundConfiguration get chatBackgroundConfig =>
      widget.chatBackgroundConfig;

  /// Returns the state object for the chat book of the widget.
  ///
  /// The [chatBookState] represents the state of the chat book within the widget.
  ChatBookState get chatBookState => widget.chatBookState;

  /// Returns the configuration object for the state of the chat book within the widget.
  ///
  /// The [chatBookStateConfig] provides additional configuration options for the chat book state.
  /// It can be null if no specific configuration is provided.
  ChatBookStateConfiguration? get chatBookStateConfig =>
      widget.chatBookStateConfig;

  /// Returns the configuration object for the active features of the widget.
  ///
  /// The [featureActiveConfig] determines which features are currently active in the chat widget.
  FeatureActiveConfig get featureActiveConfig => widget.featureActiveConfig;

  /// Builds the main chat interface widget.
  ///
  /// This method is responsible for rendering the chat interface based on the provided configuration and state.
  /// It returns a [ChatBookInheritedWidget] that wraps the chat interface components.
  ///
  /// The chat interface consists of the following components:
  ///   - A scrollable view to display chat messages.
  ///   - An optional app bar widget, if provided.
  ///   - The main chat content widget, which is determined by the [getWidget] method.
  ///   - An optional send message widget, if the [featureActiveConfig.enableTextField] flag is set to true which is by default set to true.
  ///
  /// The [chatController] is used to manage the chat state and control chat-related functionalities.
  /// The [featureActiveConfig] determines which features are active in the chat interface.
  /// The [currentUser] represents the current user in the chat.
  ///
  /// The [sendMessageBuilder] and [sendMessageConfig] are used to customize the send message widget.
  ///
  /// The [backgroundColor] is the background color of the chat interface, based on the [chatBackgroundConfig].
  ///
  /// The [onSendTap] is a callback function that is triggered when the send button is tapped.
  /// The [onReplyCallback] and [onReplyCloseCallback] are callback functions related to replying to messages.
  ///
  /// The [isCupertinoApp] flag indicates whether the app is running in a Cupertino (iOS) environment.
  /// If set to true, a [MaterialConditionalWrapper] is used to conditionally wrap the chat interface with a Cupertino style.
  @override
  Widget build(BuildContext context) {
    /// Checks if the typing indicator should be shown and there are existing messages in the chat book state.
    /// If both conditions are met, it scrolls the chat to the last message.
    ///
    /// The [widget.chatController.showTypingIndicator] property determines whether the typing indicator should be displayed.
    /// The [chatBookState.hasMessages] property indicates whether there are any existing messages in the chat book state.
    ///
    /// If both conditions are true, the [_chatController.scrollToLastMessage()] method is called to scroll the chat to the last message.
    if (widget.chatController.showTypingIndicator &&
        chatBookState.hasMessages) {
      _chatController.scrollToLastMessage();
    }

    return ChatBookInheritedWidget(
      recipientName: widget.recipientName,
      roomId: widget.roomId,
      textMessageParsers: widget.textMessageParsers ?? [],
      isCupertinoApp: widget.isCupertinoApp,
      onTapMoreActions: widget.actions,
      chatController: _chatController,
      cupertinoWidgetConfig: widget.cupertinoWidgetConfig,
      featureActiveConfig: featureActiveConfig,
      currentUserId: widget.currentUserId,
      child: MaterialConditionalWrapper(
        condition: widget.isCupertinoApp,
        child: Stack(
          children: [
            // A [SingleChildScrollView] is used to wrap the content of the chat interface to ensure smooth scrolling
            // and avoid janky behavior when the keyboard opens and closes.
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.appBar != null) widget.appBar!,
                Flexible(
                  child: getWidget(),
                ),
                if (featureActiveConfig.enableTextField)
                  SendMessageWidget(
                    replyMessageNotfier: replyMessageNotifier,
                    chatController: _chatController,
                    sendMessageBuilder: widget.sendMessageBuilder,
                    sendMessageConfig: widget.sendMessageConfig,
                    backgroundColor: chatBackgroundConfig.backgroundColor,
                    onSendTap: _onSendTap,
                    onReplyCallback: (reply) {},
                    onReplyCloseCallback: () {
                      replyMessageNotifier.value = null;
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSendTap(Message message) {
    if (widget.sendMessageBuilder == null) {
      if (widget.onSendTap != null) {
        widget.onSendTap!(message);
      }
      _assignReplyMessage();
    }
    _chatController.scrollToLastMessage();
  }

  Widget getWidget() {
    if (chatBookState.isLoading) {
      return ChatBookStateWidget(
        chatBookStateWidgetConfig: chatBookStateConfig?.loadingWidgetConfig,
        chatBookState: chatBookState,
      );
    } else if (chatBookState.noMessages) {
      return ChatBookStateWidget(
        chatBookStateWidgetConfig: chatBookStateConfig?.noMessageWidgetConfig,
        chatBookState: chatBookState,
        onReloadButtonTap: chatBookStateConfig?.onReloadButtonTap,
      );
    } else if (chatBookState.isError) {
      return ChatBookStateWidget(
        chatBookStateWidgetConfig: chatBookStateConfig?.errorWidgetConfig,
        chatBookState: chatBookState,
        onReloadButtonTap: chatBookStateConfig?.onReloadButtonTap,
      );
    } else if (chatBookState.hasMessages) {
      return ValueListenableBuilder<Message?>(
        valueListenable: replyMessageNotifier,
        builder: (_, state, child) {
          return ChatListWidget(
              replyMessage: state,
              chatController: widget.chatController,
              chatBackgroundConfig: widget.chatBackgroundConfig,
              reactionPopupConfig: widget.reactionPopupConfig,
              typeIndicatorConfig: widget.typeIndicatorConfig,
              chatBubbleConfig: widget.chatBubbleConfig,
              loadMoreData: widget.loadMoreData,
              isLastPage: widget.isLastPage,
              replyPopupConfig: widget.replyPopupConfig,
              loadingWidget: widget.loadingWidget,
              messageConfig: widget.messageConfig,
              profileCircleConfig: widget.profileCircleConfig,
              repliedMessageConfig: widget.repliedMessageConfig,
              swipeToReplyConfig: widget.swipeToReplyConfig,
              assignReplyMessage: (message) {
                replyMessageNotifier.value = message;
              });
        },
      );
    } else {
      return const SizedBox();
    }
  }

  /// Resets the reply message notifier by setting its value to null.
  ///
  /// The [_assignReplyMessage] method is called to clear the reply message if it exists.
  /// It checks if the [replyMessageNotifier.value] is not null, and if so, sets it to null.
  void _assignReplyMessage() {
    if (replyMessageNotifier.value != null) {
      replyMessageNotifier.value = null;
    }
  }

  /// Performs necessary cleanup operations when the widget is disposed.
  ///
  /// The [replyMessageNotifier] is disposed to release any resources held by it.
  /// The [ChatBook] singleton instance is unregistered from the service locator.
  /// Finally, the [super.dispose()] method is called to perform additional cleanup.
  @override
  void dispose() {
    replyMessageNotifier.dispose();
    super.dispose();
  }
}
