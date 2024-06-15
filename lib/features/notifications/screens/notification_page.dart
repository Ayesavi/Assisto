import 'package:assisto/features/notifications/controllers/notification_page_controller.dart';
import 'package:assisto/models/notification_model/notification_model.dart';
import 'package:assisto/widgets/notification_tile/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({
    super.key,
  });

  Map<String, List<NotificationModel>> _groupNotificationsByDate(
      List<NotificationModel> notifications) {
    Map<String, List<NotificationModel>> groupedNotifications = {};
    for (var notification in notifications) {
      String dateKey = DateFormat('yyyy-MM-dd').format(notification.createdAt);
      if (groupedNotifications[dateKey] == null) {
        groupedNotifications[dateKey] = [];
      }
      groupedNotifications[dateKey]!.add(notification);
    }
    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationModel> notifications = _mockNotifications;
    final groupedNotifications = _groupNotificationsByDate(notifications);

    final sortedDateKeys = groupedNotifications.keys.toList()
      ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));
    final state = ref.watch(notificationPageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: state.when(loading: () {
          return const Center(child: CircularProgressIndicator());
        }, data: (data) {
          return ListView.builder(
            itemCount: groupedNotifications.length,
            itemBuilder: (context, index) {
              String dateKey = sortedDateKeys[index];
              List<NotificationModel> dateGroup =
                  groupedNotifications[dateKey]!;
              return _buildDateGroup(dateKey, dateGroup);
            },
          );
        }, error: (e) {
          return Center(
            child: Text(e.message),
          );
        }),
      ),
    );
  }

  String _formatDateKey(String dateKey) {
    DateTime date = DateTime.parse(dateKey);
    DateTime now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  Widget _buildDateGroup(String dateKey, List<NotificationModel> dateGroup) {
    String formattedDate = _formatDateKey(dateKey);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formattedDate,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...dateGroup.map((notification) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NotificationTile(
                  notification: notification,
                  onPress: () {},
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )),
      ],
    );
  }
}

final List<NotificationModel> _mockNotifications = [
  NotificationModel(
    id: 1,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    recipientId: 'user123',
    content: 'You have a new task assigned.',
    isRead: false,
    channel: NotificationChannels.task,
    priority: NotificationPriority.high,
  ),
  NotificationModel(
    id: 2,
    createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    recipientId: 'user456',
    content: 'Your payment has been processed successfully.',
    isRead: true,
    channel: NotificationChannels.payments,
    priority: NotificationPriority.low,
  ),
  NotificationModel(
    id: 3,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    recipientId: 'user789',
    content: 'New announcement from the management.',
    isRead: false,
    channel: NotificationChannels.announcement,
    priority: NotificationPriority.moderate,
  ),
  NotificationModel(
    id: 4,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    recipientId: 'user123',
    content: 'A new bidding opportunity is available.',
    isRead: true,
    channel: NotificationChannels.biddings,
    priority: NotificationPriority.high,
  ),
  NotificationModel(
    id: 5,
    createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
    recipientId: 'user456',
    content: 'Recommendation for you based on your recent activities.',
    isRead: false,
    channel: NotificationChannels.recommendation,
    priority: NotificationPriority.moderate,
  ),
  NotificationModel(
    id: 6,
    createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    recipientId: 'user123',
    content: 'You have a new friend request.',
    isRead: true,
    channel: NotificationChannels.announcement,
    priority: NotificationPriority.low,
  ),
];
