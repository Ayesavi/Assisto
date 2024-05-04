import 'dart:async';

import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TypingAITextField extends StatefulWidget {
  const TypingAITextField({super.key, this.controller, this.onSend});
  final Future<void> Function(String key)? onSend;
  final TextEditingController? controller;
  @override
  // ignore: library_private_types_in_public_api
  _TypingTextFieldState createState() => _TypingTextFieldState();
}

class _TypingTextFieldState extends State<TypingAITextField> {
  late final TextEditingController _controller;
  late final ValueNotifier<String> _hintNotifier;
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _progressNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hintNotifier = ValueNotifier('');
    _startTypingAnimation();
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
      _hintNotifier.value = hintText.substring(0, index + 1);
      index = (index + 1) % hintText.length;
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
            child: ValueListenableBuilder(
              valueListenable: _hintNotifier,
              builder: (BuildContext context, String hintText, Widget? child) {
                return TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                );
              },
            ),
          ),
          const Padding(padding: kWidgetHorizontalPadding),
          ValueListenableBuilder(
            valueListenable: _progressNotifier,
            builder: (BuildContext context, bool progress, Widget? child) {
              return IconButton(
                  onPressed: () async {
                    try {
                      if (_controller.text.trim().isNotEmpty) {
                        _progressNotifier.value = true;
                        await widget.onSend?.call(_controller.text);
                        _progressNotifier.value = false;
                      }
                      _controller.clear();
                    } catch (e) {
                      _progressNotifier.value = false;
                      rethrow;
                    }
                  },
                  icon: SizedBox.square(
                      dimension: 35,
                      child: progress
                          ? const CircularProgressIndicator()
                          : SvgPicture.asset(Assets.graphics.loginWelcome)));
            },
          ),
          const Padding(padding: kWidgetHorizontalPadding),
        ],
      ),
    );
  }
}
