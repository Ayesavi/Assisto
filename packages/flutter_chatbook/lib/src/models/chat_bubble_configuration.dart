import 'package:flutter/material.dart';

import '../values/typedefs.dart';
import 'models.dart';

class ChatBubbleConfiguration {
  /// Used for giving padding of chat bubble.
  final EdgeInsetsGeometry? padding;

  /// Used for giving margin of chat bubble.
  final EdgeInsetsGeometry? margin;

  /// Used for giving maximum width of chat bubble.
  final double? maxWidth;

  /// Provides callback when user long press on chat bubble.
  final Duration? longPressAnimationDuration;

  /// Provides configuration of other users message's chat bubble.
  final ChatBubble? inComingChatBubbleConfig;

  /// Provides configuration of current user message's chat bubble.
  final ChatBubble? outgoingChatBubbleConfig;

  /// Provides callback when user tap twice on chat bubble.
  final MessageCallBack? onDoubleTap;

  const ChatBubbleConfiguration({
    this.padding,
    this.margin,
    this.maxWidth,
    this.longPressAnimationDuration,
    this.inComingChatBubbleConfig,
    this.outgoingChatBubbleConfig,
    this.onDoubleTap,
  });
}
