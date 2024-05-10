import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../flutter_chatbook.dart';

class ChatBackgroundConfiguration {
  /// Provides background color of chat view.
  final Color? backgroundColor;

  /// Provides background image of chat view.
  final String? backgroundImage;

  /// Provides padding of chat view.
  final EdgeInsetsGeometry? padding;

  /// Provides margin of chat view.
  final EdgeInsetsGeometry? margin;

  /// Provides height of chat view.
  final double? height;

  /// Provides width of chat view.
  final double? width;

  /// Provides configurations of chat separator widget.
  final StringWithReturnWidget? groupSeparatorBuilder;

  /// Used to define the order of a [GroupedListView] or [SliverGroupedListView].
  final GroupedListOrder groupedListOrder;

  /// Used to enable sort in list view.
  final bool sortEnable;

  /// Used to give text style of message's time while user swipe to see time of
  /// message.
  final TextStyle? messageTimeTextStyle;

  /// Used to give colour of message's time while user swipe to see time of
  /// message.
  final Color? messageTimeIconColor;

  /// Used to give configuration of default chat separator widget.
  final DefaultGroupSeparatorConfiguration? defaultGroupSeparatorConfig;

  /// Used for giving widget while data is loading.
  final Widget? loadingWidget;

  /// For custom groupBy, default is on the basis of day
  final String Function(Message message)? groupBy;

  /// Used to give curve of animation which runes while user swipe to see time of
  /// message.
  final Curve messageTimeAnimationCurve;

  const ChatBackgroundConfiguration({
    this.defaultGroupSeparatorConfig,
    this.backgroundColor,
    this.backgroundImage,
    this.height,
    this.width,
    this.groupSeparatorBuilder,
    this.groupedListOrder = GroupedListOrder.ASC,
    this.sortEnable = false,
    this.padding,
    this.groupBy,
    this.margin,
    this.messageTimeTextStyle,
    this.messageTimeIconColor,
    this.loadingWidget,
    this.messageTimeAnimationCurve = Curves.decelerate,
  });
}

class DefaultGroupSeparatorConfiguration {
  /// Used for giving padding of chat separator widget.
  final EdgeInsetsGeometry? padding;

  /// Used for giving text style of chat separator widget.
  final TextStyle? textStyle;

  const DefaultGroupSeparatorConfiguration({
    this.padding,
    this.textStyle,
  });
}
