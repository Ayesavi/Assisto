import 'package:flutter/material.dart';

class TagsInput extends StatefulWidget {
  final List<String> initialTags;
  final Function(List<String>) onTagsChanged;
  final TextStyle tagStyle;
  final InputDecoration textfieldDecoration;

  const TagsInput({
    super.key,
    required this.initialTags,
    required this.onTagsChanged,
    this.tagStyle = const TextStyle(),
    this.textfieldDecoration = const InputDecoration(hintText: "Add a tag"),
  });

  @override
  State<TagsInput> createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final _tagController = TextEditingController();
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _tags = [...widget.initialTags];
  }

  void _addTag(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _tags.add(text);
        _tagController.clear();
        widget.onTagsChanged(_tags); // Notify about tag changes
      });
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
      widget.onTagsChanged(_tags); // Notify about tag changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 5, // Add spacing between chips
            children: [
              for (int i = 0; i < _tags.length; i++)
                Chip(
                  label: Text(_tags[i], style: widget.tagStyle),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => _removeTag(i),
                ),
              TextField(
                controller: _tagController,
                decoration: widget.textfieldDecoration,
                onChanged: (text) {
                  if (text.trimLeft().isNotEmpty &&
                      text.trimLeft().contains(' ')) {
                    _addTag(text.trimLeft());
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
