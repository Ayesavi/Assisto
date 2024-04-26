import 'dart:async';

import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TypingTextField extends StatefulWidget {
  const TypingTextField({super.key, this.controller, this.onSend});
  final void Function(String key)? onSend;
  final TextEditingController? controller;
  @override
  // ignore: library_private_types_in_public_api
  _TypingTextFieldState createState() => _TypingTextFieldState();
}

class _TypingTextFieldState extends State<TypingTextField> {
  String _hintText = '';
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final List<Color> _borderColors = [Colors.pink, Colors.blue, Colors.yellow];
  int _currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _startTypingAnimation();
    _startBorderAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTypingAnimation() {
    const String hintText =
        'I can drive, good at cleaning and provide services like driving, househelp, homework and teaching.';
    int index = 0;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _hintText = hintText.substring(0, index + 1);
        index = (index + 1) % hintText.length;
      });
    });
  }

  void _startBorderAnimation() {
    Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _borderColors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onInverseSurface),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: _hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          const Padding(padding: kWidgetHorizontalPadding),
          IconButton(
              onPressed: () => widget.onSend?.call(_controller.text),
              icon: SizedBox.square(
                  dimension: 35,
                  child: SvgPicture.asset(Assets.graphics.loginWelcome))),
          const Padding(padding: kWidgetHorizontalPadding),
        ],
      ),
    );
  }
}
