import 'dart:async';

import 'package:assisto/core/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final List<String> hintTexts;
  final bool readOnly;
  final String? initialSentence;
  final VoidCallback? onPressed;
  final TextEditingController? textController;
  final bool triggerSearchOnChange;
  final void Function(String key)? onSearch;
  const SearchTextField({
    super.key,
    this.hintTexts = const [
      'Laptop',
      'Stabliser',
      'Computer',
      'Iron',
      'Weight Blocks'
    ],
    this.readOnly = false,
    this.onPressed,
    this.initialSentence,
    this.onSearch,
    this.triggerSearchOnChange = false,
    this.textController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _hintIndex;
  late Timer _timer;
  late final TextEditingController _txtController;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  bool crossIconVisible = false;

  @override
  void initState() {
    super.initState();
    _hintIndex = 0;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _txtController = widget.textController ?? TextEditingController();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _controller.reverse().then((_) {
        setState(() {
          _hintIndex = (_hintIndex + 1) % widget.hintTexts.length;
        });
        _controller.forward();
      });
    });
    if (widget.triggerSearchOnChange) {
      _txtController.addListener(() {
        if (_txtController.text.trim().isEmpty && crossIconVisible) {
          setState(() {
            crossIconVisible = false;
          });
        }
        if (_txtController.text.trim().isNotEmpty) {
          if (!crossIconVisible) {
            setState(() {
              crossIconVisible = true;
            });
          }
          _debouncer.call(() {
            widget.onSearch?.call(_txtController.text);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                widget.onSearch?.call(value);
              },
              keyboardType: TextInputType.text,
              controller: _txtController,
              readOnly: widget.readOnly,
              onTap: widget.onPressed,
              decoration: InputDecoration(
                hintText: widget.initialSentence != null
                    ? "${widget.initialSentence} '${widget.hintTexts[_hintIndex]}'"
                    : "Try search for '${widget.hintTexts[_hintIndex]}'",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: crossIconVisible
                ? () {
                    _txtController.clear();
                  }
                : widget.onPressed,
            icon: Icon(
              crossIconVisible
                  ? CupertinoIcons.xmark_circle_fill
                  : Icons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
