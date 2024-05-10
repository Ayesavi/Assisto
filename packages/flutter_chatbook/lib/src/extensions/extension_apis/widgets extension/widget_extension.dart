// import 'package:flutter/material.dart';

// import '../../../../flutter_chatbook.dart';

// /// The `WidgetsExtension` class provides an extension for widgets that support new message types.
// class WidgetsExtension {
//   /// Creates a new instance of the `WidgetsExtension` class.
//   ///
//   /// The [messageTypes] parameter is a required list of [NewMessageSupport] objects representing different message types.
//   WidgetsExtension({required this.messageTypes});

//   /// A list of supported message types.
//   final List<NewMessageSupport> messageTypes;

//   /// Retrieves the message support for a given message.
//   ///
//   /// The [message] parameter is the message for which the message support is requested.
//   ///
//   /// Returns the corresponding [NewMessageSupport] object for the given message.
//   NewMessageSupport getMessageSuport(CustomMessage message) {
//     return messageTypes
//         .firstWhere((element) => element.customType == message.customType);
//   }
// }

// /// The `NewMessageSupport` class represents the support for a new message type.
// ///
// /// It provides various properties and methods related to the message type.
// abstract class NewMessageSupport<T extends Message> {
//   /// Creates a new instance of the `NewMessageSupport` class.
//   ///
//   /// 1. The [messageClass] parameter is the class type of the message.
//   /// 2. The [messageBuilder] parameter is a required function that builds the message widget.
//   /// 3. The [customType] parameter is a required string representing the custom type of the message.
//   /// 4. The [title] parameter is a required string representing the title of the message type.
//   /// 5. The [onMessageCreation] parameter is a required function that handles message creation.
//   /// 6. The [replyPreview] parameter is a required function that builds the reply preview widget.
//   /// 7. The [repliedMessageBuilder] parameter is a required function that builds the replied message widget.
//   /// 8. The [icon] parameter is an optional widget representing the icon for the message type.
//   /// 9. The [onSendPress] parameter is an optional function that handles the send button press.
//   /// 10. The [priority] parameter is an optional [ToolBarPriority] enum value representing the priority of the message type in the tool bar at the message input textfield.
//   /// 11. The [customToolBarWidget] parameter is an optional function that builds a custom toolbar widget.
//   /// 12. The [isSwipeable] parameter is an optional boolean indicating whether the message is swipeable.
//   /// 13. The [isInsideBubble] parameter is an optional boolean indicating whether the message is inside a bubble.
//   /// 14. The [isReactable] parameter is an optional boolean indicating whether the message is reactable.

//   NewMessageSupport(this.messageClass,
//       {required this.messageBuilder,
//       required this.customType,
//       required this.title,
//       required this.onMessageCreation,
//       required this.replyPreview,
//       required this.repliedMessageBuilder,
//       this.icon,
//       this.onSendPress,
//       this.priority = ToolBarPriority.medium,
//       this.customToolBarWidget,
//       this.isSwipeable = true,
//       this.isInsideBubble = true,
//       this.isReactable = false});

//   /// The class type of the message.
//   final Type messageClass;

//   /// The custom type of the message.
//   final String customType;

//   /// A function that builds the message widget.
//   final Widget Function(BuildContext context, Message message) messageBuilder;

//   /// An optional widget representing the icon for the message type.
//   final Widget? icon;

//   /// The title of the message type.
//   final String title;

//   /// An optional function that builds a custom toolbar widget.
//   final Widget? Function(BuildContext context)? customToolBarWidget;

//   /// An optional function that handles the send button press.
//   final Function(T message)? onSendPress;

//   /// A function that builds the reply preview widget.
//   final Widget Function(BuildContext context, Message message) replyPreview;

//   /// A function that builds the replied message widget.
//   final Widget Function(BuildContext context, Message message)
//       repliedMessageBuilder;

//   /// A function that handles message creation.
//   final Future<Message?> Function(BuildContext context, ChatUser author)
//       onMessageCreation;

//   /// The priority of the message type.
//   final ToolBarPriority priority;

//   /// Indicates whether the message is reactable.
//   final bool isReactable;

//   /// Indicates whether the message is swipeable.
//   final bool isSwipeable;

//   /// Indicates whether the message is inside a bubble.
//   final bool isInsideBubble;
// }
