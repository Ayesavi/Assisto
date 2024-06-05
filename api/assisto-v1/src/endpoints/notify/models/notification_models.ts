interface NotificationData {
  event: RecommendationEvents | TaskEvents | ChatEvents;
  event_info: any;
}

enum NotificationChannels {
  TASK = "task",
  RECOMMENDATIONS = "recommendations",
  CHAT = "chat",
}

enum RecommendationEvents {
  NEW_TASK = "new_task",
}

enum TaskEvents {
  UPDATE = "update",
  INSERT = "insert",
}

enum ChatEvents {
  INSERT = "insert",
  UPDATE = "update",
}

interface NotificationModel {
  channel: NotificationChannels;
  title: string;
  body: string;
  group_key?: string;
  data: NotificationData;
}

export {
  ChatEvents,
  NotificationChannels,
  NotificationModel,
  RecommendationEvents,
  TaskEvents,
};
