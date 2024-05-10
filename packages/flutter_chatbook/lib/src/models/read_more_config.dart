import 'package:flutter/material.dart';

/// The `ReadMoreConfig` class is a configuration class that allows you to customize the behavior and appearance of a "Read More" functionality for a [TextMessageView] in [ChatBook].
/// It provides optional parameters that can be used to control the number of words after which the "Read More" feature should be enabled, the widget to be displayed as the "Read More" button,
/// and the styling options for the "Read More" button.
///
/// {@tool snippet}
/// Here's an example of how to use the `ReadMoreConfig` class:
///
/// ```dart
/// ReadMoreConfig config = ReadMoreConfig(
///   numOfWordsAfterEnableReadMore: 400,
///   readMoreWidget: const Text('Read More'),
/// );
/// ```
/// {@end-tool}

class ReadMoreConfig {
  /// Word limit after which readmore should be come visible
  /// default limit is 400
  final int? numOfWordsAfterEnableReadMore;

  ///  A custom Widget for readmore clickable at the ending of the text after
  /// the [numOfWordsAfterEnableReadMore] limit reached, default widget is
  /// ```dart
  /// Text("Read More")
  /// ```
  final Widget? readMoreWidget;

  ReadMoreConfig({
    this.numOfWordsAfterEnableReadMore,
    this.readMoreWidget,
  });
}
