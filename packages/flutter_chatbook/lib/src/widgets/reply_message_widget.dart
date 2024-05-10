part of '../../flutter_chatbook.dart';

class ReplyMessageWidget extends StatelessWidget {
  const ReplyMessageWidget({
    Key? key,
    required this.message,
    this.repliedMessageConfig,
    this.onTap,
  }) : super(key: key);

  /// Provides message instance of chat.
  final Message message;

  /// Provides configurations related to replied message such as textstyle
  /// padding, margin etc. Also, this widget is located upon chat bubble.
  final RepliedMessageConfiguration? repliedMessageConfig;

  /// Provides call back when user taps on replied message.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final currentUserId = ChatBookInheritedWidget.of(context)?.currentUserId;
    final replyBySender = message.repliedMessage?.authorId == currentUserId;
    final textTheme = Theme.of(context).textTheme;
    final chatController = ChatBookInheritedWidget.of(context)?.chatController;
    final messagedUser = message.repliedMessage?.authorId;
    final replyBy = replyBySender ? PackageStrings.you : messagedUser;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipPath(
          child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 8))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          replyBy?.toFirstUpper ?? '',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        )),
                    replyWidget(context, message, textTheme, chatController,
                        replyBySender)
                  ])),
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
        ),
      ),
    );
  }

  replyWidget(BuildContext context, Message message, TextTheme textTheme,
      ChatController? chatController, bool replyBySender) {
    final replyMessage = message.repliedMessage!;

    switch (message.repliedMessage!.type) {
      case MessageType.text:
        final msg = replyMessage as TextMessage;
        return Text(
          msg.text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w400),
        );

      case MessageType.payment:
        final msg = replyMessage as TextMessage;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.doc,
              color: repliedMessageConfig?.micIconColor ?? Colors.white,
            ),
            const SizedBox(width: 2),
            // Text(
            //   msg.name + (msg.size != null ? _formatBytes(msg.size!) : ""),
            //   style: repliedMessageConfig?.textStyle,
            // ),
          ],
        );
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      double kb = bytes / 1024;
      return '${kb.toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      double mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(2)} MB';
    } else {
      double gb = bytes / (1024 * 1024 * 1024);
      return '${gb.toStringAsFixed(2)} GB';
    }
  }
}
