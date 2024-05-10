import 'package:flutter/material.dart';
import '../../flutter_chatbook.dart';

class ChatBubble {
  /// Used for giving color of chat bubble.
  final Color? color;

  /// Used for giving border radius of chat bubble.
  final BorderRadiusGeometry? borderRadius;

  /// Used for giving text style of chat bubble.
  final TextStyle? textStyle;

  /// Used for giving padding of chat bubble.
  final EdgeInsetsGeometry? padding;

  /// Used for giving margin of chat bubble.
  final EdgeInsetsGeometry? margin;

  /// Used to provide configuration of messages with link.
  final LinkPreviewConfiguration? linkPreviewConfig;

  /// Used to give text style of message sender name.
  final TextStyle? senderNameTextStyle;

  /// Callback when a message has been displayed for the first
  /// time only
  final Function(Message message)? onMessageRead;

  const ChatBubble({
    this.color,
    this.borderRadius,
    this.textStyle,
    this.padding,
    this.margin,
    this.linkPreviewConfig,
    this.senderNameTextStyle,
    this.onMessageRead,
  });
}
