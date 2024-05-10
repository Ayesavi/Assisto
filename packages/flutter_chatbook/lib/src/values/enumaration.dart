
/// Events, Wheter the user is still typing a message or has
/// typed the message
enum TypeWriterStatus { typing, typed }

/// [DeliveryStatus] defines the current state of the message
/// if you are sender sending a message then, the
// enum DeliveryStatus { read, delivered, undelivered, pending }

/// Types of states
enum ChatBookState { hasMessages, noData, loading, error }

enum ShowReceiptsIn {
  allInside,
  allOutside,
  lastMessageInside,
  lastMessageOutside
}


enum ReceiptsBubblePreference { inside, outSide }

extension ChatBookStateExtension on ChatBookState {
  bool get hasMessages => this == ChatBookState.hasMessages;

  bool get isLoading => this == ChatBookState.loading;

  bool get isError => this == ChatBookState.error;

  bool get noMessages => this == ChatBookState.noData;
}

enum ToolBarPriority { high, medium, low }
