import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

/// A class for parsing and processing text messages with formatting rules.
class TextMessageParser {
  /// Creates a TextMessageParser.
  ///
  /// - `name` (required): A unique identifier for the parser.
  /// - `from` (required): A pattern specifying the starting delimiter for formatting.
  /// - `regExp` (required): A regular expression pattern defining the complete formatting rule.
  /// - `replace` (required): A function for replacing the matched text with the desired content.
  /// - `textStyle` (required): The Flutter `TextStyle` to apply to the formatted text.
  /// - `atSource` (optional): A source identifier for the "@" symbol (used for mentioning users).
  /// - `onTap` (optional): A callback function executed when the formatted text is tapped.
  const TextMessageParser({
    required this.name,
    required this.from,
    required this.regExp,
    required this.replace,
    required this.textStyle,
    this.atSource,
    this.onTap,
  });

  final Pattern from;
  final RegExp regExp;
  final String Function(String str) replace;
  final TextStyle textStyle;
  final String name;
  final String? atSource;
  final void Function(String)? onTap;

  /// Gets the regular expression pattern associated with the parser.
  String get pattern => regExp.pattern;

  /// Predefined factory method to create a parser for bold text formatting.
  static TextMessageParser get bold => TextMessageParser(
        name: 'bold',
        from: RegExp('(\\*\\*|\\*)'),
        regExp: RegExp('(\\*\\*|\\*)(.*?)(\\*\\*|\\*)'),
        replace: (str) => '',
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      );

  /// Predefined factory method to create a parser for code text formatting.
  static TextMessageParser get code => TextMessageParser(
        name: "code",
        from: '`',
        regExp: RegExp('`(.*?)`'),
        replace: (str) => '',
        textStyle: TextStyle(
          fontFamily: (!kIsWeb && Platform.isIOS) ? 'Courier' : 'monospace',
        ),
      );

  /// Predefined factory method to create a parser for italic text formatting.
  static TextMessageParser get italic => TextMessageParser(
        name: 'italic',
        from: '_',
        regExp: RegExp('_(.*?)_'),
        replace: (str) => '',
        textStyle: const TextStyle(fontStyle: FontStyle.italic),
      );

  /// Predefined factory method to create a parser for strikethrough text formatting.
  static TextMessageParser get lineThrough => TextMessageParser(
        name: 'linethrough',
        from: '~',
        regExp: RegExp('~(.*?)~'),
        replace: (str) => '',
        textStyle: const TextStyle(decoration: TextDecoration.lineThrough),
      );
}

// Usage:
// Example usage of the TextMessageParser class is provided in the code comments.
