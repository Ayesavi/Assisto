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
    final remoteUserName = ChatBookInheritedWidget.of(context)?.recipientName;

    // todo: use this and show usermessage on reply to
    // final messagedUser = message.repliedMessage?.authorId;
    final replyBy = replyBySender ? PackageStrings.you : remoteUserName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                          replyBySender, currentUserId, remoteUserName)
                    ])),
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
      ),
    );
  }

  replyWidget(
      BuildContext context,
      Message message,
      TextTheme textTheme,
      ChatController? chatController,
      bool replyBySender,
      String? currentUserId,
      String? remoteUserName) {
    final replyMessage = message.repliedMessage!;

    switch (message.repliedMessage!.type) {
      case MessageType.text:
        final msg = replyMessage as TextMessage;
        return Text(
          msg.text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w400),
        );

      case MessageType.payment:
        final msg = replyMessage as PaymentMessage;
        return _paymentReplyView(msg, context, currentUserId, remoteUserName!);
    }
  }

  Widget _paymentReplyView(PaymentMessage message, BuildContext context,
      String? currentUserId, String? remoteUserName) {
    final isRequest = message.paymentType == PaymentType.request;
    final isPaymentByYou = message.authorId == currentUserId;
    final title = isPaymentByYou
        ? '${isRequest ? 'Request' : 'Payment'} to ${remoteUserName}'
        : '${isRequest ? 'Request' : 'Payment'} to you';
    return Text(title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer));
  }
}
