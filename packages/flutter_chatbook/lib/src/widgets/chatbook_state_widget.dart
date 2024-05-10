part of '../../flutter_chatbook.dart';

class ChatBookStateWidget extends StatelessWidget {
  const ChatBookStateWidget({
    Key? key,
    this.chatBookStateWidgetConfig,
    required this.chatBookState,
    this.onReloadButtonTap,
  }) : super(key: key);

  /// Provides configuration of chat view's different states such as text styles,
  /// widgets and etc.
  final ChatBookStateWidgetConfiguration? chatBookStateWidgetConfig;

  /// Provides current state of chat view.
  final ChatBookState chatBookState;

  /// Provides callback when user taps on reload button in error and no messages
  /// state.
  final VoidCallBack? onReloadButtonTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: chatBookStateWidgetConfig?.widget ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (chatBookStateWidgetConfig?.title
                    .getChatBookStateTitle(chatBookState))!,
                style: chatBookStateWidgetConfig?.titleTextStyle ??
                    const TextStyle(
                      fontSize: 22,
                    ),
              ),
              if (chatBookStateWidgetConfig?.subTitle != null)
                Text(
                  (chatBookStateWidgetConfig?.subTitle)!,
                  style: chatBookStateWidgetConfig?.subTitleTextStyle,
                ),
              if (chatBookState.isLoading)
                CircularProgressIndicator(
                  color: chatBookStateWidgetConfig?.loadingIndicatorColor,
                ),
              if (chatBookStateWidgetConfig?.imageWidget != null)
                (chatBookStateWidgetConfig?.imageWidget)!,
              if (chatBookStateWidgetConfig?.reloadButton != null)
                (chatBookStateWidgetConfig?.reloadButton)!,
              if (chatBookStateWidgetConfig != null &&
                  (chatBookStateWidgetConfig?.showDefaultReloadButton)! &&
                  chatBookStateWidgetConfig?.reloadButton == null &&
                  (chatBookState.isError || chatBookState.noMessages)) ...[
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onReloadButtonTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        chatBookStateWidgetConfig?.reloadButtonColor ??
                            const Color(0xffEE5366),
                  ),
                  child: const Text('Reload'),
                )
              ]
            ],
          ),
    );
  }
}
