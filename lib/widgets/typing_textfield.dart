import 'dart:async';

import 'package:flutter/material.dart';

class TypingTextField extends StatefulWidget {
  const TypingTextField(
      {super.key,
      this.onChanged,
      this.controller,
      required this.hintText,
      this.bgDecoration,
      this.decoration,
      this.formKey,
      this.validator,
      this.label,
      this.autofocus = false,
      this.initialValue,
      this.maxLines});
  final bool autofocus;
  final String hintText;
  final String? label;
  final InputDecoration? decoration;
  final int? maxLines;
  final BoxDecoration? bgDecoration;
  final Key? formKey;
  final String? initialValue;
  final void Function(String chunk)? onChanged;
  final String? Function(String? chunk)? validator;
  final TextEditingController? controller;
  @override
  // ignore: library_private_types_in_public_api
  _TypingTextFieldState createState() => _TypingTextFieldState();
}

class _TypingTextFieldState extends State<TypingTextField> {
  late final TextEditingController? _controller;
  late final ValueNotifier<String> _hintNotifier;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _hintNotifier = ValueNotifier('');
    _startTypingAnimation();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _startTypingAnimation() {
    final String hintText = widget.hintText;
    int index = 0;
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _hintNotifier.value = hintText.substring(0, index + 1);
      index = (index + 1) % hintText.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2000),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(6),
      child: ValueListenableBuilder(
        valueListenable: _hintNotifier,
        builder: (BuildContext context, String hintText, Widget? child) {
          return TextFormField(
            autofocus: widget.autofocus,
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: widget.formKey,
            controller: _controller,
            focusNode: _focusNode,
            maxLines: widget.maxLines,
            validator: widget.validator,
            decoration: widget.decoration
                    ?.copyWith(hintText: hintText, labelText: widget.label) ??
                InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
          );
        },
      ),
    );
  }
}
