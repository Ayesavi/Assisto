import 'package:flutter_chatbook/src/values/typedefs.dart';
import 'package:flutter/material.dart';

class LinkPreviewConfiguration {
  /// Used for giving background colour of message with link.
  final Color? backgroundColor;

  /// Used for giving border radius of message with link.
  final double? borderRadius;

  /// Used for giving text style of body text in message with link.
  final TextStyle? bodyStyle;

  /// Used for giving text style of title text in message with link.
  final TextStyle? titleStyle;

  /// Used for giving text style of link text in message with link.
  final TextStyle? linkStyle;

  /// Used for giving colour of loader in message with link.
  final Color? loadingColor;

  /// Used for giving padding to message with link.
  final EdgeInsetsGeometry? padding;

  /// Used for giving proxy url to message with link.
  final String? proxyUrl;

  /// Provides callback when message detect url in message.
  final StringCallback? onUrlDetect;

  const LinkPreviewConfiguration({
    this.onUrlDetect,
    this.loadingColor,
    this.backgroundColor,
    this.borderRadius,
    this.bodyStyle,
    this.titleStyle,
    this.linkStyle,
    this.padding,
    this.proxyUrl,
  });
}
