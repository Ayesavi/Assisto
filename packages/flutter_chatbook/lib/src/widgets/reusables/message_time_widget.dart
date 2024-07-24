part of '../../../flutter_chatbook.dart';

class MessageTimeWidget extends StatelessWidget {
  final Message message;
  final bool isMessageBySender;
  final ChatBubble? incomingBubbleConfig;
  final ChatBubble? outgoingBubbleConfig;

  const MessageTimeWidget(
    this.message,
    this.isMessageBySender, {
    this.incomingBubbleConfig,
    this.outgoingBubbleConfig,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final config =
        isMessageBySender ? outgoingBubbleConfig : incomingBubbleConfig;
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 2),
        child: receiptWidget(context, config));
  }

  Widget receiptWidget(BuildContext context, ChatBubble? config) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DateFormat('hh:mm a').format((message.createdAt)),
              style: config?.timeStampTextStyle),
        ],
      );
}
