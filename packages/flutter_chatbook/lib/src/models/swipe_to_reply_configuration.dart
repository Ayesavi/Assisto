import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import '../../flutter_chatbook.dart';

class SwipeToReplyConfiguration {
  /// Used to give color of reply icon while swipe to reply.
  final Color? replyIconColor;

  /// Used to give animation duration while swipe to reply.
  /// Duration for background builder [backgroundBuilder].
  final Duration? animationDuration;

  /// BackgroundBuilder on Swipe gesture.
  final Widget Function(BuildContext context, SwipeDirection direction,
      AnimationController progress, double value)? backgroundBuilder;

  /// Provides callback when user swipe chat bubble from left side.
  final void Function(Message message)? onLeftSwipe;

  /// Provides callback when user swipe chat bubble from right side.
  final void Function(Message message)? onRightSwipe;

  const SwipeToReplyConfiguration({
    this.replyIconColor,
    this.animationDuration,
    this.onRightSwipe,
    this.backgroundBuilder,
    this.onLeftSwipe,
  });
}
