import 'package:assisto/models/notification_model/notification_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback? onPress;

  const NotificationTile({
    super.key,
    required this.notification,
    this.onPress,
  });

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  String _formatDate(DateTime date) {
    final localDate = date.toLocal();
    return DateFormat('hh:mm a').format(localDate);
  }

  IconData _widgetIconData() {
    switch (widget.notification.channel) {
      case NotificationChannels.recommendation:
        return Icons.add_alert_outlined;
      case NotificationChannels.task:
        return Icons.task_alt;
      case NotificationChannels.biddings:
        return Icons.attach_money;
      case NotificationChannels.payments:
        return Icons.payment;
      case NotificationChannels.announcement:
        return Icons.campaign_outlined;
      default:
        return Icons.notifications_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: !widget.notification.isRead
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          _widgetIconData(),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      title: BodyMedium(
        text: widget.notification.content,
        maxLines: 3,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.mail_outline_outlined,
          ),
          const SizedBox(height: 4.0),
          LabelSmall(text: _formatDate(widget.notification.createdAt)),
        ],
      ),
      onTap: widget.onPress,
    );
  }
}
