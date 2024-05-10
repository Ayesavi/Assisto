import 'package:flutter/material.dart';
import '../models/text_message_parser.dart';

/// Controller for the [TextField] on [Input] widget
/// To highlighting the matches for pattern
class InputTextFieldController extends TextEditingController {
  /// A map of style to apply to the text pattern.

  final List<TextMessageParser> _listTextMessageParser = [
    TextMessageParser.bold,
    TextMessageParser.italic,
    TextMessageParser.lineThrough,
    TextMessageParser.code,
   
  ];

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final children = <TextSpan>[];

    /// chatusers here.
    final users = ["@yogesh dubey"];

    text.splitMapJoin(
      RegExp(_listTextMessageParser.map((it) => it.regExp.pattern).join('|')),
      onMatch: (match) {
        String text = match[0]!;
        final newStyle = _listTextMessageParser
            .firstWhere((element) => element.regExp.hasMatch(text))
            .textStyle;

        if (text.startsWith('@')) {
          if (users.contains(text)) {
            final span = TextSpan(text: match.group(0), style: newStyle);
            children.add(span);
            return span.toPlainText();
          } else {
            final span = TextSpan(text: text, style: style);
            children.add(span);
            return span.toPlainText();
          }
        } else {
          final span = TextSpan(text: text, style: newStyle);
          children.add(span);
          return span.toPlainText();
        }
      },
      onNonMatch: (text) {
        final span = TextSpan(text: text, style: style);
        children.add(span);
        return span.toPlainText();
      },
    );

    return TextSpan(style: style, children: children);
  }
}
