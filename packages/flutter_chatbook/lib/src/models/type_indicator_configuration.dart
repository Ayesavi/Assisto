import 'package:flutter/material.dart';

class TypeIndicatorConfiguration {
  /// Used for giving typing indicator size.
  final double? indicatorSize;

  /// Used for giving spacing between indicator dots.
  final double? indicatorSpacing;

  /// Used to give color of dark circle dots.
  final Color? flashingCircleDarkColor;

  /// Used to give color of light circle dots.
  final Color? flashingCircleBrightColor;

  const TypeIndicatorConfiguration({
    this.indicatorSize,
    this.indicatorSpacing,
    this.flashingCircleDarkColor,
    this.flashingCircleBrightColor,
  });
}
