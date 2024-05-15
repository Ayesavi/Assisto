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

  /// To controll receiptsBuilderVisibility.
  final bool receiptsBuilderVisibility;

  /// Whether message is last or no for displaying receipts
  final bool isLastMessage;

  /// For [ReadMoreConfig] to access read more configuration.
  final MessageConfiguration? messageConfiguration;

  final ValueNotifier<bool> _isExpanded = ValueNotifier(true);

  final bool isPrevAuthorSame;

  Widget textWidget(TextTheme textTheme, String text, context) => ParsedText(
        selectable: false,
        text: text + "                   ",
        style: _textStyle ??
            textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
        parse: [
          MatchText(
            pattern: TextMessageParser.bold.pattern,
            style: TextMessageParser.bold.textStyle,
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                TextMessageParser.bold.from,
                TextMessageParser.bold.replace.call(str),
              ),
            },
          ),
          MatchText(
            pattern: TextMessageParser.italic.pattern,
            style: TextMessageParser.italic.textStyle,
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                TextMessageParser.italic.from,
                TextMessageParser.italic.replace.call(str),
              ),
            },
          ),
          MatchText(
            pattern: TextMessageParser.lineThrough.pattern,
            style: (TextMessageParser.lineThrough.textStyle),
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                TextMessageParser.lineThrough.from,
                TextMessageParser.lineThrough.replace.call(str),
              ),
            },
          ),
          MatchText(
            pattern: TextMessageParser.code.pattern,
            style: (TextMessageParser.code.textStyle),
            renderText: ({required String str, required String pattern}) {
              return {
                'display': str.replaceAll(
                  TextMessageParser.code.from,
                  TextMessageParser.code.replace.call(str),
                ),
              };
            },
          ),
          ...ChatBookInheritedWidget.of(context)!.textMessageParsers.map(
                (e) => MatchText(
                  pattern: e.pattern,
                  style: (e.textStyle),
                  onTap: (str) => e.onTap?.call(str),
                  renderText: ({required String str, required String pattern}) {
                    return {
                      'display': str.replaceAll(
                        e.from,
                        e.replace.call(str),
                      ),
                    };
                  },
                ),
              )
        ],
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
                      400)
              ? textWidget(textTheme, message.text, context)
              : ValueListenableBuilder<bool>(
                  valueListenable: _isExpanded,
                  builder: (BuildContext context, value, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            textTheme,
                            _isExpanded.value
                                ? '${message.text.substring(0, messageConfiguration?.readMoreConfig?.numOfWordsAfterEnableReadMore ?? 400)}...'
                                : message.text,
                            context),
                        messageConfiguration?.readMoreConfig?.readMoreWidget ??
                            GestureDetector(
                                onTap: () =>
                                    _isExpanded.value = !_isExpanded.value,
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: !_isExpanded.value
                                        ? Text("Read Less",
                                            style: _textStyle ??
                                                textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ))
                                        : Text("Read More",
                                            style: _textStyle ??
                                                textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ))))
                      ],
                    );
                  },
                ),
        ),
        if (receiptsBuilderVisibility) ...[
          // MessageTimeWidget(
          //   message,
          //   isMessageBySender,
          // )
        ],
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
