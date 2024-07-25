part of '../../flutter_chatbook.dart';

class TextMessageView extends StatelessWidget {
  TextMessageView({
    Key? key,
    required this.isMessageBySender,
    required this.message,
    required this.isLastMessage,
    this.messageConfiguration,
    this.chatBubbleMaxWidth,
    this.inComingChatBubbleConfig,
    this.outgoingChatBubbleConfig,
    this.highlightMessage = false,
    this.receiptsBuilderVisibility = true,
    this.highlightColor,
    required this.isPrevAuthorSame,
  }) : super(key: key);

  /// Represents current message is sent by current user.
  final bool isMessageBySender;

  /// Provides message instance of chat.
  final TextMessage message;

  /// Allow users to give max width of chat bubble.
  final double? chatBubbleMaxWidth;

  /// Provides configuration of chat bubble appearance from other user of chat.
  final ChatBubble? inComingChatBubbleConfig;

  /// Provides configuration of chat bubble appearance from current user of chat.
  final ChatBubble? outgoingChatBubbleConfig;

  /// Represents message should highlight.
  final bool highlightMessage;

  /// Allow user to set color of highlighted message.
  final Color? highlightColor;

  /// To control receiptsBuilderVisibility.
  final bool receiptsBuilderVisibility;

  /// Whether message is last or not for displaying receipts
  final bool isLastMessage;

  /// For [ReadMoreConfig] to access read more configuration.
  final MessageConfiguration? messageConfiguration;

  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  final bool isPrevAuthorSame;

  Widget textWidget(TextTheme textTheme, String text, context) => RichText(
        text: TextSpan(
          children: <TextSpan>[
            // real message
            TextSpan(
              text: text + "    ",
              style: _textStyle ??
                  textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
            ),
            // fake additionalInfo as placeholder
            TextSpan(
                text: DateFormat('hh:mm a').format((message.createdAt)),
                style: TextStyle(
                  color: Colors.transparent,
                )),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: message.text.length <=
                  (messageConfiguration
                          ?.readMoreConfig?.numOfWordsAfterEnableReadMore ??
                      50)
              ? textWidget(textTheme, message.text, context)
              : ValueListenableBuilder<bool>(
                  valueListenable: _isExpanded,
                  builder: (BuildContext context, value, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedSize(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: textWidget(
                              textTheme,
                              _isExpanded.value
                                  ? message.text
                                  : '${message.text.substring(0, messageConfiguration?.readMoreConfig?.numOfWordsAfterEnableReadMore ?? 50)}...',
                              context),
                        ),
                        messageConfiguration?.readMoreConfig?.readMoreWidget ??
                            TextButton(
                                onPressed: () =>
                                    _isExpanded.value = !_isExpanded.value,
                                child: Text(
                                  _isExpanded.value
                                      ? "Read Less"
                                      : "Read More...",
                                  style: _textStyle ??
                                      textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                ))
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  EdgeInsetsGeometry? get padding => isMessageBySender
      ? outgoingChatBubbleConfig?.padding
      : inComingChatBubbleConfig?.padding;

  EdgeInsetsGeometry? get margin => isMessageBySender
      ? outgoingChatBubbleConfig?.margin
      : inComingChatBubbleConfig?.margin;

  LinkPreviewConfiguration? get linkPreviewConfig => isMessageBySender
      ? outgoingChatBubbleConfig?.linkPreviewConfig
      : inComingChatBubbleConfig?.linkPreviewConfig;

  TextStyle? get _textStyle => isMessageBySender
      ? outgoingChatBubbleConfig?.textStyle
      : inComingChatBubbleConfig?.textStyle;
}
