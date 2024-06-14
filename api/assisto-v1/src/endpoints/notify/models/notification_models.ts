

enum NotificationChannels {
  TASK = "task",
  RECOMMENDATIONS = "recommendations",
  CHAT = "chat",
  OFFER = "offer",

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


export {
  ChatEvents,
  NotificationChannels,
  RecommendationEvents,
  TaskEvents,
};
