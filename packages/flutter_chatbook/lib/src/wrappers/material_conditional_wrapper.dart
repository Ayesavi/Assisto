import 'package:flutter_chatbook/src/wrappers/condition_wrapper.dart';
import 'package:flutter/material.dart';

/// A widget that conditionally applies a material wrapper around its child widget.
///
/// The [MaterialConditionalWrapper] is a convenience widget that conditionally wraps its child widget
/// with a [Material] widget based on a provided condition.
/// When the condition is true, the child widget is wrapped with a [Material] widget
/// with a transparency type, which ensures that the material properties are applied to the child.
/// When the condition is false, the child widget is returned as is without any wrapping.
///
/// The [condition] determines whether the child widget should be wrapped with a material widget.
/// The [child] is the widget that will be conditionally wrapped.
///
/// This widget is useful when you need to conditionally apply material properties to a widget,
/// such as when switching between different app designs (e.g., Material and Cupertino).
///
/// Usage:
/// ```dart
/// MaterialConditionalWrapper(
///   condition: widget.isCupertinoApp,
///   child: MyWidget(),
/// )
/// ```
class MaterialConditionalWrapper extends StatelessWidget {
  const MaterialConditionalWrapper({
    Key? key,
    this.condition = false,
    required this.child,
  }) : super(key: key);

  /// The condition that determines whether the child widget should be wrapped with a material widget.
  final bool condition;

  /// The child widget that will be conditionally wrapped.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      condition: condition,
      wrapper: (widget) => Material(
        type: MaterialType.transparency,
        child: widget,
      ),
      child: child,
    );
  }
}
