part of '../../../flutter_chatbook.dart';

class MessageTimeWidget extends StatelessWidget {
  final Message message;
  final bool isMessageBySender;

  const MessageTimeWidget(
    this.message,
    this.isMessageBySender, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 2),
        child: receiptWidget(context));
  }

  Widget receiptWidget(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DateFormat('hh:mm a').format((message.createdAt)),
              style: TextStyle(
                  color: isMessageBySender
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 11)),
          const SizedBox(width: 5),
        ],
      );
}
